From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 May 2017 09:33:12 +0200
Subject: [LTP] tst_atomic_add_return() implementation for sparc
In-Reply-To: <20170510192510.GA29900@rei.suse.de>
References: <20170510162157.rqanvu46hfkvffpa@dell5510>
 <20170510192510.GA29900@rei.suse.de>
Message-ID: <20170511073312.kjcyveu7qlipxgbh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> So something as:

> 	int ret;
> 	__asm__ __volatile__("": : :"memory");
> 	ret = (counter = counter + 1);
>         __asm__ __volatile__("": : :"memory");
> 	return ret;

> Should work, but I do not have any sparc hardware for testing...
Thanks a lot! I'll try to find some sparc to test it :).


Kind regards,
Petr
