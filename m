From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 13:05:26 +0000
Subject: [LTP] [PATCH] ttype: Replase TINFO with TPASS or TFAIL
Message-ID: <7acd6d963f8b478e83f10fea1f27bb75@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have split the commit to 4 separate commits and resubmit according your review. 

Pleas see:
https://patchwork.ozlabs.org/project/ltp/patch/20210429125322.31559-1-zhaogongyi@huawei.com/
https://patchwork.ozlabs.org/project/ltp/patch/20210429125255.31510-1-zhaogongyi@huawei.com/
https://patchwork.ozlabs.org/project/ltp/patch/20210429125237.31461-1-zhaogongyi@huawei.com/
https://patchwork.ozlabs.org/project/ltp/patch/20210429125220.31412-1-zhaogongyi@huawei.com/

And for the files fcntl19.c/fcntl20.c/fcntl21.c, there are some difficult problems to cleanup, it would be fixed in latter patches.


Thanks so much!

Best Regards,
Gongyi


> Hi!
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > index a77a81298..f12474f79 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> > @@ -673,10 +673,10 @@ int main(int ac, char **av)
> >  		 */
> >  		tst_resm(TINFO, "Entering block 1");
> >  		if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 11)) {
> > -			tst_resm(TINFO, "Test case 1: without mandatory "
> > +			tst_resm(TFAIL, "Test case 1: without mandatory "
> >  				 "locking FAILED");
> >  		} else {
> > -			tst_resm(TINFO, "Test case 1: without manadatory "
> > +			tst_resm(TPASS, "Test case 1: without manadatory "
> >  				 "locking PASSED");
> >  		}
> 
> I would be happier if we fixed the run_test() function to report
> TFAIL/TPASS in all cases and just called run_test() from the main().
> 
> It shouldn't be even a big change since we report most of the failures
> there, what we need is to change one TINFO into TFAIL and report TPASS at
> the end of the function.
> 
> >  		tst_resm(TINFO, "Exiting block 1");
> 
> Also can we please get rid of the useless entering/exitting block
> messages?
> 
> 
> And the same applies for the rest of the tests changed by this patch.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
