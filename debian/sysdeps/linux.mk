ifeq ($(DEB_HOST_GNU_CPU),i386)
  MIN_KERNEL_SUPPORTED := 2.0.30
else
  ifeq ($(DEB_HOST_GNU_CPU),m68k)
    MIN_KERNEL_SUPPORTED := 2.0.30
  else
    MIN_KERNEL_SUPPORTED := 2.2.0
  endif
endif

# XXX: disabled for now
# Sparc and i386 have some optimized libs
#ifeq ($(DEB_HOST_GNU_CPU),sparc)
#  cpus = v9
#  as_flags_v9 = -Wa,-Av9a
#  cpu_flags_v9 = -mtune=ultrasparc -mv8
#endif
#ifeq ($(DEB_HOST_GNU_CPU),i386)
#  # Nifty little vardep thingie
#  cpus = i586 i686
#  cpu_flags_$(OPT) = -mcpu=$(OPT)
#  as_flags_$(OPT) = 
#endif

ifeq ($(DEB_HOST_GNU_CPU),sparc)
  arch_packages += $(libc)-sparc64 $(libc)-dev-sparc64
endif

opt_packages += $(addprefix opt-$(libc)-,$(cpus))

config-os = linux-gnu
threads = yes
add-ons += linuxthreads

# Try to find a version of kernel-headers to use

# We check this later. If there is more than one, we fail
num_headers := $(shell ls -d /usr/src/kernel-headers-* | wc -l | tr -d ' ')

ifeq ($(cross_compiling),no)
  ifndef LINUX_SOURCE
    # kernel-headers-$linux-version package
    LINUX_SOURCE := $(shell ls -d /usr/src/kernel-headers-* | tail -1)
  else
    # Get it from the environment
    LINUX_SOURCE := $(strip $(shell echo ${LINUX_SOURCE}))
    num_headers := 1
  endif
  with_headers := --with-headers=$(LINUX_SOURCE)/include
else
  # Cross compiles can just use sys-include
  with_headers :=
endif

# Minimum Kernel supported
with_headers += --enable-kernel=$(MIN_KERNEL_SUPPORTED)

# s390 needs this, and also uses gcc-3.0
ifeq ($(DEB_HOST_GNU_CPU),s390)
  extra_config_options := --enable-omitfp --disable-sanity-checks
endif

# hppa uses gcc-3.0
ifeq ($(DEB_BUILD_ARCH),hppa)
  extra_config_options := --disable-sanity-checks
endif
