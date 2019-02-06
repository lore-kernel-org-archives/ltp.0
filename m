From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Feb 2019 13:07:24 +0100
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190206075159.GA13396@x230>
References: <20190128134656.27979-1-metan@ucw.cz> <20190206075159.GA13396@x230>
Message-ID: <20190206120724.GB13516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I wonder if we want either warn user or run it both via (g)libc wrapper and
> directly the syscall.

I guess that we may drop a hint in the error message.

> BTW testing on kernel 4.20.0, glibc 2.28 with sys_preadv2() and still get TBROK
> EOPNOTSUPP. I tried to test on ext[2-4], btrfs. I wonder what I'm missing.

That's strange, are you sure that the test was calling the wrapper
instead of the glibc call?

This should really work unless the support in kernel has been disabled
in distribution kernel for some reason. I was testing it on vanilla
kernel where it worked as expected.

-- 
Cyril Hrubis
chrubis@suse.cz
