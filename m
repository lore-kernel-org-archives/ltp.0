From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Nov 2017 04:00:32 -0500 (EST)
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
 handling
In-Reply-To: <20171106163809.GB1662@rei>
References: <20171103185941.17651-1-vkabatov@redhat.com>
 <20171106163809.GB1662@rei>
Message-ID: <1187592937.37117661.1510045232581.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> Hi!
> > Very occasionally, we ran into unexpected failures with exit code 1
> > when running mtest06/mmap1. This was caused by a race condition during
> > unmap() - read with SIGSEGV - mmap() loop, where read after unmap was
> > attempted, but before the actual signal handling occurred the area was
> > mapped again and signal handler was changed back. Instead of test
> > continuation when a read after unmap happens, the handler which takes
> > SIGSEGV as fatal becomes active before it should and kills the test. See
> > simplified strace output:
> > 
> > [pid  8650] <... munmap resumed> ) ...
> > [pid  8651] --- SIGSEGV ...
> > [pid  8650] mmap ...
> > [pid  8651] write(1, "mmap1    0  TINFO :  created writing thread ...
> > [pid  8650] <... mmap resumed> ) ...
> > [pid  8651] <... write resumed> ) ...
> > [pid  8650] sched_yield ...
> > [pid  8651] exit_group(1 ...
> > [pid  8651] +++ exited with 1 +++
> 
> So the problem is that we have SIGSEGV pending in the kernel while the
> map_write_unmap() thread changes the signal handler to
> sig_handler_mapped() right?
> 
> > Fix the race condition by using a proper locking mechanism for thread
> > synchronization to prevent mapping changes before the caught signal is
> > actually handled, and simplify the test by using only a single handler.
> 
> Hmm, how much is the reading loop slowed down with the mutex_lock() and
> mutex_unlock() calls?
> 
> I would expect that it would make up for the significant part of the
> loop which kind of defeats the purpose of stress test.
> 

Hi,

> Maybe we can fix that by making sure that we got different address in
> two subsequent mmaps in the map_write_unmap() loop (for instance by
> unmaping the old one after we mapped a new one) then we can check the
> si_addr in the siginfo_t in the signal handler. If the address is
> different from the current one we know that the SEGFAULT has happened
> before we mmaped() the file again. If that works we don't have to
> implement any locking at all which would increase our chances of hitting
> some race condition in the kernel...

This doesn't capture the state of mapped area. When you're in signal
handler you wouldn't know if area was mapped or not when you got SIGSEGV.

I'd modify it in this way:
- use just one singal handler
- write thread will set 'mapped' flag when it maps/unmaps the area
- based on 'mapped' flag read thread tries to read from a specific range of addresses
  e.g. odd vs even bytes or odd vs. even blocks of bytes, such that
  those blocks don't overlap
- when signal handler triggers, it checks si_addr, and based on value
  it can tell if this was an attempt to read mapped or unmapped area
- if we tried to read mapped area and got SIGSEGV -> FAIL
  otherwise keep running

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
