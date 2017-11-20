From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Nov 2017 10:05:24 -0500 (EST)
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
 handling
In-Reply-To: <197806265.17273314.1510844585297.JavaMail.zimbra@redhat.com>
References: <20171103185941.17651-1-vkabatov@redhat.com>
 <20171106163809.GB1662@rei>
 <1187592937.37117661.1510045232581.JavaMail.zimbra@redhat.com>
 <20171107102537.GB6126@rei.lan>
 <197806265.17273314.1510844585297.JavaMail.zimbra@redhat.com>
Message-ID: <689923703.42701689.1511190324217.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: vkabatov@redhat.com, ltp@lists.linux.it
> > Sent: Tuesday, November 7, 2017 11:25:37 AM
> > Subject: Re: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
> > handling
> > 
> > Hi!
> > > > Maybe we can fix that by making sure that we got different address in
> > > > two subsequent mmaps in the map_write_unmap() loop (for instance by
> > > > unmaping the old one after we mapped a new one) then we can check the
> > > > si_addr in the siginfo_t in the signal handler. If the address is
> > > > different from the current one we know that the SEGFAULT has happened
> > > > before we mmaped() the file again. If that works we don't have to
> > > > implement any locking at all which would increase our chances of
> > > > hitting
> > > > some race condition in the kernel...
> > > 
> > > This doesn't capture the state of mapped area. When you're in signal
> > > handler you wouldn't know if area was mapped or not when you got SIGSEGV.
> > >
> > > I'd modify it in this way:
> > > - use just one singal handler
> > > - write thread will set 'mapped' flag when it maps/unmaps the area
> > > - based on 'mapped' flag read thread tries to read from a specific range
> > > of
> > > addresses
> > >   e.g. odd vs even bytes or odd vs. even blocks of bytes, such that
> > >   those blocks don't overlap
> > > - when signal handler triggers, it checks si_addr, and based on value
> > >   it can tell if this was an attempt to read mapped or unmapped area
> > > - if we tried to read mapped area and got SIGSEGV -> FAIL
> > >   otherwise keep running
> > 
> > I like the idea of encoding the information about the mapped/unmapped
> > state into the actuall address we attempt to read, nice trick, let's do
> > that.
> > 
> 
> Hi, I finally got around to properly check this out.
> 
> While this is indeed a nice trick, it doesn't work well with s390x arch
> where si_addr is masked and only shows which page the SIGSEGV happened
> at, not the actual address. Since we can't mmap() to address that is
> not a page boundary and (by default) we are mapping less than a page
> worth of memory, no matter how we divide the addresses they would be
> treated the same way.
> 
> To work around this feature we could use two pages and access one when
> the area is mapped and the other one when it's not. This way we can
> clearly distinguish between expected and unexpected segfaults on all
> architectures.
> 
> This method would however deprecate the test option for file size (-s).
> I'm not sure how widely this option is used but because of the possible
> change of the interface, I'm writing this message to gather feedback
> first.

Looking at runtest/ directory, it's not used. If we want to preserve it,
we could impose some minimal value (2 pages).

> 
> I would also like to mention that we need to use locking at least when
> the address computation and actual access to it is happening:
> 
> read thread                                          write thread
> <compute and load address based on active mapping>
>                                                      unmap()
> <access address thinking it should be mapped>
> <unexpected SIGSEGV>
> 
> There should be no issues with leaving out locking for the other parts
> of code, but I found no feasible way to get around this one.

The idea me and Veronika were dicussing off-list was using just
pthread_mutex_trylock() without actual blocking to avoid race above.

> 
> I'd be happy to hear any feedback or different ideas how to tackle both
> issues if anybody has them.

I don't see problem using 2 pages.
I'd drop '-s' parameter until there's need for it.
I'd try some minimal locking and measure how many iterations
are we able to do now vs. before.

---
Thinking loud about alternatives:

Signal handler could be replaced with write() to some temporary
file, which would use the ptr to mapped/unmapped area. If it's
not mapped we get EFAULT. This would also eliminate setjmp()/longjmp().

If we stop looking at mapped status and only consider mapped data,
then this would turn into checking written pattern:
1) create file A with some pattern
2) thread1 maps/unmaps file into memory at X
3) thread2 writes to file B, from memory X, this will either work or fail with EFAULT
4) report PASS if all blocks in file B have same pattern as blocks in file A

To address "read between mmap/munmap must succeed", there would probably also
need to be a write performed by thread1 to file C.

Regards,
Jan
