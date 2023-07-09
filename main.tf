terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

data "tls_certificate" "default" {
  url = "https://github.com"
}

resource "random_id" "id" {
  keepers = {
    first = timestamp()
  }
  byte_length = 8
}

output "generated_random_id" {
  value = random_id.id.hex
}

output "github_com_sha1_fingerprint" {
  value =  data.tls_certificate.default.certificates[0].sha1_fingerprint
}

output "github_mock_secret" {
  value =  data.tls_certificate.default.certificates[1].sha1_fingerprint
  sensitive = true
}
