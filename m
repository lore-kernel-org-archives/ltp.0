From: Leo Liang <ycliang@andestech.com>
Date: Mon, 19 Jul 2021 16:35:21 +0800
Subject: [LTP] [PATCH v3,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <YPUgKpSqTLYVCSRF@pevik>
References: <20210716140235.GA22205@andestech.com>
 <YPUgKpSqTLYVCSRF@pevik>
Message-ID: <20210719083521.GA18406@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, Jul 19, 2021 at 02:48:10PM +0800, Petr Vorel wrote:
> > The test sequence
> > 	mount -t cgroup -o <controllers> <path>
> > 	mkdir <path>/<dir>
> > 	rmdir <path>/<dir>
> > 	umount <path>
> > 	mount -t cgroup -o <controllers> <path>
> > would easily fail at the last mount with -EBUSY on certain platform.
> 
> > The reason is that this test sequence would have the chance of
> > missing a release code path when doing rmdir and umount.
> 
> > Adding a little delay between "rmdir" and "umount" could fix the problem,
> > so use tst_umount API instead of umount in "rmdir, umount" sequence.
> 
> > Fixes: #839
> 
> > Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> >  .../controllers/cgroup/cgroup_regression_test.sh       | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> > diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > index 1f7f3820e..056166f11 100755
> > --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > @@ -145,7 +145,7 @@ test2()
> >  	fi
> 
> >  	rmdir cgroup/0 cgroup/1
> > -	umount cgroup/
> > +	tst_umount cgroup/
> As I note in previous patch, with suggested change to tst_umount() to always add
> trailing "/" it'd be enough just "tst_umount cgroup".
> 

I think your method is better that we don't alter the argument passed into tst_umount.
Let users decide the argument and honor the choice.

I will send a v4 patch later and still keep the trailing slash.

Thanks!

Best regards,
Leo

> I'm not sure what is better: automatic handling or having to explicitly add
> trailing "/".
> 
> Kind regards,
> Petr
> 
> >  }
> 
> >  #---------------------------------------------------------------------------
> > @@ -193,7 +193,7 @@ test3()
> >  	wait $pid2 2>/dev/null
> 
> >  	rmdir $cpu_subsys_path/0 2> /dev/null
> > -	umount cgroup/ 2> /dev/null
> > +	tst_umount cgroup/ 2> /dev/null
> >  	check_kernel_bug
> >  }
> 
> > @@ -222,7 +222,7 @@ test4()
> >  	mount -t cgroup -o none,name=foo cgroup cgroup/
> >  	mkdir cgroup/0
> >  	rmdir cgroup/0
> > -	umount cgroup/
> > +	tst_umount cgroup/
> 
> >  	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
> >  		tst_res TFAIL "lockdep BUG was found"
> > @@ -254,7 +254,7 @@ test5()
> >  	mount -t cgroup none cgroup 2> /dev/null
> >  	mkdir cgroup/0
> >  	rmdir cgroup/0
> > -	umount cgroup/ 2> /dev/null
> > +	tst_umount cgroup/ 2> /dev/null
> >  	check_kernel_bug
> >  }
> 
> > @@ -290,7 +290,7 @@ test6()
> 
> >  	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
> >  	rmdir cgroup/[1-9]* > /dev/null 2>&1
> > -	umount cgroup/
> > +	tst_umount cgroup/
> >  	check_kernel_bug
> >  }
