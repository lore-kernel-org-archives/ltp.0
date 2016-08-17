From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 11:29:38 +0200
Subject: [LTP] [PATCH] tst_test.h: fix tst_test->tid for unsupported
	cases
In-Reply-To: <20160817092211.GC5817@rei.lan>
References: <1471425396-26898-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160817092211.GC5817@rei.lan>
Message-ID: <20160817092938.GD5817@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  #define TST_TEST_TCONF(message)                                           \
> >  	static void tst_do_test(void) { tst_brk(TCONF, "%s", message); }; \
> > -        static struct tst_test test = { .test_all = tst_do_test }         \
> > -
> > +	static struct tst_test test = { .test_all = tst_do_test,          \
> > +					.tid = "tst_test_conf" }          \
> 
> I guess that a little better solution would be to pass the test id to
> the TST_TEST_TCONF() macro as well. I will fix that.

Hmm, we do not print the tid in case of TCONF, I thought we did, so we
can proceed with your patch as well.

-- 
Cyril Hrubis
chrubis@suse.cz
