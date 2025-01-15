# 📦 Docker Image Build and Publish Workflow

This reusable workflow automates the process of building a Docker image and publishing it to an Amazon Elastic Container Registry (ECR).

---

## ⚙️ Inputs

### Required Parameters

| Input                | Description                         | Required |
|----------------------|-------------------------------------|------------|
| `ecr_repository_name`| 🔑 The name of the ECR repository.  | ✅ |
| `image_tag`          | 🏷️ Tag for the Docker image.        | ✅ |
| `aws_region`         | 🌍 AWS region for the ECR repository. | ✅ |

### Optional Parameters

| Input                | Description                         | Default    |
|----------------------|-------------------------------------|------------|
| `path_to_dockerfile` | 🗂️ Path to the Dockerfile.          | `dockerfile` |
| `docker_build_dir`   | 📁 Directory for the Docker build.  | `.`          |


### Secrets

| Secret             | Description                          | Required |
|--------------------|--------------------------------------|----------|
| `aws_account_id`   | 🔐 AWS account ID for the ECR registry. | ✅       |

---

## 📝 Parameters Breakdown

- **`path_to_dockerfile`**: Path to the Dockerfile, e.g., `./web/dockerfile`.
- **`docker_build_dir`**: Directory where the build should run, e.g., `./web`.
- **`image_tag`**: Tag for the Docker image, provided as an input.
- **`ecr_repository_name`**: Name of the ECR repository, e.g., `revotech-group/sample-app-web`.
- **`aws_region`**: AWS region where the ECR is hosted, e.g., `us-east-1`.

---

## 🔧 Example Usage

Here’s how you can use this workflow in another repository:

```yaml
name: Docker image build and publish
on:
  workflow_dispatch:
    inputs:
      image_tag:
        description: Tag to apply to images.
        type: string
        required: true
      aws_region:
        description: Target AWS Region.
        default: "us-east-1"
        type: string

permissions:
  id-token: write
  contents: read

jobs:
  call-dockerize-workflow:
    uses: rezamafakheriii/ContainerCraft/.github/workflows/dockerize.yaml@main
    with:
      path_to_dockerfile: "./web/dockerfile"
      docker_build_dir: "./web"
      image_tag: ${{ inputs.image_tag }}
      ecr_repository_name: "revotech-group/sample-app-web"
      aws_region: ${{ inputs.aws_region }}
    secrets:
      aws_account_id: ${{ secrets.AWS_ECR_ACCOUNT_ID }}
```