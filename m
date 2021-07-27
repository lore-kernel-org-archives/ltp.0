From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Jul 2021 14:03:42 +0200
Subject: [LTP] [PATCH] regen.sh: Limit mips o32 system calls
In-Reply-To: <20210722125219.31895-1-zhanglianjie@uniontech.com>
References: <20210722125219.31895-1-zhanglianjie@uniontech.com>
Message-ID: <YP/2HhUaQVQc1oAV@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi zhanglianjie,

> With mips architecture, 64-bit programs cannot call o32 system calls.
> For example, __NR_stime, __NR_socketcall, __NR_time, etc.
@Thomas or somebody from MIPS folks, could you please confirm this?

> Better solve the problem described in commit: 22c2c9e2f

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index 7a4f0cf44..8ac80440c 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -80,7 +80,7 @@ for arch in $(cat "${srcdir}/order") ; do
>  		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
>  		mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
>  		mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
> -		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32)" ;;
> +		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
>  		*) echo "#ifdef __${arch}__" ;;
>  	esac
>  	while read line ; do
