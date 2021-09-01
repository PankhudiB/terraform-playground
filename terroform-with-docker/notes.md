
    Always check-in terraform.lock file
    Mention version inside provider -> to avoid auto upgrade of packages 
    -> hashes are maintained
    -> even if u manually change the version in required_providers block 
        -> it wont change the actual infra until you run "terraform init upgrade"

    -> in required_providers -> "~> 2.xyz.abc"
    the ~> makes sure that number version does not go beyond second last decimal

    eg ~> 2.12.0 -> it can allow 2.12.xyz...
    eg ~> 2.15 -> it can allow 2.xyz...
-------------    
    We are spinning up in local
    provider "docker" {} -> kept empty -> if it had been aws -> then region and all needs to be there
    
    once u do terraform init 
    -> u ll see a binary in .terraform directory 
    -> terraform uses this go binary to access the docker API
-------------

    Resource -> is an infrastructure component
    in our example its a docker image -> name -> actual image name
    
    After running terraform apply -> and you do "docker images" in local -> u ll find the image u put in resource

-------------

    Referencing 1 resource from another

-------------
    TF State -> terraform.tfstate 
        -> serial is updated everytime (eg resource ..) 
        -> lineage created -> when deployment is initially created 
        -> bcoz of dependency section -> TF knows in which order to apply || destroy infra
            -> in our docker container case -> fetching the docker image is dependency
    
    terraform.tfstate.backup -> a backcup

    Running tf destroy -> clears the terraform.tfstate 
        -> but the last state is always maintained in the .backup
    
    * terraform.tfstate not encrypted by default
    
    * PRO tip:
 
    install jq to access tfstate
    Use "terraform show -json | jq"

    * terraform state list -> shows all resource
-------------    
    
    TF output 
    -> u can see only after u have atleast done tf apply once
    -> u can evaluate it in tf console too

    "terraform output"
-------------

    What if now you want multiple resources of the same type 
    example - in our case multiple docker containers
    instead of duplicating the resource multiple times
    -> use random_string resource 
-------------

    Now i want 2 random_strings without listing them twice
    Use Count feature

    2 random_string & 2 nodered_container
    use count.index
    -> also u ll need 2 external port -> if u just remove -> tf will randomly assign -> so leave it on to tf 
    
    U cant use count.index in output |
    It can only be used in module , resource & data blocks
-------------

    how do u use DRY for output
    Splat -> [*] & for loop
-------------

    Tainting 
     -> force a resource to destroy and re apply
     -> rebooting a daemon or service
     -> for reload config 
    better described : https://www.terraform.io/docs/cli/commands/taint.html

    Import 
    you can import a container using tf import
    and each resource has how it can be imported -> in our case docker container id

-------------

    Terraform variable
-------------
    
    .tf the name doesnt matter
-------------

    Security of variables
    -> always add terraform.tfvars in gitignore
    add "int_port = 1880" in terraform.tfvars

-------------
    u can type in sensitive=true in the variable -> to not let it show in tf plan
-------------