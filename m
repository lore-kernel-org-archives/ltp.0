From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Jan 2019 14:11:03 +0100
Subject: [LTP] [PATCH v3 2/3] lib/tst_test.c: Update result counters
 when calling tst_brk()
In-Reply-To: <1383176395.93706380.1546882774990.JavaMail.zimbra@redhat.com>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1544690160-13900-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190107150619.GC15221@rei.lan>
 <1383176395.93706380.1546882774990.JavaMail.zimbra@redhat.com>
Message-ID: <20190108131103.GB30528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So if we ever want to have a function to exit child process with a result we
> > should implement tst_ret() that would be equivalent to tst_res() followed by
> > exit(0).
> > 
> > It could be even implemented as:
> > 
> > #define tst_ret(ttype, fmt, ...) \
> > 	do { \
> > 		tst_res_(__FILE__, __LINE__, (ttype), (fmt), ##__VA_ARGS__); \
> > 		exit(0); \
> > 	} while (0)
> > 
> > This function has one big advantage, it increments the results counters
> > before the child process exits.
> 
> If all call-sites switch to tst_ret(), we could add TFAIL to tst_brk
> compile time check.

And it's even more complicated than this.

The problem is that if we add tst_ret() that calls exit(0) it will have
slightly different semantics for the main test process and for the
children.

The subtle difference is that we run the loop that executes the tests in
the case of the -i parameter or in the case that we defined tcnt is in
the main test process. If we call tst_ret() there it will exit the test
before we manage to run rest of the iterations and I would like to avoid
adding an API that is slightly confusing easy to misuse.

I will try to rethink this, however it looks like there is no silver
bullet to solve the problem. And it's certainly late for the release.

Also I've opened an issue for the problem in order not to forget:

https://github.com/linux-test-project/ltp/issues/462

-- 
Cyril Hrubis
chrubis@suse.cz
