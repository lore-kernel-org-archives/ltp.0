From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2016 09:12:01 -0400 (EDT)
Subject: [LTP] [PATCH] cgroup_fj/cgroup_fj_common.sh:cpuset prefix issue
In-Reply-To: <1467960542-5177-1-git-send-email-shuang.qiu@oracle.com>
References: <1467960542-5177-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <848101059.3653487.1468242721685.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp@lists.linux.it
> Sent: Friday, 8 July, 2016 8:49:02 AM
> Subject: [LTP]  [PATCH] cgroup_fj/cgroup_fj_common.sh:cpuset prefix issue
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> Sometimes there is no cpuset. prefix for cpuset subsystem.
> Try either $mount_point/XXXX or $mount_point/cpuset.XXXX.

This appears to be due to legacy of:
  commit 8793d854edbc2774943a4b0de3304dc73991159a
  Author: Paul Menage <menage@google.com>
  Date:   Thu Oct 18 23:39:39 2007 -0700
    Task Control Groups: make cpusets a client of cgroups

so it depends on how you mount it:

# mount -t cpuset cpuset /mnt/test
# ls -la /mnt/test
total 0
drwxr-xr-x. 2 root root  0 Jul 11 15:01 .
drwxr-xr-x. 6 root root 63 Jul 11 14:58 ..
-rw-r--r--. 1 root root  0 Jul 11 15:01 cgroup.clone_children
--w--w--w-. 1 root root  0 Jul 11 15:01 cgroup.event_control
-rw-r--r--. 1 root root  0 Jul 11 15:01 cgroup.procs
-r--r--r--. 1 root root  0 Jul 11 15:01 cgroup.sane_behavior
-rw-r--r--. 1 root root  0 Jul 11 15:01 cpu_exclusive
-rw-r--r--. 1 root root  0 Jul 11 15:01 cpus
-rw-r--r--. 1 root root  0 Jul 11 15:01 mem_exclusive
-rw-r--r--. 1 root root  0 Jul 11 15:01 mem_hardwall
-rw-r--r--. 1 root root  0 Jul 11 15:01 memory_migrate
-r--r--r--. 1 root root  0 Jul 11 15:01 memory_pressure
-rw-r--r--. 1 root root  0 Jul 11 15:01 memory_pressure_enabled
-rw-r--r--. 1 root root  0 Jul 11 15:01 memory_spread_page
-rw-r--r--. 1 root root  0 Jul 11 15:01 memory_spread_slab
-rw-r--r--. 1 root root  0 Jul 11 15:01 mems
-rw-r--r--. 1 root root  0 Jul 11 15:01 notify_on_release
-rw-r--r--. 1 root root  0 Jul 11 15:01 release_agent
-rw-r--r--. 1 root root  0 Jul 11 15:01 sched_load_balance
-rw-r--r--. 1 root root  0 Jul 11 15:01 sched_relax_domain_level
-rw-r--r--. 1 root root  0 Jul 11 15:01 tasks

# mount -t cgroup -o cpuset cpuset /mnt/test
# ls -la /mnt/test
total 0
drwxr-xr-x. 2 root root  0 Jul 11 15:02 .
drwxr-xr-x. 6 root root 63 Jul 11 14:58 ..
-rw-r--r--. 1 root root  0 Jul 11 15:02 cgroup.clone_children
--w--w--w-. 1 root root  0 Jul 11 15:02 cgroup.event_control
-rw-r--r--. 1 root root  0 Jul 11 15:02 cgroup.procs
-r--r--r--. 1 root root  0 Jul 11 15:02 cgroup.sane_behavior
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.cpu_exclusive
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.cpus
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.mem_exclusive
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.mem_hardwall
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.memory_migrate
-r--r--r--. 1 root root  0 Jul 11 15:02 cpuset.memory_pressure
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.memory_pressure_enabled
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.memory_spread_page
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.memory_spread_slab
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.mems
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.sched_load_balance
-rw-r--r--. 1 root root  0 Jul 11 15:02 cpuset.sched_relax_domain_level
-rw-r--r--. 1 root root  0 Jul 11 15:02 notify_on_release
-rw-r--r--. 1 root root  0 Jul 11 15:02 release_agent
-rw-r--r--. 1 root root  0 Jul 11 15:02 tasks

Patch looks OK to me, description could be more verbose.

Regards,
Jan

> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  .../controllers/cgroup_fj/cgroup_fj_common.sh      |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index df2cbfc..13e2938 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -69,8 +69,13 @@ create_subgroup()
>      # cpuset.cpus and cpuset.mems must be initialized with suitable value
>      # before any pids are attached
>      if [ "$subsystem" == "cpuset" ]; then
> -        ROD cat "$mount_point/cpuset.cpus" \> "$path/cpuset.cpus"
> -        ROD cat "$mount_point/cpuset.mems" \> "$path/cpuset.mems"
> +        if [ -e "$mount_point/cpus" ]; then
> +            ROD cat "$mount_point/cpus" \> "$path/cpus"
> +            ROD cat "$mount_point/mems" \> "$path/mems"
> +        else
> +            ROD cat "$mount_point/cpuset.cpus" \> "$path/cpuset.cpus"
> +            ROD cat "$mount_point/cpuset.mems" \> "$path/cpuset.mems"
> +        fi
>      fi
>  }
>  
> --
> 1.7.9.5
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
