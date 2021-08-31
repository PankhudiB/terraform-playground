
    We are spinning up in local
    provider "docker" {} -> kept empty -> if it had been aws -> then region and all needs to be there
    
    once u do terraform init 
    -> u ll see a binary in .terraform directory 
    -> terraform uses this go binary to access the docker API

    
    