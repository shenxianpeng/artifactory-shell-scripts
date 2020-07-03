# `devops-toolkit`

List same of toolkit when I am a DevOps engineer.

## Artifactory

[Artifactory REST API](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API) implement in shell

These shell also refer to other [examples](https://github.com/jfrog/project-examples.git)

**When using these scripts, be sure to test adequately in your test environment to understand expectations. At one's own risk.**

## Have implemented

1. Deploy a local file to Artifactory keeping the same file name\

    `$ deploy-file.sh localFilePath targetFolder`
    
2. Recursively deploys folder content. Attempt checksum deploy first to optimize upload time.

    `$ deploy-folder-by-checksum.sh localFileFolder targetRepoName`
    
3. Download a date range of files from Artifactory

    `$ download-in-date-range.sh`
    
4. Cleanup a date range of files form Artifactory

    `$ cleanup-artifacts.sh`
    
    TODO: cleanup empty folder.
