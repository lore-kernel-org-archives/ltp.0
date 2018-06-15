From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Jun 2018 09:20:25 -0400
Subject: [LTP] [bug?] mutual exclusion between posix and OFD locks
In-Reply-To: <20180615111158.GA536@dustball.usersys.redhat.com>
References: <20180615111158.GA536@dustball.usersys.redhat.com>
Message-ID: <1ce001a4909607e13da4c2fa7a87b814f0c0be4c.camel@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2018-06-15 at 13:11 +0200, Jan Stancek wrote:
> Hi,
> 
> Attached is simplified reproducer (LTP fcntl36), where
> 2 threads try to lock same region in a file. One is
> using posix write lock, the other OFD read lock.
> 
> Observed problem: 2 threads obtain lock simultaneously.
> 
> --- strace excerpt ---
> [pid 16853] 06:57:11 openat(AT_FDCWD, "tst_ofd_posix_locks", O_RDWR) = 3
> [pid 16854] 06:57:11 openat(AT_FDCWD, "tst_ofd_posix_locks", O_RDWR) = 4
> ...
> [pid 16853] 06:57:12 fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
> [pid 16854] 06:57:12 fcntl(4, F_OFD_SETLKW, {l_type=F_RDLCK, l_whence=SEEK_SET, l_start=0, l_len=4096} <unfinished ...>
> [pid 16853] 06:57:12 <... fcntl resumed> ) = 0
> [pid 16853] 06:57:12 nanosleep({tv_sec=0, tv_nsec=100000},  <unfinished ...>
> [pid 16854] 06:57:12 <... fcntl resumed> ) = 0
> --- /strace excerpt ---
> 
> fcntl(2) says:
>   Conflicting lock combinations (i.e., a read lock and a write
>   lock or two write locks) where one lock is an open file
>   description lock and the other is a traditional record lock
>   conflict even when they are acquired by the same process on
>   the same file descriptor.
> 
> Reproducible on x86_64 VM, with v4.17-11782-gbe779f03d563.
> 
> Thanks for having a look,
> Jan
> 

tl;dr: I think the test program is buggy. You're running afoul of one of
the behaviors of traditional POSIX locks that caused us to add OFD locks
in the first place. On any call to close() all traditional POSIX locks
in the process are dropped.

Longer explanation: You have 3 thread pairs, and each one does a
close(fd) at the end of the thread func. When you go to join the
threads, it ends up calling close(fd), and that causes _all_ traditional
POSIX locks to get released, even ones that might still be in use by
other threads.

If you comment out the close(fd); calls in both thread funcs then the
program seems to reliably run to completion.
-- 
Jeff Layton <jlayton@kernel.org>
