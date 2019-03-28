From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Mar 2019 16:24:42 +0100
Subject: [LTP] [PATCH 2/2] syscalls/stime: detect if libc stime() is
 implemented dynamically
In-Reply-To: <1553765807-31789-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1553765807-31789-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190328152442.GB6002@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao, Steve,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/m4/ltp-libc-funcs.m4 b/m4/ltp-libc-funcs.m4
> index ebbe2c9..122073f 100644
> --- a/m4/ltp-libc-funcs.m4
> +++ b/m4/ltp-libc-funcs.m4
> @@ -10,5 +10,5 @@ dnl
>  AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
>  AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
>  mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
> -splice syncfs sync_file_range tee unshare vmsplice,,)
> +splice stime syncfs sync_file_range tee unshare vmsplice,,)
I hope AC_CHECK_FUNCS is working well on cross compilation (I guess so, but
noticed some problems on autotools with PKG_CHECK_MODULES, but that's different
as it's using pkg-config).
...

> diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
...
> -#ifdef __ANDROID__
> -		tst_brk(TCONF, "libc stime() is not implemented on Android");
> +#ifndef HAVE_STIME
> +		tst_brk(TCONF, "libc stime() is not implemented");
>  #else
>  		return stime(ntime);
>  #endif


Kind regards,
Petr
