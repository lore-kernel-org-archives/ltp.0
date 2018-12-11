From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Dec 2018 12:16:49 +0100
Subject: [LTP] [PATCH v2]  cgroup_regression_test.sh: fixed test_5
In-Reply-To: <20181206164120.42877-1-cristian.marussi@arm.com>
References: <20181206164120.42877-1-cristian.marussi@arm.com>
Message-ID: <20181211111648.GA14703@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

> test_5 checked for possible regressions using a pair of cgroups mounts
> operations designed to expose a kernel crash; the trigger being the
> attempt to co-mount and mount the same cgroup subsystem onto two
> distinct fs hierarchies: the expected failure in the second mount
> attempt was not properly handled in 2.6.29-rc2 and lead to a kernel
> crash.
> Unfortunately the test assumed that the randomly chosen subsystems
> were NOT already mounted somewhere when attempting the first co-mount:
> this assumption is falsified when userspace is configured to mount all
> available subsystems at /sysfs on boot (systemd).
> So the test was failing straight away during the setup phase:

> cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:188: mount pids and hugetlb failed

> Being not trivial to forcibly release and unmount the populated
> /sysfs cgroups once booted, the script has been reviewed to detect
> this condition upfront and cope with it dynamically:

>  - if not already mounted: co-mount + failing mount (as before)
>  - already mounted: use existing mntpoint + failing co-mount

> Since the original fix was on a 2.6.29 kernel the surrounding cgroup
> code has changed a lot and so the patch was no more trivially 'revertable'
> for testing purposes: as such this reviewed test script has been verified
> using a QEMU x86_64 instance running a Kernel 2.6.39 with and without
> the known fix as detailed in test_5 comments.
Thanks for your testing.

> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for your patch! Two tiny details bellow.
...
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -253,6 +253,10 @@ test_4()
>  #---------------------------------------------------------------------------
>  test_5()
>  {
> +	local mounted
> +	local failing
> +	local t_mntpoint
I'd use just mntpoint. But that's nitpicking, up to you.

> +	cat /proc/mounts | grep cgroup | grep -q $subsys1 2> /dev/null && mounted=$subsys1
> +	[ -z "$mounted" ] && cat /proc/mounts | grep cgroup | grep -q $subsys2 2> /dev/null && mounted=$subsys2
Is stderr redirection really needed?

Kind regards,
Petr
