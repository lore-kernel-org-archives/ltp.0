From: Caspar Zhang <caspar@linux.alibaba.com>
Date: Fri, 31 May 2019 00:40:05 +0800
Subject: [LTP] [PATCH 1/3] tst_test: fix again when test has both TPASS
 and TCONF
In-Reply-To: <20190530151843.GA25602@rei>
References: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
 <20190530151843.GA25602@rei>
Message-ID: <20190530164005.GB57736@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 30, 2019 at 05:18:43PM +0200, Cyril Hrubis wrote:
> Hi!
> > Consider this situation: we get only TPASS and TCONF in test
> > results, and the last status happens to be TPASS, the check
> > condition in commit fecdd885eb4b ("tst_test: Fix exit value on
> > tst_brk(TCONF, ...)" won't work. Fix it by removing unnecessary
> > TCONF check.
>
> What is the exact sequence of the tst_res()/tst_brk() calls leading to
> this?
>
> Because if the test function has exitted with 0 the do_exit() function
> would be passed 0 and that case is handled already:
>
> 	if (results->skipped && !results->passed)
> 		ret |= TCONF;

Hmm... you are right, the original fix was absolutely correct. Please
feel free to ignore this patch. Sorry for the noise ;-)

Thanks,
Caspar


>
> > Fixes: 5390d6ea3657 ("lib/tst_test: Report 0 if test has both TPASS and TCONF")
> > Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
> > ---
> >  lib/tst_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 2d88adbd7..8ba122fbe 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -594,7 +594,7 @@ static void do_exit(int ret)
> >  		printf("skipped  %d\n", results->skipped);
> >  		printf("warnings %d\n", results->warnings);
> >
> > -		if (results->passed && ret == TCONF)
> > +		if (results->passed)
> >  			ret = 0;
>
> --
> Cyril Hrubis
> chrubis@suse.cz

--
        Thanks,
        Caspar
