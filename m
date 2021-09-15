From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Sep 2021 12:50:47 +0200
Subject: [LTP] [PATCH] controllers/cpuacct: Fix deleting directories
 errors
In-Reply-To: <1631699402-17607-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1631699402-17607-1-git-send-email-daisl.fnst@fujitsu.com>
Message-ID: <YUHQByoKzIm/cMfz@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dai, Xu,

> To remove a directory hierarchy on a normal file system you can use rm command to
> remove all files from each subdirectory and then remove the parent directories.
> But a cgroup which doesn't have any children and is associated only with zombie processes
> is considered empty and can not be removed by rm.
> The following errors will be reported.

> cpuacct 1 TINFO: removing created directories
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cgroup.procs': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.cfs_period_us': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.stat': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu_sys': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.shares': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.stat': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cgroup.procs': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.cfs_period_us': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.stat': Operation not permitted
> ...

> It's recommended to use rmdir command.

Sorry for introducing a regression and for correction.
I'll revert on your behalf commit d6cc08592 ("controllers/cpuacct: Simplify
deleting directories"), with your explanation.


Kind regards,
Petr


> [1] http://blog.tinola.com/?e=21
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/cgroup-v2.rst#n237

> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
> index 99258c2..f526d0f 100755
> --- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
> +++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
> @@ -122,7 +122,10 @@ cleanup()

>  	if [ "$testpath" ]; then
>  		tst_res TINFO "removing created directories"
> -		rm -rf $testpath
> +		if [ -d "$testpath/subgroup_1" ]; then
> +			rmdir $testpath/subgroup_*
> +		fi
> +			rmdir $testpath
>  	fi

>  	if [ "$mounted" -ne 1 ]; then
