From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 27 Jul 2017 11:19:11 +0800
Subject: [LTP] [PATCH] controllers/cgroup_fj_common.sh: Fix mountpoint
	mismatch
In-Reply-To: <1495620169-25851-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1495620169-25851-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <5b5c5779-5c33-eff2-7e4c-a674038fd788@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

Ping, thanks!

Best Regards,
Guangwen Feng

在 05/24/2017 06:02 PM, Guangwen Feng 写道:
> Only grepping subsystem name in /proc/cgroups may lead to mismatch, e.g.
> grep -w debug /proc/mounts will wrongly return debugfs /sys/kernel/debug
> debugfs as well, so fix this by adding a grep for "cgroup".
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index 2c8dfd3..907881c 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -93,7 +93,8 @@ setup()
>      tst_tmpdir
>      TST_CLEANUP=cleanup
>  
> -    mount_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`
> +    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
> +	cut -f 2 | cut -d " " -f2`
>  
>      if [ -z "$mount_point" ]; then
>          try_umount=1
> 


