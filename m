From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Dec 2018 11:55:01 +0100
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <20181211053753.GA847@sol.localdomain>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
 <87o99xmmsw.fsf@rpws.prws.suse.cz>
 <20181207163442.GB14562@dell5510>
 <87lg4xn4e5.fsf@rpws.prws.suse.cz>
 <20181211053753.GA847@sol.localdomain>
Message-ID: <20181211105501.GA13118@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric, Richard,

...
> > > Correct, it suffers from bug:
> > > https://www.spinics.net/lists/netdev/msg171764.html
> > > How about adding include <linux/rtnetlink.h> into
> > > include/tst_netlink.h?

> > I think we would also have to include sys/socket.h in tst_netlink.h to
> > really solve the problem.

> > I am not sure if that is a good idea.

> tst_netlink.h already has an implicit dependency on safe_net_fn.h which already
> includes <sys/socket.h>.  So it appears the real issue is including
> <linux/rtnetlink.h> (which includes <linux/netlink.h>) before tst_test.h.

> But various other <linux/*> headers include <linux/netlink.h> too, and I don't
> think all should be included in tst_netlink.h, so I guess I'll just move the
> include within the test .c file itself...
If it's the only change, we can do it before merge (no need to repost whole
patchset).

> BTW, I have no system to reproduce this problem on, so you'll just have to tell
> me whether it works.  I tried CentOS 6, but this is already fixed there.
Sure, we'll test it (I can reproduce it as well).

> - Eric
Petr
