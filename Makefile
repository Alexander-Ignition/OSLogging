project:
	swift package generate-xcodeproj --enable-code-coverage --skip-extra-files

build:
	swift build

test:
	swift test --enable-code-coverage

clean:
	swift package clean
