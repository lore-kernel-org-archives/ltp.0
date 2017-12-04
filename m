From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Dec 2017 17:55:07 +0800
Subject: [LTP] [RFC PATCH v2 1/5] travis: Add build script and use it in
	travis
In-Reply-To: <20171201154641.27407-2-pvorel@suse.cz>
References: <20171201154641.27407-1-pvorel@suse.cz>
 <20171201154641.27407-2-pvorel@suse.cz>
Message-ID: <CAEemH2e+BMzZwt+F6mAgezb1Ty=CboPuvWx2oGn2zhbkZqSz1g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Dec 1, 2017 at 11:46 PM, Petr Vorel <pvorel@suse.cz> wrote:
> This script handles native build, 32-bit cross-compile build and
> out-of-tree build.
>
> Script is for travis build, but can be used for local builds as well.
>
> For usage run
> ./build.sh -h
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .travis.yml |   2 +-
>  build.sh    | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100755 build.sh
>
> diff --git a/.travis.yml b/.travis.yml
> index d937f9dcf..f2d51f131 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -72,4 +72,4 @@ notifications:
>      email:
>          secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
>
> -script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
> +script: ./build.sh
> diff --git a/build.sh b/build.sh
> new file mode 100755
> index 000000000..9e057f73b
> --- /dev/null
> +++ b/build.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> +# Script for travis builds.
> +#
> +# TODO: Implement comparison of installed files. List of installed files can
> +# be used only for local builds as Travis currently doesn't support sharing
> +# file between jobs, see
> +# https://github.com/travis-ci/travis-ci/issues/6054
> +
> +set -e
> +
> +PREFIX="$HOME/ltp"
> +
> +CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$PREFIX"

Here you set --prefix to current ltp path, why not "/opt/ltp"?

And, I get some installing errors with this configuration for build in tree.

# ./build.sh
[...]
install: ‘/root/ltp/testcases/realtime/perf/latency/disknoise.sh’ and
‘/root/ltp/testcases/realtime/perf/latency/disknoise.sh’ are the same
file
make[4]: *** [/root/ltp/testcases/realtime/perf/latency/cpunoise2000.sh] Error 1
make[4]: *** [/root/ltp/testcases/realtime/perf/latency/pthread_cond_latency]
Error 1
make[4]: *** [/root/ltp/testcases/realtime/perf/latency/disknoise.sh] Error 1
make[4]: *** [/root/ltp/testcases/realtime/perf/latency/cpunoise.sh] Error 1
make[4]: Leaving directory `/root/ltp/testcases/realtime/perf/latency'
make[3]: *** [install] Error 2
make[3]: Leaving directory `/root/ltp/testcases/realtime/perf'
make[2]: *** [install] Error 2
make[2]: Leaving directory `/root/ltp/testcases/realtime'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/root/ltp/testcases'
make: *** [testcases-install] Error 2
make: *** Waiting for unfinished jobs....
[...]


Test Environment
==============
# uname -rm
4.15.0-rc2 x86_64

# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/4.8.5/lto-wrapper
Target: x86_64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info
--with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap
--enable-shared --enable-threads=posix --enable-checking=release
--with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-gnu-unique-object
--enable-linker-build-id --with-linker-hash-style=gnu
--enable-languages=c,c++,objc,obj-c++,java,fortran,ada,go,lto
--enable-plugin --enable-initfini-array --disable-libgcj
--with-isl=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-x86_64-redhat-linux/isl-install
--with-cloog=/builddir/build/BUILD/gcc-4.8.5-20150702/obj-x86_64-redhat-linux/cloog-install
--enable-gnu-indirect-function --with-tune=generic
--with-arch_32=x86-64 --build=x86_64-redhat-linux
Thread model: posix
gcc version 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC)


-- 
Li Wang
liwang@redhat.com
