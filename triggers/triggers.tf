resource "harness_platform_triggers" "example" {
  for_each = toset(var.repo_names)

  name      = "${each.key}-trigger"  # The name of the trigger
  identifier = "${each.key}-trigger"
  org_id = "default"
  project_id = "parson"
  target_id = "Custom_CI_Builder"     # The ID of the pipeline/workflow that this trigger will execute
  yaml      = <<YAML
trigger:
  name: ${each.key}-trigger
  identifier: ${each.key}-trigger
  enabled: true
  description: Trigger for ${each.key}
  orgIdentifier: "default"
  projectIdentifier: "parson"
  pipelineIdentifier: "Custom_CI_Builder"
  tags:
    repo: "${each.key}"
  source:
    type: Webhook
    spec:
      type: Github
      spec:
        connectorRef: "parsongh"        # Make sure you replace this with a valid Github connector reference in Harness
        repoName: ${each.value}
        autoAbortPreviousExecutions: true
        actions:
          - PUSH                                 # Specify the event type (e.g., PUSH, PULL_REQUEST)
        payloadConditions:
          - key: ref
            operator: Equals
            value: refs/heads/main                # Example payload condition
  pipelineBranchName: <+trigger.branch>
  inputSetRefs:
    - test_input_set
YAML
}
