ifeq ($(FFPROBE_DISTRIBUTABLES),)
$(error You need to specify the ffprobe distributables location, i.e. the generated libs)
endif

ifeq ($(DEPLOYMENT_BUCKET),)
$(error You need to deployment bucket for cloudformation)
endif

STACK_NAME_PREFIX=ffprobe-dynamic
# this should be identical to version in build-ffmpeg script
# we cannot have `.` in the stack name so use `-`
FFPROBE_VERSION=7-0

STACK_NAME=$(STACK_NAME_PREFIX)-$(FFPROBE_VERSION)-arm64-lambda-layer

$(info STACK_NAME is $(STACK_NAME))


clean: 
	rm -rf build

build/layer/bin/ffprobe: 
	mkdir -p build/layer/bin
	cp $(FFPROBE_DISTRIBUTABLES)/* build/layer/bin

build/output.yaml: template.yaml build/layer/bin/ffprobe
	aws cloudformation package --template $< --s3-bucket $(DEPLOYMENT_BUCKET) --output-template-file $@

deploy: build/output.yaml
	aws cloudformation deploy --template $< --stack-name $(STACK_NAME) --parameter-overrides "ffprobeVersion=$(FFPROBE_VERSION)"
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs --output table

