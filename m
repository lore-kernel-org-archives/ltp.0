From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 10:27:40 +0200
Subject: [LTP] [PATCH 2/4] Test for CVE-2016-4997 on setsockopt
In-Reply-To: <20170327180812.37a590ea@linux-v3j5>
References: <20170323162633.7e49c7ae@linux-v3j5>
 <20170327153439.GD21272@rei.lan>
 <20170327180812.37a590ea@linux-v3j5>
Message-ID: <20170328082740.GA1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +static struct tst_test test = {
> > > +	.tid = "cve-2016-4997",
> > > +	.min_kver = "2.6.32",
> > > +	.test_all = run,
> > > +	.needs_root = 1,
> > > +};  
> > 
> > I also wonder if we should compile the test with -m32 by default, we
> > whould have to add a configure test if compilation with -m32 works
> > though.
> > 
> 
> Yes, I think that is best, but passing -m32 to the test's make target does not
> cause the LTP library to be compiled with -m32 so linking fails. I'm not sure
> how to get it to build both binaries.

Hmm, right, we would have to compile the test library for 32bit as well,
that may be tricky bussines. On the other hand there are at least two
other testcases that does not work when compiled for 64bits which would
make use of this as well.

-- 
Cyril Hrubis
chrubis@suse.cz
