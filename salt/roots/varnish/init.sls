base:
  pkgrepo.managed:
    - humanname: VarnishCache
    - name: deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0
    - dist: precise
    - file: /etc/apt/sources.list.d/varnish.list
    - skip_verify: True
    - require_in:
      - pkg: varnish

varnish:
  pkg.installed

