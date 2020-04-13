SHELL = /bin/bash
VERSIONS := 2.2 3.0 3.1

all: build

release: build tag release

build:
	VERSIONS="$(VERSIONS)" IMAGE_OS=CENTOS ./build.sh

tag:
	set -x ; for i in $(VERSIONS); do \
	    docker tag dotnet/dotnet-$${i//./}-centos7:latest getupcloud/dotnet-$${i//./}-centos7:$$i; \
	    docker tag dotnet/dotnet-$${i//./}-centos7:latest getupcloud/dotnet-$${i//./}-centos7:latest; \
	    docker tag dotnet/dotnet-$${i//./}-runtime-centos7:latest getupcloud/dotnet-$${i//./}-runtime-centos7:$$i; \
	    docker tag dotnet/dotnet-$${i//./}-runtime-centos7:latest getupcloud/dotnet-$${i//./}-runtime-centos7:latest; \
	done

push:
	for i in $(VERSIONS); do \
	    docker push getupcloud/dotnet-$${i//./}-centos7:latest; \
	    docker push getupcloud/dotnet-$${i//./}-centos7:$$i; \
	    docker push getupcloud/dotnet-$${i//./}-runtime-centos7:latest; \
	    docker push getupcloud/dotnet-$${i//./}-runtime-centos7:$$i; \
	done
