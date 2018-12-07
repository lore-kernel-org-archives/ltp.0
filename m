From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Dec 2018 17:34:42 +0100
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <87o99xmmsw.fsf@rpws.prws.suse.cz>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
 <87o99xmmsw.fsf@rpws.prws.suse.cz>
Message-ID: <20181207163442.GB14562@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric, Richard,

> > +#include <linux/rtnetlink.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_crypto.h"
> > +#include "tst_netlink.h"

> It seems that on SLE11 there is a bug in the kernel headers which means
> compilation fails if you include linux/rtnetlink.h before
> linux/netlink.h. If you switch the order then it compiles OK.

Correct, it suffers from bug:
https://www.spinics.net/lists/netdev/msg171764.html
How about adding include <linux/rtnetlink.h> into include/tst_netlink.h?

> > +static void __check_for_leaks(const char *name, const char *value,
> > size_t vlen)
> 
> IIRC we don't allow functions beginning with underscores because they
> are reserved by the compiler or C library.
Agree.


Kind regards,
Petr
