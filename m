From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 6 May 2021 11:15:23 +0000
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
Message-ID: <de4753117e194231bc2d5c0b0762b5c1@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Before my MR merged, the test case would not eixt a nozero value, is it the root cause of the problem?

> 
> Hi Zhao, Cyril,
> 
> > diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
> b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
> ...
> > @@ -149,15 +132,13 @@ int main(int ac, char **av)
> >  		(void)waitpid(pid, &status, 0);
> 
> >  		if (WEXITSTATUS(status) != 0) {
> > -			flag = FAILED;
> >  			tst_resm(TFAIL, "Did not generate SEGV, child returned "
> >  				 "unexpected status");
> > -		}
> > -
> > -		if (flag) {
> > -			tst_resm(TINFO, "block 2 FAILED");
> >  		} else {
> > -			tst_resm(TINFO, "block 2 PASSED");
> > +			if (WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV))
> > +				tst_resm(TPASS, "generate SEGV as expected");
> > +			else
> > +				tst_resm(TFAIL, "Did not generate SEGV");
> FYI: since merging this patch (f5e8e6b11) test fails on this. Is it expected?
> I haven't looked closer whether it's a test bug or real issue.
> 
> Kind regards,
> Petr
