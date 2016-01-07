From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Jan 2016 14:27:49 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
Message-ID: <20160107132748.GA13423@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1) https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h#L65
> I did like there is option for test_all(). One concern I had was
> that forcing everybody to use test(int) was too restrictive.
> For example, you want to pass more parameters than just testcase #.
> Also not all tests follow "static struct tcase {" idiom, with single
> test function that is fed different arguments. I think test_all()
> gives us more flexibility. I was also thinking if library should
> care about "tcnt".

My primary concern for adding the test_all() was a bit different. There
are testcases where tests depends on each other and must be executed in
exact order. So instead of adding overly complicated way how to express
the dependencies I've added a possibility to run all tests in one
function. But yes the concern that enforcing too strict format may
complicate the conversion of the testcases was there as well.

> 2) https://github.com/metan-ucw/ltp/blob/master/lib/tst_test.c#L218-L219
> This also looks more strict requirement than what we had until now.
> It requires to count exactly how many PASS/FAIL there are.
> Is extra PASS or SKIP message a reason to fail the test with brk?

That depends. If we want to produce more structured/detailed logs than
PASS/FAIL/SKIP for one test binary we should be more strict about this.
Since at the moment single skipped testcase marks the whole test as
skipped. I would like to get to the state where the test result rather
says: "9 passed 1 skipped".

> 3) cleanup and children
> I know, it's a proof of concept :-).

I wasn't looking into thread safety either. So far it's just a sketch of
API + very minimal implementation.

> 4) After first reading, I'm not sure I have clear picture of changes in API.
> From what I gathered these are main changes:
>   test.h -> tst_test.h
>   tst_resm -> tst_res
>   tst_brkm -> tst_brk
>   safe_macros.h -> tst_safe_macros.h (now included via tst_test.h)

I've tried to do the changes in a way that old and new library can
coexist for some time, since I guess that the conversion would take
quite a lot of time. That is the main reason for the tst_resm -> tst_res
change. The safe_macros header was split into two, the new one does not
take the cleanup parameter and calls the same functions (as the old one)
but with with NULL passed a the callback. What wasn't done yet is
rerouting tst_resm()/tst_brkm() to the new library in case that new
library is used so that rest of the code in lib/ can be called from the
new library.

-- 
Cyril Hrubis
chrubis@suse.cz
