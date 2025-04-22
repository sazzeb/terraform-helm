output "checklist_release_status" {
  description = "The status of the Helm release"
  value       = helm_release.checklist.status
}

output "checklist_namespace" {
  description = "The namespace where Checklist is deployed"
  value       = helm_release.checklist.namespace
}
