From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Dec 2017 04:53:49 -0500 (EST)
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
 handling
In-Reply-To: <20171206165558.GA5543@rei>
References: <20171103185941.17651-1-vkabatov@redhat.com>
 <20171106163809.GB1662@rei>
 <1187592937.37117661.1510045232581.JavaMail.zimbra@redhat.com>
 <20171107102537.GB6126@rei.lan>
 <197806265.17273314.1510844585297.JavaMail.zimbra@redhat.com>
 <689923703.42701689.1511190324217.JavaMail.zimbra@redhat.com>
 <20171206165558.GA5543@rei>
Message-ID: <968857095.53988263.1513072429455.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > I would also like to mention that we need to use locking at least when
> > > the address computation and actual access to it is happening:
> > > 
> > > read thread                                          write thread
> > > <compute and load address based on active mapping>
> > >                                                      unmap()
> > > <access address thinking it should be mapped>
> > > <unexpected SIGSEGV>
> > > 
> > > There should be no issues with leaving out locking for the other parts
> > > of code, but I found no feasible way to get around this one.
> > 
> > The idea me and Veronika were dicussing off-list was using just
> > pthread_mutex_trylock() without actual blocking to avoid race above.
> > 
> > > 
> > > I'd be happy to hear any feedback or different ideas how to tackle both
> > > issues if anybody has them.
> > 
> > I don't see problem using 2 pages.
> > I'd drop '-s' parameter until there's need for it.
> 
> Agreed.
> 
> > I'd try some minimal locking and measure how many iterations
> > are we able to do now vs. before.
> 
> Sounds reasonable.
> 
> I guess that it's impossible to make it 100% correct without any
> locking, so we should make it as lightweight as possible, maybe some
> spinlocks atomic operations and sched_yield().
> 
> I was thinking of doing pthread_kill() to the reading thread with some
> other signal that would flip a flag in the signal handler before we
> unmap and after we map the memory, so we will use that signal as a some
> kind of barrier. But this may be tricky to get working and quite
> possibly will not work at all.
> 
> > ---
> > Thinking loud about alternatives:
> > 
> > Signal handler could be replaced with write() to some temporary
> > file, which would use the ptr to mapped/unmapped area. If it's
> > not mapped we get EFAULT. This would also eliminate setjmp()/longjmp().
> 
> I wonder if we should actually test both, but yes handling EFAULT would
> make this much easier than asynchronous signal delivery. On the other
> hand the signal handler code is much more complex so there is probably
> bigger room for triggering bugs.
> 
> > If we stop looking at mapped status and only consider mapped data,
> > then this would turn into checking written pattern:
> > 1) create file A with some pattern
> > 2) thread1 maps/unmaps file into memory at X
> > 3) thread2 writes to file B, from memory X, this will either work or fail
> > with EFAULT
> > 4) report PASS if all blocks in file B have same pattern as blocks in file
> > A
> 
> And thread2 retries on EFAULT with the same address again, right? This
> sounds interesting enough to be implemented as a test.

OK, I'll put it on my TODO list (as mtest08).

> 
> > To address "read between mmap/munmap must succeed", there would probably
> > also
> > need to be a write performed by thread1 to file C.
> 
> But that runs synchronously between the mmap() and unmap() right? That
> kind of misses the point of the original test, however I wonder how

It does. Likely better to have two tests, mtest06 with some light
locking, and mtest08 doing the EFAULT checks.

Regards,
Jan
