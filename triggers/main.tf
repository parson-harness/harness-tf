terraform {  
    required_providers {  
        harness = {  
            source = "harness/harness"  
            version = "0.34.1"  
        }  
    }  
}

provider "harness" {  
    endpoint   = "https://app.harness.io/gateway"  
    account_id = "SAsyUUHTTImuYSZ35HPDvw"  
    platform_api_key    = "REPLACE_WITH_API_KEY"
}
