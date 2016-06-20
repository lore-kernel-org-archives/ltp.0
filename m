From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Jun 2016 09:03:51 -0400 (EDT)
Subject: [LTP] [PATCH] mem/lib: keep allocating memory until get an
 error in single process
In-Reply-To: <20160620113454.GA21624@gmail.com>
References: <1466416385-20603-1-git-send-email-liwang@redhat.com>
 <1007336481.302642.1466419398150.JavaMail.zimbra@redhat.com>
 <20160620113454.GA21624@gmail.com>
Message-ID: <214135224.352328.1466427831586.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 20 June, 2016 1:34:54 PM
> Subject: Re: [PATCH] mem/lib: keep allocating memory until get an error in single process
> 
> On Mon, Jun 20, 2016 at 06:43:18AM -0400, Jan Stancek wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Li Wang" <liwang@redhat.com>
> > > To: jstancek@redhat.com
> > > Cc: ltp@lists.linux.it
> > > Sent: Monday, 20 June, 2016 11:53:05 AM
> > > Subject: [PATCH] mem/lib: keep allocating memory until get an error in
> > > single process
> > > 
> > > We occasionally catch errors like:
> > > oom03       0  TINFO  :  start OOM testing for KSM pages.
> > > oom03       0  TINFO  :  expected victim is 3490.
> > > oom03       6  TFAIL  :  mem.c:163: victim unexpectedly ended with
> > > retcode:
> > > 0, expected: 12
> > > oom03       0  TINFO  :  set overcommit_memory to 0
> > > 
> > > It cames from the caller testoom(0, 1, ENOMEM, 1). The full reason is
> > > that
> > > function child_alloc() go into single process mode, then successfully
> > > finish
> > > the memory allocation and return 0.
> > 
> > Description above doesn't explain why you get 0, when oom03 is set to run
> > in cgroup with memory.memsw.limit_in_bytes == TESTMEM, and then allocates
> > TESTMEM + MB.
> > 
> > My guess is a KSM scan merged some pages before you have hit the limit.
> That might be.
> 
> > Do yo get these failures always during KSM test?
> No, I just get the failures only once during my test.
> 
> > > 
> > > In this patch, let's make it (in single mode) keep allocating memory with
> > > an incresed length in order to avoid 0 returned.
> 
> Hmm, now I think these codes have two problems.
> 
> 1. As you said the KSM merge same pages and let the oom03 failed as above.
> 
> 
> 2. The child_alloc() probably should also do memory allocation with an
> infinite loop

At the time 'lite' was introduced, everything was single threaded,
the only difference was that lite == 0 would keep allocating in
infinite loop.

Your patch is effectively eliminating lite == 1, which means that
oom03 will pass even if cgroup limits are broken.

> in single process mode. Because if someone has a caller testoom(0, 1, ENOMEM,
> 1) at other
> place in future, that'll be easily get fauilures.

Likely because author is expecting behaviour other than what
we have now:

 * @lite: if non-zero, child makes only single TESTMEM+MB allocation
 *        if zero, child keeps allocating memory until it gets killed
 *        or some operation fails

> Or, can we solve them in one method?

We could skip oom(KSM) if lite == 1 in testoom(), since limit_in_bytes
may vary from run to run, which isn't reliable for oom03 cgroup test.

Or we could change alloc_mem for lite == 1 && testcase == KSM,
such that each page would have unique content (to prevent merging).

Regards,
Jan
