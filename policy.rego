package k8srequiredlabels

          gcp_region := ["us"]
          owner := ["hybridenv"]
          application_division := ["pci", "paa", "hdpa", "hra"]
          application_name := []
          application_role := ["app", "web", "auth", "data"]
          environment := ["prod", "int", "uat", "stage", "dev", "test"]
          au := []
          created := []
        
          violation[{"msg": msg}] {
          provided := {label | input.metadata.labels[label]}
          required := {label | label := data.spec.parameters.labels[_]}
          missing := required - provided
          count(missing) > 0
          msg := sprintf("you must provide labels: %v", [missing])
        }
        
         violation[{"msg": msg}] {
         not is_gcp_region
         msg := "gcp_region violation"
        }
         violation[{"msg": msg}] {
         not is_owner
         msg := "owner violation"
        }
         violation[{"msg": msg}] {
         not is_application_division
         msg := "application division violation"
        }
         violation[{"msg": msg}] {
         not is_application_role
         msg := "application role violation"
        }
         violation[{"msg": msg}] {
         not  is_environment
         msg := "environment violation"
        }

        is_gcp_region {
          some i
          input.metadata.labels["gcp_region"] == gcp_region[i] 
        }
        
         is_owner {
          some i
          input.metadata.labels["owner"] == owner[i] 
        }
        
        is_application_division {
          some i
          input.metadata.labels["application_division"] == application_division[i]
        }

        is_application_role{
         some i
         application_role[i] == input.metadata.labels["application_role"]
          
        }
        
        is_environment {
          some i
          input.metadata.labels["environment"] == environment[i] 
          msg := sprintf("you must provide environment : %v", [environment])
        }

