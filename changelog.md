# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]

### Added

### Fixed
- TODO: make fog appear through translucents.
- TODO: make waving water not break apart. gbuffers_water.glsl, float WavingWater function

### Changed


## [2.0.0_Dev8] - 2025-10-06

### Added
- Added RPLE Support.
- Added support for 1.7.10 Streams mod.

### Fixed
- Translucents not being processed in the nether.
- Hand not being processed in the nether.
- Night Eye being applied twice.
- Weather not using lightmap.
- Fog color being weird.

## [2.0.0_Dev7] - 2024-12-10

### Added
- Added Cherry trees
- Added Pale Oak trees

## [2.0.0_Dev6] - 2024-02-01

### Added
- Added support for LOTR mod and a few random fixes

## [2.0.0_Dev5] - 2023-04-22

### Added
- Added Film Grain intensity slider.
- Added Support for 1.7.10 Streams mod.
- Added nether biome fog color support.

### Fixed

- Fixed swizzle to work with any tone map.
- Fog fixed and improved!!
- Fixed Red Flash on damaging mob not showing in End or Nether.

### Changed

- Reimplemented and rewrote Darker Nights option.
- Made the red flash on hitting mobs more prominent.
- Optimized a lot. (Should be quite a bit faster from my testing.)
- Extended the values for Motion Blur, so it can be less intense.
- Split all waving foliage to their own toggles.
- Make fog underwater thicker during rain.

## [1.5.7] - 2022-06-13

### Fixed
- Fixed water refraction and night eye in older versions

## [1.5.6.2] - 2022-04-11

### Added
- Botania Support
- Bewitchment Support
- FutureMc Support
- Fossils and Archeology Revival Support
- Rats plants Support

### Changed
- Added Min Optifine version for 1.7.10 and 1.12.2

## [1.5.6.1] - 2022-01-03

### Fixed
- Issue (#9) with 1.13 water mechanics backport mod resolved.

## [1.5.6.0] - 2021-12-29

### Fixed
- Issue with screen blacking out going below 0y on 1.18 is resolved.
