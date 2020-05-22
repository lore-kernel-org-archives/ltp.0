From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 May 2020 10:58:39 +0200
Subject: [LTP] [PATCH V2 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200522084205.hvkx4maxujzb2s2y@vireshk-i7>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
 <c5428a9c88d18fac80e364281cfd4e3aefa38d2c.1590130423.git.viresh.kumar@linaro.org>
 <CAK8P3a2B35hUF3rSdJpS=M-Wekm+wUx-skekgw3CiQR=wodqXw@mail.gmail.com>
 <20200522084205.hvkx4maxujzb2s2y@vireshk-i7>
Message-ID: <20200522085839.GA2446@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This is not enough to run on old kernels that have __NR_clock_getres
> > but don't have __NR_clock_getres_time64,
> 
> What about reversing the order of the two ? Check __NR_clock_getres
> first ?

Moreover the __NR_ constants are always defined in order to avoid need
for excessive #ifdefs and the missing syscalls are defined to -1 in LTP.

So this will not work at all.

> > you need a runtime fallback
> > instead of a compile-time fallback.
> 
> Why so ?

Given that 32bit syscalls can be disabled in kernel config we cannot
really tell which ones are supported before we attempt to call the
syscall.

-- 
Cyril Hrubis
chrubis@suse.cz
