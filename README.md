# UptimeKuma.Azure.AppService.Docker.SSH.Sample

## Reference
- https://learn.microsoft.com/en-us/azure/app-service/configure-linux-open-ssh-session
- https://learn.microsoft.com/en-us/azure/app-service/configure-custom-container?tabs=debian&pivots=container-linux
- 
## Note
- `init.sh` should be saved as `LF`, otherwise it will display an error `set: Illegal option -`
  - ``` sh
    init.sh: 2: set: Illegal option -
    ```
- When installing the SSH-related packages required for Azure App Service, you need to add export `DEBIAN_FRONTEND=noninteractive` before the apt-get install command to avoid getting stuck in the `interactive mode` of `apt-get`.
  - ``` sh
    => [5/5] RUN apt-get update     && apt-get install -y --no-install-recommends dialog     && apt-get    install -y -  8.8s
    => => #   1. install the package maintainer's version
    => => #   2. keep the local version currently installed
    => => #   3. show the differences between the versions
    => => #   4. show a side-by-side difference between the versions
    => => #   5. start a new shell to examine the situation
    => => # What do you want to do about modified configuration file sshd_config?
    ```
  - https://blog.csdn.net/oguro/article/details/102840215
  - https://www.cyberciti.biz/faq/explain-debian_frontend-apt-get-variable-for-ubuntu-debian/
- The official documentation suggests using `CMD ["init.sh"]` in the Dockerfile, but after running `docker run`, the file cannot be found. To solve this issue, you need to use `CMD ["sh","init.sh"]` instead.
  - ``` sh
    setpriv: failed to execute init.sh: No such file or directory
    ```