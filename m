From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Jun 2016 20:25:14 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: use struct flock64 on 32bit
In-Reply-To: <575EF441.5020506@redhat.com>
References: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
 <20160613142210.GA354@rei.lan> <575EF441.5020506@redhat.com>
Message-ID: <20160613182513.GC354@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Since both manual and glibc examples use struct flock with OFD locks in
> > examples and if I compile glibc example for OFD locks[1] on 32bit system
> > garbage is passed to kernel syscalls and the program hangs, so I would
> > call this glibc/kernel bug.
> > 
> > I would expect glibc to convert the flock structure to 64 bit one
> > silently in this case.
> 
> That might not be possible as such "silent" conversion could break
> a lot of existing programs that rely on hardcoded 32bit struct flock
> size.

What I meant was to use the user supplied flock structure to initialize
flock64 before doing the syscall. We would have to copy the l_type back
in case of FGETLK but apart from that I do not see any problem with
this.

Also I've tried to run the test on purely 32bit machine (i686 openSUSE
Tumbleweed) and the problem seems to be present there as well. I can see
that it calls fcntl64() which fails with EINVAL and both l_start and
l_len are clearly garbage. So 32bit glibc with 32bit kernel seems to be
broken as well.

-- 
Cyril Hrubis
chrubis@suse.cz
