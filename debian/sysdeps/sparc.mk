GLIBC_PASSES += sparcv9 sparc64
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64 libc6-sparcv9 libc6-dev-sparc64
 
sparc64_MIN_KERNEL_SUPPORTED = 2.4.18
sparc64_configure_target=sparc64-linux
sparc64_CC = $(BUILD_CC) -m64
sparc64_extra_config_options = $(extra_config_options) --disable-profile --enable-omitfp
sparc64_add-ons = linuxthreads $(add-ons)
libc6-sparc64_shlib_dep = libc6-sparc64 (>= $(shlib_dep_ver))
sparc64_LIBDIR = 64
 
sparcv9_MIN_KERNEL_SUPPORTED = 2.4.18
sparcv9_configure_target=sparcv9-linux
sparcv9_extra_cflags = -mcpu=v9 -mtune=ultrasparc
sparcv9_extra_config_options = $(extra_config_options) --disable-profile --enable-omitfp
sparcv9_add-ons = linuxthreads $(add-ons)
sparcv9_LIBDIR = /v9
