From: Leo Liang <ycliang@andestech.com>
Date: Mon, 19 Jul 2021 16:20:15 +0800
Subject: [LTP] [PATCH v3,
 2/2] cgroup/cgroup_regression_test: Fix umount failure
In-Reply-To: <60F50C8E.6020405@fujitsu.com>
References: <20210716140235.GA22205@andestech.com>
 <60F50C8E.6020405@fujitsu.com>
Message-ID: <20210719082015.GB27093@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

On Mon, Jul 19, 2021 at 01:24:12PM +0800, xuyang2018.jy@fujitsu.com wrote:
> Hi Leo
> > The test sequence
> > 	mount -t cgroup -o<controllers>  <path>
> > 	mkdir<path>/<dir>
> > 	rmdir<path>/<dir>
> > 	umount<path>
> > 	mount -t cgroup -o<controllers>  <path>
> > would easily fail at the last mount with -EBUSY on certain platform.
> >
> > The reason is that this test sequence would have the chance of
> > missing a release code path when doing rmdir and umount.
> >
> > Adding a little delay between "rmdir" and "umount" could fix the problem,
> > so use tst_umount API instead of umount in "rmdir, umount" sequence.
> >
> > Fixes: #839
> >
> > Signed-off-by: Leo Yu-Chi Liang<ycliang@andestech.com>
> > ---
> >   .../controllers/cgroup/cgroup_regression_test.sh       | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > index 1f7f3820e..056166f11 100755
> > --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> > @@ -145,7 +145,7 @@ test2()
> >   	fi
> >
> >   	rmdir cgroup/0 cgroup/1
> > -	umount cgroup/
> With adding a comment like
> # Avoid possible EBUSY error
> 
> so when other converts this case into new api, they will keep to use 
> tst_umount.
> 

No problem! Will do in the next version!
Thanks!

Best regards,
Leo

> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > +	tst_umount cgroup/
> >   }
> >
> >   #---------------------------------------------------------------------------
> > @@ -193,7 +193,7 @@ test3()
> >   	wait $pid2 2>/dev/null
> >
> >   	rmdir $cpu_subsys_path/0 2>  /dev/null
> > -	umount cgroup/ 2>  /dev/null
> > +	tst_umount cgroup/ 2>  /dev/null
> >   	check_kernel_bug
> >   }
> >
> > @@ -222,7 +222,7 @@ test4()
> >   	mount -t cgroup -o none,name=foo cgroup cgroup/
> >   	mkdir cgroup/0
> >   	rmdir cgroup/0
> > -	umount cgroup/
> > +	tst_umount cgroup/
> here as well
> >
> >   	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
> >   		tst_res TFAIL "lockdep BUG was found"
> > @@ -254,7 +254,7 @@ test5()
> >   	mount -t cgroup none cgroup 2>  /dev/null
> >   	mkdir cgroup/0
> >   	rmdir cgroup/0
> > -	umount cgroup/ 2>  /dev/null
> > +	tst_umount cgroup/ 2>  /dev/null
> >   	check_kernel_bug
> >   }
> >
> > @@ -290,7 +290,7 @@ test6()
> >
> >   	mount -t cgroup -o ns xxx cgroup/>  /dev/null 2>&1
> >   	rmdir cgroup/[1-9]*>  /dev/null 2>&1
> > -	umount cgroup/
> > +	tst_umount cgroup/
> here as well
> >   	check_kernel_bug
> >   }
> >
