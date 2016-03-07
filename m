From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 11:57:47 +0100
Subject: [LTP] [PATCH] rt_sigaction.h: adjust for ARC
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8E55A@us01wembx1.internal.synopsys.com>
References: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
 <20160307101319.GB3559@rei.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8E55A@us01wembx1.internal.synopsys.com>
Message-ID: <20160307105747.GC3559@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm well aware of all that having fixed a bunch of kernel issues in this exact
> area back in 2008 and also added the uClibc userspace default sigrestorer....
> The point is why is LTP calling raw rt_sigaction syscall at all. It needs to call
> sigaction which is the posix API and see how it behaves. I can understand the
> usage of raw syscalls for things which won't be present in a libc (e.g newer
> syscalls or perhaps obsoleted syscalls). sigaction is fairly standard. No ?

We also check that we got EINVAL if the sigsetsize is wrong, which
cannot be done with the libc wrapper.

And we several testscases for the libc wrapper as well. Two in
testcases/syscalls/sigaction/ directory and much more in
testcases/open_posix_testsuite/conformance/interfaces/sigaction/.

So both raw syscall and libc call are covered in LTP.

> >> The intent it to test whatever platform libc + kernel combination
> >> provides and to that end any fixups in LTP seem odd to me.

Once again these are not fixups. This is userspace part of the
rt_sigaction syscall implementation which is required if you call the
raw syscall.

> >> So for ARC just call what libc provides and don't claim to support
> >> more/less.

I do not understand, looking at:

https://github.com/foss-for-synopsys-dwc-arc-processors/uClibc/blob/314dd3440686d6225ef1b93b5c5bdce852747a6b/libc/sysdeps/linux/arc/sigaction.c

All you have to do in sa_restorer for arc is to call __NR_rt_sigreturn.

Looking at the INTERNAL_SYSCALL_NCS it's just a few lines of inline
assembler. So all you have to do to support this properly in LTP is to
create restorer function taking the assembler and passing NR_sigreturn
as syscall number to it.

-- 
Cyril Hrubis
chrubis@suse.cz
