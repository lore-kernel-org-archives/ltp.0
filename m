From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 May 2021 13:18:54 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <88d2297a-58f1-2ee3-0db4-6686ffbf4de2@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com>
 <YKbbCLUlaICqSIK5@pevik>
 <88d2297a-58f1-2ee3-0db4-6686ffbf4de2@huawei.com>
Message-ID: <YKeXHtPOexQr8Iic@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> > > +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
> > ...
> > > + * Copyright (c) International Business Machines  Corp., 2014
> > Again, missing copyright.
> I wonder if I should add copyright without changing the code logic.
IMHO yes. You significantly changed the code. At least we do that.

...
> > > -static void cleanup(void);
> > > -static void setup(void);
> > > +#ifndef OFF_T
> > > +#define OFF_T off_t
> > > +#endif
> > I wonder where OFF_T comes from and if we can just simply use off_t.
> Not sure about this.
@metan any idea?

It looks like nothing needs it:
https://travis-ci.org/github/pevik/ltp/builds/771843061

> > > +	for (int i = 1; i <= (4 * 1024); ++i) {
> > This will lead to error in old compilers:
> > error: 'for' loop initial declarations are only allowed in C99 mode
> > https://travis-ci.org/github/pevik/ltp/jobs/771837120
> > https://travis-ci.org/github/pevik/ltp/jobs/771837126

> > It must be:

> > int i;

> > ...
> > for (i = 1; i <= (4 * 1024); ++i) {

> > Thus probably better to declare fd before as well.

> > int i, fd;
> I'll pay attention next time. Thanks.
np, you obviously not work on legacy distro. Travis CI would tell you, but we
don't expect users to run Travis CI on their LTP fork to catch the failures
before sending it to ML (but of course feel free to set it up).

> Hi, Petr,

> Not sure whether to remove OFF_T, the other modifications worked fine for
> me.
Thanks for info, we sort out OFF_T and I'll push it fixed after the release.

> Thanks for your review.
yw, thanks a lot for your work!

Kind regards,
Petr

> Kind regards,
> Ziyao
