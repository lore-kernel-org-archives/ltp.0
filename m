From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Nov 2017 16:13:27 +0800
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <20171128232130.4843-2-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
Message-ID: <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 29, 2017 at 7:21 AM, Petr Vorel <pvorel@suse.cz> wrote:
> This script is to be used for travis build, but can be used for local
> builds as well.
>
> For usage run
> ./build.sh -h
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .travis.yml |  2 +-
>  build.sh    | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 1 deletion(-)
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
> index 000000000..3387c120d
> --- /dev/null
> +++ b/build.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> +#
> +# Script used for travis builds and for local test builds.
> +
> +set -e
> +
> +PREFIX="$HOME/ltp"
> +CONFIGURE_OPTS="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$PREFIX"
> +
> +build_32()
> +{
> +       echo "===== 32 bit in tree build into $PREFIX ====="
> +       build CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
> +}
> +
> +build_native()
> +{
> +       echo "===== native in tree build into $PREFIX ====="
> +       build
> +}
> +

How about adding a new function for ltp build out of tree?

build_out_of_tree()
{
       echo "===== build ltp out of tree ====="
...
}

> +build()
> +{
> +       echo "=== autotools ==="
> +       make autotools
> +
> +       echo "=== configure ==="
> +       if ! ./configure $CONFIGURE_OPTS $@; then
> +               echo "configure failed, config log:"
> +               cat config.log
> +               exit 1
> +       fi
> +
> +       echo "=== build ==="
> +       make -j$(getconf _NPROCESSORS_ONLN)
> +
> +       echo "=== install ==="
> +       make -j$(getconf _NPROCESSORS_ONLN) install
> +}
> +
> +usage()
> +{
> +       cat << EOF
> +Usage:
> +$0 [ BUILD_TYPE ]
> +$0 -h|--help|help
> +
> +Options:
> +-h|--help|help  Print this help
> +
> +BUILD TYPES:
> +32      32 bit build
> +
> +Default build is native build.
> +EOF
> +}
> +
> +case "$1" in
> +       -h|--help|help) usage; exit 0;;


            -o|--out) build="build_out_of_tree";;


> +       32) build="build_32";;
> +       *) build="build_native";;
> +esac
> +
> +$build
> +
> +# vim: set ft=sh ts=4 sts=4 sw=4 noet:
> --
> 2.15.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Li Wang
liwang@redhat.com
