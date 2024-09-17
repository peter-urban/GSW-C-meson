
# SPDX-FileCopyrightText: 2024 Peter Urban
#
# SPDX-License-Identifier: BSD-3-Clause

# 'TEOS-10 V3.06.16-0 GSW Oceanographic Toolbox in C, (this is an inoffical meson wrapper)'
# 'http://teos-10.org'

# --- Project ---
# Define project meta data
project(
  'gswteos-10',
  ['c', 'cpp'], #appears to be c on linux/mac and cpp on windows
  license: 'BSD-3-Clause',

  version: 'v3.06.16-0',
  default_options: ['warning_level=2', 'buildtype=release'],
  meson_version: '>=1.5.1' #latest tested version,,,,
)

project_name = 'gswteos-10'
description = 'TEOS-10 V3.06.16-0 GSW Oceanographic Toolbox in C, (this was installed using an inoffical meson wrapper)'
url = 'http://teos-10.org'

# --- dependencies ---
# libm (math library)
# only necessary if it is not already included in the compiler
# therefore required is set to false
cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required: false)

# --- compile options ---
c_compile_args = []
cpp_compile_args = []
link_language = 'c'
if host_machine.system() == 'windows'
  message('Setting /Tp flag to interpret c files as c++ files on windows')
  cpp_compile_args += ['/TP'] #interpret c files as c++ files on windows
  c_compile_args += ['/TP'] #interpret c files as c++ files on windows
  link_language = 'cpp'
endif

if get_option('force-cpp').enabled()
  if cc.get_id() == 'gcc' or cc.get_id() == 'clang'
    c_compile_args += ['-xc++']
  endif
endif

# --- sources ---
program_sources = ['gsw_check_functions.c']

library_sources = [
  'gsw_oceanographic_toolbox.c',
  'gsw_saar.c',
]

export_headers = ['gswteos-10.h']

# --- define library and dependencies ---
gswteos_10_lib = library(
  project_name,
  library_sources,
  c_args: c_compile_args,
  cpp_args: cpp_compile_args,
  dependencies: [m_dep],
  link_language: link_language,
  install: true,
)

gswteos_10_dep = declare_dependency(
  dependencies: [m_dep],
  link_with: [gswteos_10_lib],
)

# --- Installation ---
# install headers
install_headers(export_headers)

# pkgconfig file
pkg = import('pkgconfig')
pkg.generate(
  description: description,
  url: url,
  version: meson.project_version(),
  name: project_name,
  libraries: gswteos_10_lib,
)

# --- define tests ---
gswteos_10_exe = executable(
  'gsw_check',
  sources: [program_sources],
  dependencies: [gswteos_10_dep],
  c_args: c_compile_args,
  cpp_args: cpp_compile_args,
  link_language: link_language,
)

test('run_gsw_check', gswteos_10_exe)
