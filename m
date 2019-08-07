From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 7 Aug 2019 12:15:43 +0200
Subject: [LTP] Question about kernel/syscall/signal/signal06.c
In-Reply-To: <e7d0e66d-f348-9d57-0ea9-dc1fa289942d@windriver.com>
References: <56f854e2-9cc6-4725-3182-ff83e106ee23@windriver.com>
 <20190717094614.GA9539@rei>
 <7d2c4936-2e89-6285-c856-a156d3a76284@windriver.com>
 <CAEemH2edg4R-JFM=u_ceLoRcNAMmV=c+hVV6kxoK4g6DOBnGeg@mail.gmail.com>
 <e7d0e66d-f348-9d57-0ea9-dc1fa289942d@windriver.com>
Message-ID: <20190807101542.bshdy6bqxjkiaeou@linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I just woke up from hibernation and assume that this has not been
handled yet so?

On 2019-07-22 09:56:55 [+0800], Hongzhi, Song wrote:
> 
> On 7/19/19 4:44 PM, Li Wang wrote:
> > On Fri, Jul 19, 2019 at 4:14 PM Hongzhi, Song
> > <hongzhi.song@windriver.com> wrote:
> > > This case fails when boot qemux86-64 with 1/2 cores.
> > > 
> > > I find [kernel 5.2-rc1: 0d714dba162] causes the failure by git bisect.
> 
> Hi Li,Wang
> 
> 
> Sorry for my a bit mistake, the exact tag is [5.1-rc3 : 0d714dba162]
> 
> commit 0d714dba162620fd8b9f5b3104a487e041353c4d
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:?? Wed Apr 3 18:41:48 2019 +0200
> 
> ??? x86/fpu: Update xstate's PKRU value on write_pkru()
> 
> ??? During the context switch the xstate is loaded which also includes the
> ??? PKRU value.
> 
> ??? If xstate is restored on return to userland it is required
> ??? that the PKRU value in xstate is the same as the one in the CPU.
> 
> ??? Save the PKRU in xstate during modification.

So this commit is about PKRU handling and I miss PKU bits in your lscpu
output. So I assume this commit is not related but the FPU rework in
general.

> 3.? uname -r
> 
> root@qemux86-64:~# uname -r
> 5.1.0-rc3-Linux-standard

This is information is confusing. I can reproduce a test case failure in
0d714dba162 but it passes with latest supported kernel.
Please let me know if this problem still exists with 5.3-rc3 or 5.2.7. I
can't reproduce it on any of those kernels.
5.1 is EOL and the commit in question was merged into 5.2-rc1.

> Thanks.
> 
> --Hongzhi

Sebastian
