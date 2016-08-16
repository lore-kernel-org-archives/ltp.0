From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 12:02:23 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160815120810.GC20680@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
Message-ID: <20160816100223.GA24312@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As far as I know it fails in this case because fcntl always expects
> flock64 for OFD locks but gets 32-bit flock structure with non-zero
> l_pid field (OFD expects that this field contains zero otherwise
> returns EINVAL). The problem is that there are no 32-bit OFD locks in
> the kernel. So there are 2 options:

If you look into fs/fcntl.c in Linux kernel the F_OFD_XXX constants are
inside #if BITS_PER_LONG != 32 in the do_fcntl(). Hence 32bit fcntl()
returns EINVAL since these constants are missing from the switch() when
compiled on 32bit platform.

And the same apply for when you run 32bit binary on 64bit kernel. In
this case the fcntl syscall from fs/compat.c just returns EINVAL if the
cmd is F_OFD_XXX.

Which works fine for glibc, since if you compile without
_FILE_OFFSET_BITS=64 on 32bit it calls 32bit fcntl() syscall that
rightfully returns EINVAL and if you compile with _FILE_OFFSET_BITS=64
both flock structure and fcntl() are 64bit and everything works fine.

-- 
Cyril Hrubis
chrubis@suse.cz
