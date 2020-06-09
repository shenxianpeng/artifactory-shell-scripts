# `artifactory-shell-scripts`

[Artifactory REST API](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API) implement in shell

These shell also refer to other examples blow

* https://github.com/jfrog/project-examples.git

## Usages

### `deploy-folder-by-checksum.sh`

#### Example 1

1. Your artifactory repository named `generic-release-local`
2. Your files saved in the directory that you are going to upload is should also named `generic-release-local`
3. Then, run below command
  ```bash
  $ ls
  generic-release-local
  $ sh deploy-folder-by-checksum.sh generic-release-local
  ```
