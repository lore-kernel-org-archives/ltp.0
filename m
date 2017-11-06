From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Nov 2017 17:38:09 +0100
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
 handling
In-Reply-To: <20171103185941.17651-1-vkabatov@redhat.com>
References: <20171103185941.17651-1-vkabatov@redhat.com>
Message-ID: <20171106163809.GB1662@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Very occasionally, we ran into unexpected failures with exit code 1
> when running mtest06/mmap1. This was caused by a race condition during
> unmap() - read with SIGSEGV - mmap() loop, where read after unmap was
> attempted, but before the actual signal handling occurred the area was
> mapped again and signal handler was changed back. Instead of test
> continuation when a read after unmap happens, the handler which takes
> SIGSEGV as fatal becomes active before it should and kills the test. See
> simplified strace output:
> 
> [pid  8650] <... munmap resumed> ) ...
> [pid  8651] --- SIGSEGV ...
> [pid  8650] mmap ...
> [pid  8651] write(1, "mmap1    0  TINFO :  created writing thread ...
> [pid  8650] <... mmap resumed> ) ...
> [pid  8651] <... write resumed> ) ...
> [pid  8650] sched_yield ...
> [pid  8651] exit_group(1 ...
> [pid  8651] +++ exited with 1 +++

So the problem is that we have SIGSEGV pending in the kernel while the
map_write_unmap() thread changes the signal handler to
sig_handler_mapped() right?

> Fix the race condition by using a proper locking mechanism for thread
> synchronization to prevent mapping changes before the caught signal is
> actually handled, and simplify the test by using only a single handler.

Hmm, how much is the reading loop slowed down with the mutex_lock() and
mutex_unlock() calls?

I would expect that it would make up for the significant part of the
loop which kind of defeats the purpose of stress test.

Maybe we can fix that by making sure that we got different address in
two subsequent mmaps in the map_write_unmap() loop (for instance by
unmaping the old one after we mapped a new one) then we can check the
si_addr in the siginfo_t in the signal handler. If the address is
different from the current one we know that the SEGFAULT has happened
before we mmaped() the file again. If that works we don't have to
implement any locking at all which would increase our chances of hitting
some race condition in the kernel...

-- 
Cyril Hrubis
chrubis@suse.cz
