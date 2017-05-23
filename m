From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 May 2017 13:14:34 +0200
Subject: [LTP] tst_atomic_add_return() implementation for sparc
In-Reply-To: <20170522224707.jisupuud7jhexjaz@dell5510>
References: <20170510162157.rqanvu46hfkvffpa@dell5510>
 <20170510192510.GA29900@rei.suse.de>
 <20170522224707.jisupuud7jhexjaz@dell5510>
Message-ID: <20170523111433.GA19602@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Should work, but I do not have any sparc hardware for testing...
> 
> I tried this, but lib/newlib_tests/test09 (tested with 32 bit uClibc on sparc 64) fails
> :-(. Do you see any obvious error? I hope the problem isn't 64 bit architecture.

Looks like the real implementation is in arch/sparc/lib/atomic32.c and
arch/sparc/lib/atomic_64.S.

The 32bit implementation uses spinlocks, the 64bit v9 CPU has
instruction for atomic operations. See for instance this discussion:

https://forums.gentoo.org/viewtopic-t-97011-start-0.html

-- 
Cyril Hrubis
chrubis@suse.cz
