From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Tue, 16 Aug 2016 10:47:26 +0000
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <20160816100223.GA24312@rei.lan>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160815120810.GC20680@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
 <20160816100223.GA24312@rei.lan>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00EC01000B69@de02wembxa.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Actually both glibc and uClibc use fcntl64 by default and usually fail when you try to pass 32-bit flock structure to it when you use OFD locks. Then fcntl64 fails in fcntl_setlk64 routing while checking l_pid field. I checked this case on 32-bit targets: x86 and ARC.

So fcntl64 is used by default. When you don't pass -D_FILE_OFFSET_BITS=64 then fcntl64 accidently uses 32-bit flock for 64-bit OFD and l_pid field may be non-zero. Such usage of API is wrong because may lead to undefined behavior (kernel tries to read l_pid from nowhere and sometimes it hangs Linux on ARC target).

Here is a small example:

---------------- 8< ----------------
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>

#define F_OFD_SETLKW 38

int main()
{
	char fname[] = "ofdlock.txt";
	int fd = open(fname, O_CREAT | O_RDWR, 0666);

	if (fd == -1)
		perror("cannot open file");

	struct flock64 lck = {
		.l_type   = F_WRLCK,
		.l_whence = SEEK_SET,
		.l_start  = 0,
		.l_len    = 1,
		.l_pid    = 0,
	};

	if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
		perror("cannot lock");

	return 0;
}
---------------- 8< ----------------

Command line:
$ gcc -m32 ofdlock.c -o ofdlock-x86
$ ./ofdlock-x86

It works fine because we use flock64 explicitly. fcntl is always 64-bit. But if you change flock64 to flock you get an error:
$ ./ofdlock-x86 
cannot lock: Invalid argument

And everything works fine again if you pass -D_FILE_OFFSET_BITS=64:
$ gcc -m32 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 ofdlock.c -o ofdlock-x86
$ ./ofdlock-x86

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Tuesday, August 16, 2016 1:02 PM
> To: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
> Cc: ltp@lists.linux.it; Vineet.Gupta1@synopsys.com;
> Alexey.Brodkin@synopsys.com
> Subject: Re: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
> all cases
> 
> Hi!
> > As far as I know it fails in this case because fcntl always expects
> > flock64 for OFD locks but gets 32-bit flock structure with non-zero
> > l_pid field (OFD expects that this field contains zero otherwise
> > returns EINVAL). The problem is that there are no 32-bit OFD locks in
> > the kernel. So there are 2 options:
> 
> If you look into fs/fcntl.c in Linux kernel the F_OFD_XXX constants are inside
> #if BITS_PER_LONG != 32 in the do_fcntl(). Hence 32bit fcntl() returns EINVAL
> since these constants are missing from the switch() when compiled on 32bit
> platform.
> 
> And the same apply for when you run 32bit binary on 64bit kernel. In this
> case the fcntl syscall from fs/compat.c just returns EINVAL if the cmd is
> F_OFD_XXX.
> 
> Which works fine for glibc, since if you compile without
> _FILE_OFFSET_BITS=64 on 32bit it calls 32bit fcntl() syscall that rightfully
> returns EINVAL and if you compile with _FILE_OFFSET_BITS=64 both flock
> structure and fcntl() are 64bit and everything works fine.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
