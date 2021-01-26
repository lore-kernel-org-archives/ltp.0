From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2021 13:25:00 +0800
Subject: [LTP] [PATCH RFC 2/2] swapping01: check memory swap usage per
 process
In-Reply-To: <YA7i/eQagkj0Jxsy@yuki.lan>
References: <20210125064747.26759-1-liwang@redhat.com>
 <20210125064747.26759-2-liwang@redhat.com>
 <YA7i/eQagkj0Jxsy@yuki.lan>
Message-ID: <CAEemH2cSwtVXi2fXam2aKG0XOEd3-hfZGgQ+o4K2_vyThMrTEg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Jan 25, 2021 at 11:24 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Since previously swapping01 read the system FreeSwap for counting
> > usage of swap-size, that's not precise on system especially with
> > eating-memory daemon??in the background. Now, we try to check the
> > 'VmmSwap' in proc/PID/status??per process, to get rid of??the potential
> > influence from??other processes??which easily leads to false positive.
>
> I've been looking for a while at the kernel commit:
>
> commit 50a15981a1fac7e019ff7c3cba87531fb580f065
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Sun Jul 24 10:47:59 2011 +0200
>
>     [S390] reference bit testing for unmapped pages
>
> For which this test seems to be a reproducer and as far as I can tell
> this fix is not correct.
>
> If I understand correctly what we are trying to test here is that the
> kernel will not attempt to swap out unreferenced pages, so we have to,
> by definition, look at the system counters not the process ones.
>

Thanks for point out this! Seems we were all working towards
making the test robust but neglect it's a reproducer:).


As we have discussed many unsure things will take side effect to
the system swap-counting, that's what we do NOT want to expect.
Maybe, can we encapsulate all of the means in a process to avoid
involving the whole system swap-counting. e.g.

Child:
         to touch unreferenced pages (via
alloc&write&free 1.3*MemAvailable) [1]
         alloc&wirte 1.3*MemAvailable
         raise(SIGSTOP)
         ...
Parent:
         waiting for child suspension
         check child's VmSwap to see if heavy-swap occurs in a process
         ...

Does this make some sense to the test or, any else suggestion?

[1] As to perform alloc&write&free, the system pages will go through a
completed life cycle from buddy-system to active-list to inactive-list
then back to buddy-system, which reflect to a page status is theoretically
like:
"inactive,unreferenced -> active,referenced -> ... ->inactive,unreferenced"
so that might helpful to produce what the kernel target commit fixed
situation.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210126/8da66ebe/attachment.htm>
