From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 May 2017 10:12:17 +0200
Subject: [LTP] tst_atomic_add_return() implementation for sparc
In-Reply-To: <20170511073312.kjcyveu7qlipxgbh@dell5510>
References: <20170510162157.rqanvu46hfkvffpa@dell5510>
 <20170510192510.GA29900@rei.suse.de>
 <20170511073312.kjcyveu7qlipxgbh@dell5510>
Message-ID: <20170511081217.GB306@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 	int ret;
> > 	__asm__ __volatile__("": : :"memory");
> > 	ret = (counter = counter + 1);
> >         __asm__ __volatile__("": : :"memory");
> > 	return ret;
> 
> > Should work, but I do not have any sparc hardware for testing...
> Thanks a lot! I'll try to find some sparc to test it :).

There is a lib/newlib_tests/test09.c that is supposed to assert correct
implementation of the atomic operation.

-- 
Cyril Hrubis
chrubis@suse.cz
