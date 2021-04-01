From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Apr 2021 08:12:27 +0200
Subject: [LTP] [PATCH] bugfix for ssetmask01.c
In-Reply-To: <20210330021830.17402-1-zhanglianjie@uniontech.com>
References: <20210330021830.17402-1-zhanglianjie@uniontech.com>
Message-ID: <YGVkS23e+/eytuEn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> mips architecture syscall(69) __NR_ssetmask not supported on your arch.

nit: "mips_o32: Fix __NR_s{g,s}etmask" for bug title would be more descriptive
than "bugfix for ssetmask01.c". And then in text mention ssetmask01.c.

> +++ b/include/lapi/syscalls/mips_o32.in
> @@ -66,8 +66,8 @@ getppid 64
>  getpgrp 65
>  setsid 66
>  sigaction 67
> -sgetmask 68
> -ssetmask 69
> +sgetmask 4068
> +ssetmask 4069

But more important: I guess you're right because we don't add any offset to the
numbers. But IMHO all numbers are wrong, all mips files should contain offset
(01e4dc222 was wrong). mips_o32.in should be offset 4000, mips_n32.in 6000 and
mips_n64.in 5000 (comparing scall32-o32.S, scall64-64.S, scall64-n32.S in
arch/mips/kernel in kernel and mips{,n32,64}/bits/syscall.h.in in musl).

Kind regards,
Petr
