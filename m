From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Mar 2020 17:49:56 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <20200304160330.GA7516@rei>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
 <20200304160330.GA7516@rei>
Message-ID: <20200304164956.GB5603@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > Don't forget to clear errno when you're not using the TEST() macro.

> Hmm, I'm not sure how useful is this. Generally the syscalls in libc
> have single macro definition that is used everywhere to copy the error
> from the errno variable. If that piece of code is buggy half of the test
> in LTP would fail anyway.
That's exactly what I thought when I omit that.
+ we reset errno on fewer places than we don't.

> > > +	if (tst_kvercmp(2, 6, 26) <= 0)
> > > +		flags = 0;

> > I think tst_brk(TCONF) would be better here. Or at least tst_res(TWARN),
> > since resetting flags to 0 may render some tests useless.

> I think that it's completely wrong to put kernel version comparsion to
> the safe_macros. If the test needs specific kernel version it should be
> either put into the tst_test structure of handled in the test setup.
OK, I'll remove it.
For my previous state:
timerfd01.c (all)
timerfd_settime01.c (3th and 4rd test)
timerfd_settime02.c (not sure whether this old version is really affected by
CVE-2017-10661)

It means that 1st and 2nd test from timerfd_settime01.c could be tested on
2.6.25 and .26, but it won't due TCONF. But probably not many people will miss
it nowadays.

Kind regards,
Petr
