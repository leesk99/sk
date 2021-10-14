Expected to Be Configured
-------------------------

* `nginx_reverse_proxy_proxies`:  리버스 프록시 목록을 구성한다. 각 구성에는 아래 변수가 필요하다.
  * `nginx_reverse_proxy_backend_name:` 문자열이어야 하며, Nginx가 백엔드를 참조할 때 사용하는 이름이다.
  * `nginx_reverse_proxy_domains`: list of public-facing domains to be proxied
  * `nginx_reverse_proxy_backends`: list of backend servers, including ports and [other valid parameters for `server` in the `upstream` context of an nginx config file](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#server)
  * `nginx_reverse_proxy_config_name`: name to use for the proxy file (do not include the '.conf' extension, role will add this)

Example Playbook
----------------

```yaml
---
# file group_vars/nginx_docker_proxy

nginx_reverse_proxy_proxies:
  - config_name: app1proxy
    backend_name: my-backend-1
    backends:
      - localhost:1880 weight=2
      - localhost:1881
    domains:
      - app1.192.168.88.10.xip.io
    locations:
      - /path/   # In case your site is hosted on backend-name/path/
    root_redirect_location: /path/  # In case your site is hosted on backend-name/path/ and need to redirect to this site by default

  - config_name: app2proxy
    backend_name: my-backend-2
    backends:
      - localhost:1882
      - localhost:1883 backup  # will act as backup, and nginx only passes traffic when primary is unavailable.
    domains:
      - app2.192.168.88.10.xip.io
    balancer_config: least_conn; # Important to add semicolon at the end ; if not the config will break

```

License
-------

[MIT](LICENSE.txt)

Author Information
------------------

* Marvin Pinto

Collaborators
-------------

* Pablo Estigarribia (pablodav at gmail)

More documentation
------------------

https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/#taxing-rewrites

http://nginx.org/en/docs/http/ngx_http_upstream_module.html

Notes about nginx settings
--------------------------

When adding backends, if you prefer to add them using DNS ensure server can resolve the DNS name before starting nginx.
If nginx doesn't resolve the DNS name, it will not start.


Developers
----------

Help in autotest this role:
https://github.com/CoffeeITWorks/ansible-generic-help/blob/master/Developers.md
