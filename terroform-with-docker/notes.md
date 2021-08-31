
    Always check-in terraform.lock file
    Mention version inside provider -> to avoid auto upgrade of packages 
    -> hashes are maintained
    -> even if u manually change the version in required_providers block 
        -> it wont change the actual infra until you run "terraform init upgrade"

    -> in required_providers -> "~> 2.xyz.abc"
    the ~> makes sure that number version does not go beyond second last decimal

    eg ~> 2.12.0 -> it can allow 2.12.xyz...
    eg ~> 2.15 -> it can allow 2.xyz...
    
    
    We are spinning up in local
    provider "docker" {} -> kept empty -> if it had been aws -> then region and all needs to be there
    
    once u do terraform init 
    -> u ll see a binary in .terraform directory 
    -> terraform uses this go binary to access the docker API

    Resource -> is an infrastructure component
    in our example its a docker image -> name -> actual image name
    
    After running terraform apply -> and you do "docker images" in local -> u ll find the image u put in resource
    
    