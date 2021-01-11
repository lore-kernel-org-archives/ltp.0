From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 Jan 2021 16:28:36 +0100
Subject: [LTP] [PATCH 1/2] build.sh: Remove deprecated CROSS_COMPILE
In-Reply-To: <20210111030704.5761-1-lizhijian@cn.fujitsu.com>
References: <20210111030704.5761-1-lizhijian@cn.fujitsu.com>
Message-ID: <X/xupJgktrYI4LyG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> The CROSS_COMPILE was no longer used by ltp since 400ac9bbe20.

> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  build.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/build.sh b/build.sh
> index 452cc6f4c..602ca419e 100755
> --- a/build.sh
> +++ b/build.sh
> @@ -64,7 +64,7 @@ build_cross()
>  	fi

>  	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
> -	build $1 $2 "--host=$host" CROSS_COMPILE="${host}-"
I looked what would require CROSS_COMPILE support. It's somehow duplicate to
autoconf --host parameter.

Although it wouldn't be difficult to add a support into configure.ac and
include/mk/config.mk.in via AC_ARG_VAR, it's use would require:

1) either migrate everything to pkg-config (but libnuma and libaio does not
support it) and use PKG_CONFIG_LIBDIR

2) fix host cpu detection in m4/ltp-host-cpu.m4 (parse CROSS_COMPILE).

=> IMHO it's not worth of doing it, thus good we removed it.

Kind regards,
Petr

> +	build $1 $2 "--host=$host"
>  }

>  build()
