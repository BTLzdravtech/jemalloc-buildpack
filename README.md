# Cloud Native jemalloc buildpack

[jemalloc](http://jemalloc.net/) is a general purpose malloc implementation
that works to avoid memory fragmentation in multithreaded applications. This
buildpack makes it easy to install and use jemalloc on compatible
platforms.

## Configuration

### JEMALLOC_VERSION

Set this to select or pin to a specific version of jemalloc. The default is to
use the latest stable version if this is not set. You will receive an error
mentioning tar if the version does not exist.

**Default**: `5.3.0`

**note:** This setting is only used during slug compilation. Changing it will
require a code change to be deployed in order to take affect.

#### Available Versions

| Version                                                          | Released   |
| ---------------------------------------------------------------- | ---------- |
| [3.6.0](https://github.com/jemalloc/jemalloc/releases/tag/3.6.0) | 2015-04-15 |
| [4.0.4](https://github.com/jemalloc/jemalloc/releases/tag/4.0.4) | 2015-10-24 |
| [4.1.1](https://github.com/jemalloc/jemalloc/releases/tag/4.1.1) | 2016-05-03 |
| [4.2.1](https://github.com/jemalloc/jemalloc/releases/tag/4.2.1) | 2016-06-08 |
| [4.3.1](https://github.com/jemalloc/jemalloc/releases/tag/4.3.1) | 2016-11-07 |
| [4.4.0](https://github.com/jemalloc/jemalloc/releases/tag/4.4.0) | 2016-12-04 |
| [4.5.0](https://github.com/jemalloc/jemalloc/releases/tag/4.5.0) | 2017-02-28 |
| [5.0.1](https://github.com/jemalloc/jemalloc/releases/tag/5.0.1) | 2017-07-01 |
| [5.1.0](https://github.com/jemalloc/jemalloc/releases/tag/5.1.0) | 2018-05-08 |
| [5.2.0](https://github.com/jemalloc/jemalloc/releases/tag/5.2.0) | 2019-04-02 |
| [5.2.1](https://github.com/jemalloc/jemalloc/releases/tag/5.2.1) | 2019-08-05 |
| [5.3.0](https://github.com/jemalloc/jemalloc/releases/tag/5.3.0) | 2022-05-06 |

The complete and most up to date list of supported versions and stacks is
available on the [releases page.](https://github.com/BTLzdravtech/jemalloc-buildpack/releases)

## Building

This uses Docker to build against Paketo builder - full
[builder-image](https://github.com/paketo-buildpacks/full-builder).

```console
make VERSION=5.3.0
```

Artifacts will be dropped in `dist/` based on Cloud Native stack and jemalloc version.

### Deploying New Versions

- `make VERSION=X.Y.Z`
- `open dist`
- Go to [releases](https://github.com/BTLzdravtech/jemalloc-buildpack/releases)
- Edit the release corresponding to each Cloud Native stack
- Drag and drop the new build to attach

### Creating a New Stack
- Go to [releases](https://github.com/BTLzdravtech/jemalloc-buildpack/releases)
- Click "Draft a new release"
- Tag is the name of the Stack (e.g. `io.buildpacks.stacks.bionic`)
- Target is `release-master`
- Title is `Builds for the [stack] stack`
