From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 27 Mar 2017 18:08:12 +0200
Subject: [LTP] [PATCH 2/4] Test for CVE-2016-4997 on setsockopt
In-Reply-To: <20170327153439.GD21272@rei.lan>
References: <20170323162633.7e49c7ae@linux-v3j5>
 <20170327153439.GD21272@rei.lan>
Message-ID: <20170327180812.37a590ea@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Metan,

On Mon, 27 Mar 2017 17:34:40 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

", ret);
> > +	if (sizeof(long) > 4)
> > +		tst_res(TCONF,
> > +			"The original vulnerability was only present in 32-bit compat mode");  
> 
> Why do we issue the TCONF at the end of the test? Shouldn't this be
> something do in the test setup?

Setup makes more sense.

> 
> Also we have tst_kernel_bits() in the test library, so we can do
> something as:
> 
> if (tst_kernel_bits() == 32 || sizeof(long) > 4)
> 	tst_res(TCONF, "...");

OK, great.

> 
> > +}
> > +
> > +static struct tst_test test = {
> > +	.tid = "cve-2016-4997",
> > +	.min_kver = "2.6.32",
> > +	.test_all = run,
> > +	.needs_root = 1,
> > +};  
> 
> I also wonder if we should compile the test with -m32 by default, we
> whould have to add a configure test if compilation with -m32 works
> though.
> 

Yes, I think that is best, but passing -m32 to the test's make target does not
cause the LTP library to be compiled with -m32 so linking fails. I'm not sure
how to get it to build both binaries.

Thank you,
Richard.
