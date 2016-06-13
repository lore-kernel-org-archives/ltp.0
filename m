From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Jun 2016 16:22:10 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: use struct flock64 on 32bit
In-Reply-To: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
References: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
Message-ID: <20160613142210.GA354@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On x86, compiled as 32bit:
> 
> fcntl34.c:113: INFO: write to a file inside threads with OFD locks
> fcntl34.c:47: INFO: spawning '3' threads
> fcntl34.c:56: INFO: waiting for '3' threads
> fcntl34.c:88: BROK: fcntl() failed: EINVAL
> 
> This is because glibc translates fcntl() to sys_fcntl64,
> 
> [pid 19656] fcntl64(4, F_OFD_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET,
> l_start=4294967296, l_len=-695062700769673216}) = -1 EINVAL
> (Invalid argument)
> 
> as advised by the kernel,
> 
> 	/* 32-bit arches must use fcntl64() */
> 	case F_OFD_SETLK:
> 	case F_OFD_SETLKW:
> 
> but the struct passed uses 32bit values,
> 
> struct flock lck = {
> 	.l_whence = SEEK_SET,
> 	.l_start = 0,
> 	.l_len = 1,
> };
> 
> which are read as 64bit by the kernel,
> 
> int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
> struct flock64 __user *l)
> 
> causing the garbage in upper 32bit of at least l_start and l_len to be
> treated as offsets, resulting in EINVAL.
> 
> This patch makes the test use struct flock64 when _FILE_OFFSET_BITS
> is unset.

Since both manual and glibc examples use struct flock with OFD locks in
examples and if I compile glibc example for OFD locks[1] on 32bit system
garbage is passed to kernel syscalls and the program hangs, so I would
call this glibc/kernel bug.

I would expect glibc to convert the flock structure to 64 bit one
silently in this case.

[1] manual/examples/ofdlocks.c
    https://sourceware.org/git/?p=glibc.git;a=blob;f=manual/examples/ofdlocks.c;h=ba4f0ef4d237e95b8f1e0f37b9c1befd4afda0d4;hb=HEAD

-- 
Cyril Hrubis
chrubis@suse.cz
