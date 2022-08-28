###################################################
# Script or Cloud Config on User-Data
###################################################

locals {
  user_data_replace_on_change = try(var.user_data.replace_on_change, false)
  user_data_encoding          = try(var.user_data.encoding, "PLAINTEXT")
  user_data_mime_enabled      = try(var.user_data.mime_enabled, false)
  user_data_content = {
    "PLAINTEXT"   = try(var.user_data.content, "")
    "BASE64"      = base64encode(try(var.user_data.content, ""))
    "BASE64_GZIP" = base64gzip(try(var.user_data.content, ""))
  }[local.user_data_encoding]

  user_data = (local.user_data_mime_enabled
    ? data.cloudinit_config.this[0].rendered
    : local.user_data_content
  )

  user_data_checksum = sha256(local.user_data)
}


###################################################
# MIME Multi Part Archive on User-Data
###################################################

data "cloudinit_config" "this" {
  count = local.user_data_mime_enabled ? 1 : 0

  gzip          = local.user_data_encoding == "BASE64_GZIP"
  base64_encode = contains(["BASE64", "BASE64_GZIP"], local.user_data_encoding)

  dynamic "part" {
    for_each = try(var.user_data.mime_parts, [])

    content {
      content = part.value.content

      filename     = try(part.value.filename, "user-data-mime-multipart-${part.key}")
      content_type = join("/", ["text", try(part.value.content_type, "x-shellscript")])
      merge_type   = try(part.value.merge_type, null)
    }
  }
}
