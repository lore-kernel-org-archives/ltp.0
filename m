From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 21:34:41 +0200
Subject: [LTP] [PATCH 2/4] INSTALL: Document 32bit and cross-compilation
 setup
In-Reply-To: <20200514184904.4537-3-pvorel@suse.cz>
References: <20200514184904.4537-1-pvorel@suse.cz>
 <20200514184904.4537-3-pvorel@suse.cz>
Message-ID: <20200514193441.GA11518@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>  Cross compiling
>  ---------------
> -
>  To cross compile, you must specify the correct variables when running configure.
> -e.g. CC, LDFLAGS, etc...
> +e.g. CC, LDFLAGS, etc.
> +For correct pkgconf / pkg-config detection you need to set
> +PKG_CONFIG_SYSROOT_DIR=$SYSROOT

>  After configure has run, it will generate include/mk/config.mk. You can tweak
>  settings in there if need be, but you should not specificy settings on the
>  command-line when running make.
It'd be nice to have true cross-compilation test...

> +32 bit build on 64 bit machine
> +------------------------------
> +You need to set CFLAGS=-m32 LDFLAGS=-m32 and PKG_CONFIG_LIBDIR
> +
> +* RPM based distributions (openSUSE, Fedora, etc.)
> +PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
> +
> +* Debian / Ubuntu and derivates
> +PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure

I guess, we should set this variable in 32 bit build in travis CI (we have only 1
job, which uses Debian). It's not failing now, because it's not a minimal build.
Therefore we should have minimal 32 bit build (easiest way is to use openSUSE or
Fedora/CentOS as they don't install libtirpc 32bit).

Kind regards,
Petr
