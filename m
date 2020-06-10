From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jun 2020 11:51:25 +0200
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <2845dc64-cce0-47df-1005-4cc508bd9388@cn.fujitsu.com>
References: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
 <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
 <20200610080529.GA19781@dell5510>
 <2845dc64-cce0-47df-1005-4cc508bd9388@cn.fujitsu.com>
Message-ID: <20200610095125.GA21406@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > I guess you missed librealtime.a in (testcases/realtime/lib/Makefile).
> Yes.

> > Maybe removing libdir could be in separate commit, it looks to me as unrelated
> > change.
Actually, when looking into this more (this part is new in v2, Jan didn't review
it).

I'd keep keep libdir in include/mk/config.mk.in, because we use it in our
lib/ltp.pc file. Maybe we don't need if we don't install any library, but then
we should remove also LIB variable and associated code in include/mk/lib.mk.
Which should be a second step (second commit).

Also libdir is somehow expected by automake (it's referenced in generated
./m4/Makefile.in ./testcases/realtime/m4/Makefile.in).

Kind regards,
Petr
