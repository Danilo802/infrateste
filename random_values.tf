resource "random_password" "password" {
    length = 30
    special = true
    override_special = "!#$%&()*+-:<=>?_{|}~"
  
}

resource "random_string" "random_id" {
    length = 5
    special = false
  
}