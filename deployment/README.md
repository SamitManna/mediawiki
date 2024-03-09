kustomize-mediawiki
├── base
│   ├── kustomization.yaml
│   ├── mariadb-deployment.yaml
│   ├── mariadb-service.yaml
│   ├── mediawiki-deployment.yaml
│   └── mediawiki-service.yaml
└── overlays
    ├── development
    │   ├── kustomization.yaml
    │   └── patch-mariadb-deployment.yaml
    └── production
        ├── kustomization.yaml
        └── patch-mariadb-deployment.yaml