From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Jul 2021 09:56:15 +0200
Subject: [LTP] [PATCH] stime: Only o32 system calls require 32-bit
 programs on mips
In-Reply-To: <20210720063852.1883-1-zhanglianjie@uniontech.com>
References: <20210720063852.1883-1-zhanglianjie@uniontech.com>
Message-ID: <YPaBnxlp2SsxCaPE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi zhanglianjie,

> The stime() system call is only o32, not n32 and n64. If you do not
> specify that the current program is compiled to 32-bit when compiling
> the program on mips, the stime() system call will fail when the
> program is running.
You're right that stime() is only on o32. But tst_syscall() should catch that.
Or does it set different errno than ENOSYS?

Kind regards,
Petr

...
> +#if defined(__mips__) && _MIPS_SZLONG == 32
>  		return tst_syscall(__NR_stime, ntime);
> +#else
> +		tst_brk(TCONF, "the stime() syscall only o32 ABI in mips, make sure the current program is 32-bit");
> +#endif
