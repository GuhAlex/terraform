variable vault_secret_path {
  type    = string
  default = "kv/aws"
}

variable vault_url {
  type    = string
  default = "http://vault.local"
}

variable vault_token {
  type    = string
  default = ""
}

variable vautl_tls_verify {
  default = true
}

variable aws_region {
  type    = string
  default = "us-east-1"
}

variable user1 {
  type    = string
  default = "davis"
}

variable user2 {
  type    = string
  default = "coltrane"
}
