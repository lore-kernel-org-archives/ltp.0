From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 09:01:34 +0100
Subject: [LTP] [PATCH v1 1/2] syscalls/settimeofday01: convert to new
 library
In-Reply-To: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200309080134.GB299736@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,
> Also, since glibc 2.31[1], when tz and tv are both null, it will get
> SIGSEGV sig. So, remove this EFAULT error test to adopt glibc 2.31.
+1, thanks for testing on new glibc.

> Moreover, musl 1.2.0 is now available and changes time_t for 32-bit
> archs to a 64-bit type. It is updated to slove y2038 problem and get
=> typo solve.
> time function no longer used for 32bit arch but not affecting set time
> function and 64 bit arch, more info see[2]. So for gettimeofday(), we
> use tst_syscall instead of calling libc to avoid this problem.
Hm, it'd be nice to test both raw syscall and libc implementations (via
tst_variant), but IMHO there is no way to detect musl change. Or am I missing
something?

+ one would prefer this change to be in a separate commit, but we can live with that :).

I guess there is no need to setup SAFE_{G,S}ETTIMEOFDAY(), because only these 2
tests and stime_var.h are using it (or at least no now).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
