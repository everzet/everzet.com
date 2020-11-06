.PHONY: start-website deploy

website/package-lock.json: website/package.json
	@echo "[website] updating dependencies"
	@npm --prefix website install
website/node_modules: website/package-lock.json
	@echo "[website] installing dependencies"
	@npm --prefix website ci
website/dist: website/node_modules website/src
	@echo "[website] building distribution"
	@npm --prefix website run build
start-website: website/node_modules
	@echo "[website] starting app locally on port 3000"
	@npm --prefix website start

.aws-sam/build: website/dist
	@echo "[website] adding empty AWS SAM manifest to the distribution"
	@touch website/dist/requirements.txt
	@echo "[aws] creating CloudFormation package"
	@sam build --profile ${AWS_PROFILE} --region ${AWS_REGION}

deploy: .aws-sam/build
	@echo "[aws] deploying CloudFormation package"
	@sam deploy --profile ${AWS_PROFILE} --region ${AWS_REGION} --stack-name ${CF_STACK} --s3-bucket ${S3_BUILD_BUCKET} --s3-prefix ${S3_BUILD_PREFIX} --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND
