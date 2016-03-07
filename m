From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Mon, 7 Mar 2016 10:39:27 +0000
Subject: [LTP] [PATCH] rt_sigaction.h: adjust for ARC
References: <1457090537-23825-1-git-send-email-vgupta@synopsys.com>
 <20160307101319.GB3559@rei.suse.cz>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8E55A@us01wembx1.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Monday 07 March 2016 03:45 PM, Cyril Hrubis wrote:
> Hi!
>> To me all the song-and-dance in ltp_rt_sigaction() doesn't make sense.
> These are required if you call the raw rt_sigaction syscall. Since
> before signal handler is called the process context is saved on the
> user-space stack and once signal is done it has to be restored. In order
> to do that signal trampoline is called which calls sigreturn to restore
> the context. And the way trapoline is executed is platform specific and
> sometimes in the sa_restorer.

I'm well aware of all that having fixed a bunch of kernel issues in this exact
area back in 2008 and also added the uClibc userspace default sigrestorer....
The point is why is LTP calling raw rt_sigaction syscall at all. It needs to call
sigaction which is the posix API and see how it behaves. I can understand the
usage of raw syscalls for things which won't be present in a libc (e.g newer
syscalls or perhaps obsoleted syscalls). sigaction is fairly standard. No ?

>> The intent it to test whatever platform libc + kernel combination
>> provides and to that end any fixups in LTP seem odd to me.
>> So for ARC just call what libc provides and don't claim to support
>> more/less.
> These testcases are testing kernel syscall and some of the testcases
> will not work with the libc wrapper.

I understand you want to test the -EFAULT code path in the kernel - but any arch
with default sa restorer in libc can't do that at all.
They have to provide the default sa restorer to successfully return from signal
handler to invoke the sigreturn syscall.
Look in uClibc - ARC is not the exception: ARM, Xtensa, MIPS, x86 all use such
userspace default restorers and are all plagued by same issue.

Before this patch, we had rt_sigaction01 crash on ARC - this was because it passed
the test itself, but for sigreturn it went off to lala land since there was no
restorer. So it failed anyways. With this patch we have that as passing: actually
4 passes, 2 failures. I don't care abt this +4/-2. More importantly this is true
reflection of how ARC GNU stack behaves. If you call sigaction(num, -1, 0) it will
NOT return -EFAULT but crash.

-rt_sigaction01 rt_sigaction01
-rt_sigprocmask01 rt_sigprocmask01
-rt_sigsuspend01 rt_sigsuspend01
+rt_sigaction02 rt_sigaction02
+rt_sigaction03 rt_sigaction03
-signal_test_04 signal_test_04


>  So NACK on the patch.

But this patch only changes how ARC works - so whats the problem ? There are
already arch specifix quirks in this file, there so how does one more hurt.

-Vineet
