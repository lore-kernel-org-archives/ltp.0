From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Jan 2019 12:39:35 -0500 (EST)
Subject: [LTP] [PATCH v3 2/3] lib/tst_test.c: Update result counters
 when calling tst_brk()
In-Reply-To: <20190107150619.GC15221@rei.lan>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1544690160-13900-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190107150619.GC15221@rei.lan>
Message-ID: <1383176395.93706380.1546882774990.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > 1) Catch and report the TFAIL exit status of child process.
> 
> Looking at the codebase we do have a few usages of tst_brk(TFAIL, "...")
> to exit the child process, which sort of works but it's incorrect. The
> tst_brk() always meant "unrecoverable failure have happened, exit the
> current process as fast as possible". Looking over our codebase most of
> the tst_brk(TFAIL, "...") should not actually cause the main test
> process to exit, these were only meant to exit the child and report the
> result in one call. It will for instance break the test with -i option
> on the first failure, which is incorrect.

Nice example, would you care to add that to docs?

> 
> So if we ever want to have a function to exit child process with a result we
> should implement tst_ret() that would be equivalent to tst_res() followed by
> exit(0).
> 
> It could be even implemented as:
> 
> #define tst_ret(ttype, fmt, ...) \
> 	do { \
> 		tst_res_(__FILE__, __LINE__, (ttype), (fmt), ##__VA_ARGS__); \
> 		exit(0); \
> 	} while (0)
> 
> This function has one big advantage, it increments the results counters
> before the child process exits.

If all call-sites switch to tst_ret(), we could add TFAIL to tst_brk
compile time check.

> 
> Actually one of the big points of the new test library was that the
> results counters are atomically increased, because passing the results
> in exit values is nightmare that cannot be done correclty.
> 
> > 2) Only update result counters in library process and main test
> >    process because the exit status of child can be reported by
> >    main test process.
> 
> Actually after I spend some time on it I think that the best solution is
> to update the results in the piece of shared memory as fast as possible,
> anything else is prone to various races and corner cases.

I was thinking this too.

If your parent process happens to wait for the child itself,
then library will never get to see retcode.

Regards,
Jan

> 
> > 3) Print TCONF message and increase skipped when calling tst_brk(TCONF).
> >    Print TBROK message and increase broken when calling tst_brk(TBROK).
> >    Print TFAIL message and increase failed when calling tst_brk(TFAIL).
> > 4) Remove duplicate update_results() in run_tcases_per_fs().
> 
> I've been thinking about this and the problem is more complex, and I'm
> even not sure that it's possible to write the library so that the
> counters are consistent at the time we exit the test if something
> unexpected happened and we called tst_brk().
> 
> Consider for instance this example:
> 
> #include "tst_test.h"
> 
> static void do_test(void)
> {
>         if (!SAFE_FORK())
>                 tst_brk(TBROK, "child");
>         tst_brk(TBROK, "parent");
> }
> 
> static struct tst_test test = {
>         .test_all = do_test,
>         .forks_child = 1,
> };
> 
> When tst_brk() is called both in parent and child the counter would be
> incremented only once because the child is not waited for by the main
> test.
> 
> We can close this special case by changing the main test pid to wait for the
> children before it calls exit() in the tst_brk() but that may cause the
> main process to get stuck undefinitely if the child processes get stuck,
> so we would have to be careful.
> 
> Also from the very definition of the TBROK return status the test
> results would be incomplete at best, since TBROK really means
> "unrecoverable error happened during the test" which would mostly means
> that something as low level as filesystem got corrupted and there is no
> point in presenting the results in that case, so I guess that the best
> we could do in the case of TBROK is to print big message that says
> "things went horribly wrong!" or something similar.
> 
> All in all I would like to avoid applying patches to the test library
> before we finalize the release, since there is not much time for
> testing now.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
