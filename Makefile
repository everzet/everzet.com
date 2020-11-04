.PHONY: clean build

install:
	@echo "[website] installing dependecies"
	npm --prefix website install

build:
	@if [ -z "${AWS_PROFILE}" ]; then echo "AWS_PROFILE must be set to your local AWS profile"; false; fi
	@if [ -z "${AWS_REGION}" ]; then echo "AWS_REGION must be set to AWS region you want to deploy to"; false; fi

	@echo "[website] building distribution"
	@npm --prefix website run build

	@echo "[website] adding manifest for AWS SAM"
	@touch website/dist/requirements.txt

	@echo "[website] building AWS SAM package locally"
	@sam build --profile ${AWS_PROFILE} --region ${AWS_REGION}

deploy:
	@if [ -z "${AWS_PROFILE}" ]; then echo "AWS_PROFILE must be set to your local AWS profile"; false; fi
	@if [ -z "${AWS_REGION}" ]; then echo "AWS_REGION must be set to AWS region you want to deploy to"; false; fi
	@if [ -z "${CF_STACK}" ]; then echo "CF_STACK must be set to CloudFormation stack name you want to deploy to"; false; fi
	@if [ -z "${S3_BUILD_BUCKET}" ]; then echo "S3_BUILD_BUCKET must be set to S3 bucket you want your build packages to be uploaded to"; false; fi
	@if [ -z "${S3_BUILD_PREFIX}" ]; then echo "S3_BUILD_PREFIX must be set to S3 prefix (folder) you want your build packages to be uploaded to"; false; fi

	@echo "[website] deploying locally built package"
	@sam deploy  --profile ${AWS_PROFILE} --region ${AWS_REGION} --stack-name ${CF_STACK} --s3-bucket ${S3_BUILD_BUCKET} --s3-prefix ${S3_BUILD_PREFIX} --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND

	@echo "[website] printing stack outputs"
	@aws cloudformation describe-stacks --profile ${AWS_PROFILE} --region ${AWS_REGION} --stack-name ${CF_STACK} --query Stacks[].Outputs --output text
