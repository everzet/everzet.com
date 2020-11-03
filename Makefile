.PHONY: clean build

PROFILE ?= default
REGION ?= us-east-1
S3_PREFIX ?= $(STACK)
CAPABILITIES ?= CAPABILITY_IAM CAPABILITY_AUTO_EXPAND

install:
	npm --prefix website install

build:
	npm --prefix website run build
	touch website/dist/requirements.txt
	sam build --profile ${PROFILE} --region ${REGION}

deploy:
	sam deploy  --profile ${PROFILE} --region ${REGION} --stack-name ${STACK} --s3-bucket ${S3_BUCKET} --s3-prefix ${S3_PREFIX} --capabilities ${CAPABILITIES}
	aws cloudformation describe-stacks --profile ${PROFILE} --region ${REGION} --stack-name ${STACK} --query Stacks[].Outputs --output text
