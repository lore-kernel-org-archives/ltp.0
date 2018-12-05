From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 5 Dec 2018 19:16:41 +0100
Subject: [LTP] [PATCH]  cgroup_regression_test.sh: fixed test_5
In-Reply-To: <20181121134021.52225-1-cristian.marussi@arm.com>
References: <20181121134021.52225-1-cristian.marussi@arm.com>
Message-ID: <20181205181640.GA11567@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

Thanks for your patch.

...
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../cgroup/cgroup_regression_test.sh          | 51 +++++++++++++------

...
> +	# Accounting here for the fact that the chosen subsystems could
> +	# have been already previously mounted at boot time: in such a
> +	# case we must skip the initial co-mount step (which would
> +	# fail anyway) and properly re-organize the $tst_mntpoint and
> +	# $failing_subsys params to be used in the following expected-to-fail
> +	# mount action.
> +	already_mounted_subsys=none
Better would be, to be as local (defined at top, I know there are other
variables without local) and empty:
It's a bit long variable name, how about simple mounted (or mounted_subs)?
local mounted

> +	mount | grep cgroup | grep -q $subsys1 && already_mounted_subsys=$subsys1
> +	mount | grep cgroup | grep -q $subsys2 && already_mounted_subsys=$subsys2
> +        if [ "x$already_mounted_subsys" == "xnone" ]; then
'==' is a bashism, use simple '='. When empty as default, then check would be:
if [ -z "$mounted" ]; then

> +		tst_mntpoint=cgroup
> +		failing_subsys=$subsys1
> +		mount -t cgroup -o $subsys1,$subsys2 xxx $tst_mntpoint/
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
> +			failed=1
> +			return
> +		fi
> +	else
> +		# Use the pre-esistent mountpoint as $tst_mntpoint and use a
> +		# co-mount with $failing_subsys: this way the 2nd mount will
> +		# also fail (as expected) in this 'mirrored' configuration.
> +		tst_mntpoint=$(mount | grep cgroup | grep $already_mounted_subsys | cut -d ' ' -f 3)
Maybe use awk, when it's used before?
> +		failing_subsys=$subsys1,$subsys2
>  	fi

> -	# This 2nd mount should fail
> -	mount -t cgroup -o $subsys1 xxx cgroup/ 2> /dev/null
> +	# This 2nd mount has been properly configured to fail
> +	mount -t cgroup -o $failing_subsys xxx $tst_mntpoint/ 2> /dev/null
>  	if [ $? -eq 0 ]; then
> -		tst_resm TFAIL "mount $subsys1 should fail"
> -		umount cgroup/
> +		tst_resm TFAIL "mount $failing_subsys should fail"
> +		# Do NOT unmount pre-existent mountpoints...
> +	        [[ "x$already_mounted_subsys" == "xnone" ]] && umount $tst_mntpoint
Also == here, here also with double square brackets, which are also bashism (use
single brackets).


...
>  	check_kernel_bug
>  	if [ $? -eq 1 ]; then
> @@ -296,8 +316,9 @@ test_5()
>  	# clean up
>  	/bin/kill -SIGTERM $! > /dev/null
>  	wait $!
> -	rmdir cgroup/0
> -	umount cgroup/
> +	rmdir $tst_mntpoint/0
> +	# Do NOT unmount pre-existent mountpoints...
> +	[[ "x$already_mounted_subsys" == "xnone" ]] && umount $tst_mntpoint
And the same here.

+ as with many tests, this tests needs rewrite into new API and cleanup.


Kind regards,
Petr
