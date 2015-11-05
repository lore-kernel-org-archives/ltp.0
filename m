From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Nov 2015 16:07:00 +0100
Subject: [LTP] [PATCH] controllers/cgroup_fj: fix the current problem of
 testcases
In-Reply-To: <1446520361-26496-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1446520361-26496-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151105150700.GA8409@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index 3167fab..c0cbb01 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -148,7 +148,7 @@ mkdir_subgroup;
>  
>  # cpuset.cpus and cpuset.mems should be specified with suitable value
>  # before attaching operation if subsystem is cpuset
> -if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
> +if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
>  	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
>  	if [ "$exist" != "" ]; then
>  		if [ "$noprefix_use" == "no" ]; then
> @@ -225,7 +225,7 @@ sleep 1
>  
>  # pid could not be echoed from subgroup if subsystem is ( or include ) ns,
>  # so we kill them here
> -if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
> +if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
>  	do_kill 1 1 9 $pid
>  	do_kill 1 1 9 $pid2

This is fixed in patch by Cedric whose third version should be final
one.

>  # removing operation
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> index daab096..93f9ea5 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> @@ -88,7 +88,7 @@ export TMPFILE=$TESTROOT/tmp_tasks
>  pid=0;
>  release_agent_para=1;
>  release_agent_echo=1;
> -subsystem_str=$subsystem;
> +get_subsystem;
>  if [ "$?" -ne "0" ] || [ "$#" -ne "5" ]; then
>  	usage;
>  	exit_parameter;
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> index 9782f45..9867ce6 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> @@ -54,38 +54,48 @@ get_subsystem()
>  {
>  	case $subsystem in
>  	"debug" )
> +		subsystem_str="debug"
>  		exist_subsystem;
>  		;;
>  	"cpuset" )
> +		subsystem_str="cpuset"
>  		exist_subsystem;
>  		;;
>  	"ns" )
> +		subsystem_str="ns"
>  		exist_subsystem;
>  		;;
>  	"cpu" )
> +		subsystem_str="cpu"
>  		exist_subsystem;
>  		;;
>  	"cpuacct" )
> +		subsystem_str="cpuacct"
>  		exist_subsystem;
>  		;;
>  	"memory" )
> +		subsystem_str="memory"
>  		exist_subsystem;
>  		;;
>  	"all" )
> +		subsystem_str="all"
>  		;;
>  	"none" )
> -		subsystem=""
> +		subsystem_str=""
>  		;;
>  	"debug,debug" )
> +		subsystem_str="debug,debug"
>  		exist_subsystem "debug";
>  		;;
>  	"nonexistent" )
> -		subsystem="abc";
> +		subsystem_str="abc";
>  		;;
>  	"freezer" )
> +		subsystem_str="freezer"
>  		exist_subsystem;
>  		;;
>  	"devices" )
> +		subsystem_str="devices"
>  		exist_subsystem;
>  		;;
>  	 *  )

I do not like this at all. Looking at the code the only problem we have
is that we compare "$subystem" with none while we should do [ -n "$subsystem" ]
instead.

Moreover this case should be change into two ifs. One that calls
exists_subsystem when subsystem is not "all" nor "none" and second one
that sets $subsytem to be empty when its set to "none".

> @@ -369,8 +379,11 @@ do_mount()
>  			echo "\"mount -t cgroup $para_o $something $target\" (expected: fail)"
>  		fi
>  	fi
> -
> -	mount -t cgroup $para_o $something $target
> +	if [ "$para_o" == "" ];then
> +		mount -t cgroup $para_o $something $target
> +	else
> +		mount -t cgroup "$para_o" $something $target
> +	fi
>  	do_exit $exit_here $expected $?;
>  }
>  

What is the exact problem here? does $para_o contain whitespaces in some
cases?

> @@ -557,11 +570,11 @@ mount_cgroup ()
>  {
>  	expected=1
>  	PARAMETER_O="";
> -	if [ "$subsystem" == "abc" ]; then
> +	if [ "$subsystem_str" == "abc" ]; then
>  		expected=0
>  	fi
> -	if [ "$subsystem" != "" ]; then
> -		PARAMETER_O="$subsystem"
> +	if [ "$subsystem_str" != "" ]; then
> +		PARAMETER_O="$subsystem_str"
>  	fi
>  	if [ "$noprefix_use_str" != "" ]; then
>  		if [ "$PARAMETER_O" != "" ]; then

Hmm, so to original code passed -onone in case subsystem was set to
"none". I cannot find what is that supposed to do in any documentation.
Is that the same as mounting it without any parameters?

-- 
Cyril Hrubis
chrubis@suse.cz
