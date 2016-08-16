From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 13:30:55 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <3ABF60118B9B784CA5BF7C841D2F00EC01000B69@de02wembxa.internal.synopsys.com>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160815120810.GC20680@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
 <20160816100223.GA24312@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000B69@de02wembxa.internal.synopsys.com>
Message-ID: <20160816113055.GB24312@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Actually both glibc and uClibc use fcntl64 by default and usually fail
> when you try to pass 32-bit flock structure to it when you use OFD
> locks. Then fcntl64 fails in fcntl_setlk64 routing while checking
> l_pid field. I checked this case on 32-bit targets: x86 and ARC.

Ah, I've missed that.


Given that the manual for fcntl() says:

  The newer system call employs a different structure for file locking,
  flock64, and corresponding commands, F_GETLK64, F_SETLK64, and
  F_SETLKW64.

I guess that the F_OFD_XXX locks should be added to this list as they
explicitly require flock64 as well. And the fix to the test would be
using struct flock64 instead of struct flock.

-- 
Cyril Hrubis
chrubis@suse.cz
