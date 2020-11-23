# cardstackv2-docker

A Docker template for booting Cardstack v2 with sample Fuga cards

# Development

- docker-compose up --build

# Production (Considering you created a context named remote pointing to the EC2 instance)

- docker-compose --context=remote --env-file=prod.env up
