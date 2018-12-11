From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 10 Dec 2018 21:37:55 -0800
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <87lg4xn4e5.fsf@rpws.prws.suse.cz>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
 <87o99xmmsw.fsf@rpws.prws.suse.cz>
 <20181207163442.GB14562@dell5510>
 <87lg4xn4e5.fsf@rpws.prws.suse.cz>
Message-ID: <20181211053753.GA847@sol.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Dec 10, 2018 at 09:59:46AM +0100, Richard Palethorpe wrote:
> Hello,
> 
> Petr Vorel <pvorel@suse.cz> writes:
> 
> > Hi Eric, Richard,
> >
> >> > +#include <linux/rtnetlink.h>
> >> > +
> >> > +#include "tst_test.h"
> >> > +#include "tst_crypto.h"
> >> > +#include "tst_netlink.h"
> >
> >> It seems that on SLE11 there is a bug in the kernel headers which means
> >> compilation fails if you include linux/rtnetlink.h before
> >> linux/netlink.h. If you switch the order then it compiles OK.
> >
> > Correct, it suffers from bug:
> > https://www.spinics.net/lists/netdev/msg171764.html
> > How about adding include <linux/rtnetlink.h> into
> > include/tst_netlink.h?
> 
> I think we would also have to include sys/socket.h in tst_netlink.h to
> really solve the problem.
> 
> I am not sure if that is a good idea.

tst_netlink.h already has an implicit dependency on safe_net_fn.h which already
includes <sys/socket.h>.  So it appears the real issue is including
<linux/rtnetlink.h> (which includes <linux/netlink.h>) before tst_test.h.

But various other <linux/*> headers include <linux/netlink.h> too, and I don't
think all should be included in tst_netlink.h, so I guess I'll just move the
include within the test .c file itself...

BTW, I have no system to reproduce this problem on, so you'll just have to tell
me whether it works.  I tried CentOS 6, but this is already fixed there.

- Eric
