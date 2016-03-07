From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Mon, 7 Mar 2016 11:50:52 +0000
Subject: [LTP] [PATCH] rt_sigaction.h: adjust for ARC
References: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
 <20160307101319.GB3559@rei.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8E55A@us01wembx1.internal.synopsys.com>
 <20160307105747.GC3559@rei.suse.cz>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8E5B7@us01wembx1.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Monday 07 March 2016 04:29 PM, Cyril Hrubis wrote:
> We also check that we got EINVAL if the sigsetsize is wrong, which
> cannot be done with the libc wrapper.
>
> And we several testscases for the libc wrapper as well. Two in
> testcases/syscalls/sigaction/ directory and much more in
> testcases/open_posix_testsuite/conformance/interfaces/sigaction/.
>
> So both raw syscall and libc call are covered in LTP.

Fair enough - so LTP was a "Linux" test project - testing the raw kernel ABI makes
sense to check for correctness.
Although users will complain that sigaction(n, -1, 0) doesn't return with -EFAULT
but crashes. Oh well !

>>>> So for ARC just call what libc provides and don't claim to support
>>>> more/less.
> I do not understand, looking at:
>
> https://github.com/foss-for-synopsys-dwc-arc-processors/uClibc/blob/314dd3440686d6225ef1b93b5c5bdce852747a6b/libc/sysdeps/linux/arc/sigaction.c
>
> All you have to do in sa_restorer for arc is to call __NR_rt_sigreturn.
>
> Looking at the INTERNAL_SYSCALL_NCS it's just a few lines of inline
> assembler. So all you have to do to support this properly in LTP is to
> create restorer function taking the assembler and passing NR_sigreturn
> as syscall number to it.

Will do in next patch !

Thx,
-Vineet


