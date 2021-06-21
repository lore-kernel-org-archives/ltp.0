From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Jun 2021 11:01:33 +0200
Subject: [LTP] [PATCH 1/7] io_cancel02: Add io_cancel02 test for libaio
In-Reply-To: <YNBQ95gIlM9TTjpA@yuki>
References: <20210618094210.183027-1-xieziyao@huawei.com>
 <20210618094210.183027-2-xieziyao@huawei.com>
 <YNBQ95gIlM9TTjpA@yuki>
Message-ID: <YNBVbVGZ5QRJuOkH@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#include "config.h"
> > +#include "tst_test.h"
> > +
> > +#ifdef HAVE_LIBAIO
> > +#define EXP_RET (-EFAULT)
> > +
> > +#include <libaio.h>
> > +
> > +static void run(void)
> > +{
> > +	io_context_t ctx;
> > +
> > +	memset(&ctx, 0, sizeof(ctx));
> > +	TEST(io_cancel(ctx, NULL, NULL));
> > +
> > +	if (TST_RET == 0)
> > +		tst_res(TFAIL, "call succeeded unexpectedly");

It's usually easier to read to use return instead of else if branches:

	if (TST_RET == 0) {
		tst_res(TFAIL, "io_cancel() succeeded unexpectedly");
		return;
	}

Also you should never use strerror() in tests, we do have tst_strerrno()
for that purpose, also if you have checked that TST_RET == EFAULT there
is no point in converting the value into a string and you can do:


	if (TST_RET == -EFAULT) {
		tst_res(TPASS, "io_cancel() failed with EFAULT");
		return;
	}


Followed by:

	tst_res(TFAIL, "io_cancel() failed unexpectedly %s (%d) expected EFAULT",
	        tst_strerrno(-TST_RET), -TST_RET);

> > +	else if (TST_RET == EXP_RET)
> > +		tst_res(TPASS, "io_cancel(ctx, NULL, NULL) returns %ld : %s",
> > +			TST_RET, strerror(-TST_RET));
> > +	else
> > +		tst_res(TFAIL, "io_cancel(ctx, NULL, NULL) returns %ld : %s, expected %d : %s",
> > +			TST_RET, strerror(-TST_RET), EXP_RET, strerror(-EXP_RET));
> 
> Please use TST_EXP_FAIL() instead.

Looking again, these calls do return -error on failure, we can't use
TST_EXP_FAIL() here.

But even then there are a couple of problems to fix (commented above).


-- 
Cyril Hrubis
chrubis@suse.cz
