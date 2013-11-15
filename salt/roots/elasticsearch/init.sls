system-pkgs:
  pkg:
    - installed
    - names:
      - openjdk-7-jre-headless

elasticsearch:
  pkg.installed:
    - sources:
      - elasticsearch: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb
  service:
    - running
    - watch:
      - file:
        - /etc/default/elasticsearch
        - /etc/elasticsearch/elasticsearch.yml
        - /etc/elasticsearch/logging.yml

/etc/default/elasticsearch:
  file.managed:
    - source:
      - salt://elasticsearch/default.{{ grains['fqdn'] }}
      - salt://elasticsearch/default
    - mode: 644
    - require:
      - pkg: elasticsearch

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source:
      - salt://elasticsearch/elasticsearch.yml.{{ grains['fqdn'] }}
      - salt://elasticsearch/elasticsearch.yml
    - mode: 644
    - require:
      - pkg: elasticsearch

/etc/elasticsearch/logging.yml:
  file.managed:
    - source:
      - salt://elasticsearch/logging.yml.{{ grains['fqdn'] }}
      - salt://elasticsearch/logging.yml
    - mode: 644
    - require:
      - pkg: elasticsearch
