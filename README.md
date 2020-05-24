# Build Packer Image Action

This action builds a Packer image from a given template. Includes Vagrant so a box can be created if desired.

## Inputs

### `template`

**Required** The template to build. Default `"template.pkr.hcl"`.

## Outputs

None yet.

## Example usage

uses: jgriepentrog/build-packer-image-action@v1
with:
  template: 'ubuntu.pkr.hcl'
