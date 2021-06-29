From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 07:01:43 +0000
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <20210628033002.GA1469@andestech.com>
References: <20210628033002.GA1469@andestech.com>
Message-ID: <60DAC584.7000500@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

IMO, Even we call sync, this umount may fail because sync ensures 
nothing.  Why not use tst_umount?

Best Regards
Yang Xu

>  From a151d48235629a125d5db57dd76c96fd951d5293 Mon Sep 17 00:00:00 2001
> From: Leo Yu-Chi Liang<ycliang@andestech.com>
> Date: Mon, 28 Jun 2021 11:05:54 +0800
> Subject: [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount failure
>
> The test sequence
> 	mount -t cgroup -o<controllers>  <path>
> 	mkdir<path>/<dir>
> 	rmdir<path>/<dir>
> 	umount<path>
> 	mount -t cgroup -o<controllers>  <path>
> would easily fail at the last mount with -EBUSY.
>
> The reason is that this test sequence have the chance of
> missing a release code path when doing rmdir and umount.
>
> Add sync between every "rmdir, umount" pair to fix the problem.
>
> Fixes: #839
>
> Signed-off-by: Leo Yu-Chi Liang<ycliang@andestech.com>
> ---
>   .../kernel/controllers/cgroup/cgroup_regression_test.sh    | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 1f7f3820e..9a00df101 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -145,6 +145,7 @@ test2()
>   	fi
>
>   	rmdir cgroup/0 cgroup/1
> +	sync
>   	umount cgroup/
>   }
>
> @@ -193,6 +194,7 @@ test3()
>   	wait $pid2 2>/dev/null
>
>   	rmdir $cpu_subsys_path/0 2>  /dev/null
> +	sync
>   	umount cgroup/ 2>  /dev/null
>   	check_kernel_bug
>   }
> @@ -222,6 +224,7 @@ test4()
>   	mount -t cgroup -o none,name=foo cgroup cgroup/
>   	mkdir cgroup/0
>   	rmdir cgroup/0
> +	sync
>   	umount cgroup/
>
>   	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
> @@ -254,6 +257,7 @@ test5()
>   	mount -t cgroup none cgroup 2>  /dev/null
>   	mkdir cgroup/0
>   	rmdir cgroup/0
> +	sync
>   	umount cgroup/ 2>  /dev/null
>   	check_kernel_bug
>   }
> @@ -290,6 +294,7 @@ test6()
>
>   	mount -t cgroup -o ns xxx cgroup/>  /dev/null 2>&1
>   	rmdir cgroup/[1-9]*>  /dev/null 2>&1
> +	sync
>   	umount cgroup/
>   	check_kernel_bug
>   }
> @@ -324,6 +329,7 @@ test_7_1()
>   	mkdir $subsys_path/0
>   	sleep 100<  $subsys_path/0&	# add refcnt to this dir
>   	rmdir $subsys_path/0
> +	sync
>
>   	# remount with new subsystems added
>   	# since 2.6.28, this remount will fail
> @@ -349,6 +355,7 @@ test_7_2()
>   	mkdir cgroup/0
>   	sleep 100<  cgroup/0&	# add refcnt to this dir
>   	rmdir cgroup/0
> +	sync
>
>   	# remount with some subsystems removed
>   	# since 2.6.28, this remount will fail
