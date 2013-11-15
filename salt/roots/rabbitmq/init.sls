system-pkgs:
  pkg:
    - installed
    - names:
      - erlang-nox
      - adduser
      - logrotate
    - require_in:
      - pkg: rabbitmq-server

base:
  pkgrepo.managed:
    - humanname: RabbitMQ Repo
    - name: deb http://www.rabbitmq.com/debian/ testing main
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
    - require_in:
      - pkg: rabbitmq-server

rabbitmq-server:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file:
        - /etc/default/rabbitmq-server
        - /etc/logrotate.d/rabbitmq-server
        - /etc/rabbitmq/rabbitmq.config

/etc/default/rabbitmq-server:
  file.managed:
    - source:
      - salt://rabbitmq/default.{{ grains['fqdn'] }}
      - salt://rabbitmq/default
    - mode: 644
    - require:
      - pkg: rabbitmq-server

/etc/logrotate.d/rabbitmq-server:
  file.managed:
    - source:
      - salt://rabbitmq/logrotate.{{ grains['fqdn'] }}
      - salt://rabbitmq/logrotate
    - mode: 644
    - require:
      - pkg: rabbitmq-server

/etc/rabbitmq/rabbitmq.config:
  file.managed:
    - source:
      - salt://rabbitmq/rabbitmq.config.{{ grains['fqdn'] }}
      - salt://rabbitmq/rabbitmq.config
    - mode: 644
    - require:
      - pkg: rabbitmq-server
