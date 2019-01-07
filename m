From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jan 2019 19:29:25 +0100
Subject: [LTP] [PATCH v3 2/3] lib/tst_test.c: Update result counters
 when calling tst_brk()
In-Reply-To: <1383176395.93706380.1546882774990.JavaMail.zimbra@redhat.com>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1544690160-13900-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190107150619.GC15221@rei.lan>
 <1383176395.93706380.1546882774990.JavaMail.zimbra@redhat.com>
Message-ID: <20190107182925.GE15221@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Looking at the codebase we do have a few usages of tst_brk(TFAIL, "...")
> > to exit the child process, which sort of works but it's incorrect. The
> > tst_brk() always meant "unrecoverable failure have happened, exit the
> > current process as fast as possible". Looking over our codebase most of
> > the tst_brk(TFAIL, "...") should not actually cause the main test
> > process to exit, these were only meant to exit the child and report the
> > result in one call. It will for instance break the test with -i option
> > on the first failure, which is incorrect.
> 
> Nice example, would you care to add that to docs?

Good idea.

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

Actually I've started to work on that and all call sites can either be
converted to tst_ret(TFAIL, ...) or tst_brk(TBROK, ...). So it really
looks like we should go this way.

Also I guess that this may be even safe enough to go in before the
release. I will try to finish and post it tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz
