From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Oct 2015 15:38:37 +0100
Subject: [LTP] [PATCH] controllers/cgroup_fj: fix
In-Reply-To: <1445355072-18524-1-git-send-email-chnyda@suse.com>
References: <1445355072-18524-1-git-send-email-chnyda@suse.com>
Message-ID: <20151027143837.GA29866@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Modified the structure of the tests to make them
> compatible with newer kernels

You should be more verbose and describe why these changes are needed.

I.e. that the cgroups are by default mounted and newer kernels does not
allow to mount them more than once...

Imagine yourself to be the one reviewing the patch and wondering why
exactly has changes and how these changes fixes that.

> Signed-off-by: Cedric Hnyda <chnyda@suse.com>
> ---
>  .../controllers/cgroup_fj/cgroup_fj_function.sh    | 38 ++++-----
>  .../controllers/cgroup_fj/cgroup_fj_stress.sh      | 46 ++++++-----
>  .../controllers/cgroup_fj/cgroup_fj_utility.sh     | 90 +++++++++++++++-------
>  3 files changed, 110 insertions(+), 64 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index 3167fab..4f32cc7 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -125,6 +125,8 @@ export TMPFILE=$TESTROOT/tmp_tasks
>  
>  . $TESTROOT/cgroup_fj_utility.sh
>  
> +mount_point="/dev/cgroup"
> +get_mount_point;

It would be a bit cleaner to do an echo in the get_mount_point (instead
of assigning global variable) and call this here as:

mount_point=$(get_mount_point)

Also setting the default value here is not clear way to do things. The
right path should be returned by the get_mount_point function, otherwise
we would have to fix all occurences when need to change the default
arrives.

> @@ -262,9 +264,9 @@ else
>  	esac
>  fi
>  
> -sleep 1
> +sleep 5

Why do we have to increase the sleep here? I'm certainly against this
unless there is no other solution. Adding sleep statements to testcases
increases the test runtime and makes continuous testing hard if not
impossible.

>  pid=0;
>  release_agent_para=1;
>  release_agent_echo=1;
> @@ -108,7 +111,7 @@ get_subgroup_path1()
>  		return;
>  	fi
>  
> -	cur_subgroup_path1="/dev/cgroup/subgroup_$1/"
> +	cur_subgroup_path1="$mount_point/subgroup_$1/"
>  }
>  
>  
> @@ -148,8 +151,11 @@ esac
>  
>  ##########################  main   #######################
>  
> -setup;
> +if ! [ "$subsystem" == "all" ] && ! [ "$subsystem" == "none" ] ; then
> +	exist_subsystem;
> +fi

This adds a check that subsystem exists before we run the tests. This
should be mentioned in the commit changelog as well.

>  		fi
>  		setup;
>  		$TESTROOT/cgroup_fj_proc &
>  		pid=$!
> -		mount_cgroup;
> +		if ! [ "$mount_point" == "/dev/cgroup" ] ; then
> +			mount_cgroup;
> +		fi

Hmm, this is a bit hacky. Maybe we should do "if cgroup is not mounted
-> mount it". Or set a some variable in get_mount_point() that would be
used to decide if we need to mount/umount it or not.

>  		mkdir_subgroup;
>  		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
>  			if [ "$exist_cpuset" != "" ]; then
> -				do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
> -				do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
> +				do_echo 1 1 "$cpus" $mount_point/subgroup_1/cpuset.cpus;
> +				do_echo 1 1 "$mems" $mount_point/subgroup_1/cpuset.mems;
>  			fi
>  		fi
>  		let "count = $count + 1"
> @@ -236,7 +244,7 @@ else
>  	done
>  	echo "...mkdired $count times"
>  
> -	sleep 1
> +	sleep 5

Here (the sleep) as well.

>  	case $attach_operation in
>  	"1" )
> @@ -244,12 +252,12 @@ else
>  		do
>  			do_echo 1 1 $pid "${pathes[$i]}""tasks"
>  		done
> -		do_echo 1 1 $pid /dev/cgroup/tasks
> +		do_echo 1 1 $pid $mount_point/tasks
>  		;;
>  	"2" )
> -		pathes2[0]="/dev/cgroup/"
> +		pathes2[0]="$mount_point"
>  		pathes2[1]="${pathes[$count]}"
> -		pathes2[3]="/dev/cgroup/"
> +		pathes2[3]="$mount_point/"
>  		for i in `seq 1 $nlines`
>  		do
>  			j=$i
> @@ -271,8 +279,8 @@ else
>  	"3" )
>  		count2=$count
>  		let "count2 = $count2 + 1"
> -		pathes[0]="/dev/cgroup/"
> -		pathes[$count2]="/dev/cgroup/"
> +		pathes[0]="$mount_point/"
> +		pathes[$count2]="$mount_point/"
>  		for i in `seq 0 $count`
>  		do
>  			j=$i
> @@ -303,7 +311,7 @@ else
>  	done
>  fi
>  
> -do_rmdir 0 1 /dev/cgroup/subgroup_*
> +do_rmdir 0 1 $mount_point/subgroup_*
>  
>  sleep 1
>  
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> index 9782f45..1228c96 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> @@ -50,6 +50,25 @@ exist_subsystem()
>  	fi
>  }
>  
> +get_mount_point()
> +{
> +	mount_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`;
                                                                                 ^
								No need for semicolon

So the mount_point is initialized to the /dev/cgroup/ in the test script
but first thing this function does is to change it whatever we found in
/proc/mounts (which may be empty string).


> +	if [ "$subsystem" = "none" ] && [ -e /sys/fs/cgroup/ ]; then
> +		mount_point="/sys/fs/cgroup"
> +	fi
> +
> +	if [ "$subsystem" = "all" ] && [ -e /sys/fs/cgroup/ ];  then
> +		mount_point="/sys/fs/cgroup"
> +	fi
> +
> +	if [ "$mount_point" = "" ]; then
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	echo "mount_point is: $mount_point" 
                                           ^
			             trailing whitespace
> +}


>  get_subsystem()
>  {
>  	case $subsystem in
> @@ -234,18 +253,17 @@ do_exit()
>  	fi
>  
>  	exit_here=$1
> -	expectted=$2
> +	expected=$2
>  	exit_status=$3
> -
>  	if [ $exit_status -eq 0 ] ;then
> -		if [ $expectted -lt 1 ]; then
> +		if [ $expected -lt 1 ]; then
>  			if [ $exit_here -ge 1 ]; then
>  				cleanup;
>  				exit -1
>  			fi
>  		fi
>  	else
> -		if [ $expectted -ge 1 ]; then
> +		if [ $expected -ge 1 ]; then
>  			if [ $exit_here -ge 1 ]; then
>  				cleanup;
>  				exit -1
> @@ -369,7 +387,7 @@ do_mount()
>  			echo "\"mount -t cgroup $para_o $something $target\" (expected: fail)"
>  		fi
>  	fi

It's better to keep formatting changes separate from functional ones.
Not that this is significant enough to be in separate patch, but you
should at least add a line like this in the commit message:

* Small cleanup

> +	echo mount -t cgroup $para_o $something $target
>  	mount -t cgroup $para_o $something $target
>  	do_exit $exit_here $expected $?;
>  }
> @@ -451,10 +469,22 @@ do_kill()
>  
>  setup()
>  {
> -	if [ -e /dev/cgroup ]; then
> +	echo $mount_point ----

We shouldn't add another debug print here, the mount point is printed in
the get_mount_point function allready, isn't it?

> +	# Current test will fail if the previous one failed to rmdir
> +	# so try to remove all subgroups
> +	rm -rf $mount_point/subgroup_*
> +
> +	if [ -e $mount_point ] && [ "$mount_point" == "/dev/cgroup" ]; then
> +		rm -rf /dev/cgroup
>  		cleanup;
> +		do_mkdir 1 1 $mount_point

Here as well, we should reason about the deletion/creation depending on
some global flag not on the mount_point being set to /dev/cgroup

>  	fi
> -	do_mkdir 1 1 /dev/cgroup
> +
> +	if [ "$mount_point" == "/dev/cgroup" ]; then
> +		do_mkdir 1 1 $mount_point
> +	fi

Here we create the mount point, so we should remove the do_mkdir from
the previous if.

>  	if [ -e $TESTROOT/cgroup_fj_release_agent ]
>  	then
> @@ -493,47 +523,49 @@ cleanup()
>  
>  	killall -9 cgroup_fj_proc 1>/dev/null 2>&1;
>  
> -	if [ -e /dev/cgroup/subgroup_1 ]; then
> -		cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
> +	if [ -e $mount_point/subgroup_1 ]; then
> +		cat $mount_point/subgroup_1/tasks > $TMPFILE
>  		nlines=`cat $TMPFILE | wc -l`
>  		for i in `seq 1 $nlines`
>  		do
>  			cur_pid=`sed -n "$i""p" $TMPFILE`
>  			if [ -e /proc/$cur_pid/ ];then
> -				do_echo 0 1 "$cur_pid" /dev/cgroup/tasks
> +				do_echo 0 1 "$cur_pid" $mount_point/tasks
>  			fi
>  		done
> -		do_rmdir 0 1 /dev/cgroup/subgroup_*
> +		do_rmdir 0 1 $mount_point/subgroup_*
>  	fi
>  
>  	if [ -e $TMPFILE ]; then
>  		rm -f $TMPFILE 2>/dev/null
>  	fi
>  
> -	mount_str="`mount -l | grep /dev/cgroup`"
> -	if [ "$mount_str" != "" ]; then
> -		do_umount 0 1 /dev/cgroup
> -	fi
> -
> -	if [ -e /dev/cgroup ]; then
> -		do_rmdir 0 1 /dev/cgroup
> +	if [ "$mount_point" = "/dev/cgroup" ] ; then
> +		mount_str="`mount -l | grep $mount_point`"
> +		if [ "$mount_str" != "" ]; then
> +			do_umount 0 1 $mount_point
> +		fi
> +		if [ -e $mount_point ]; then
> +			echo "about to rm $mount_point"
> +			do_rmdir 0 1 $mount_point
> +		fi
>  	fi

And here same as in the setup.

>  }
>  
>  reclaim_foundling()
>  {
> -	if ! [ -e /dev/cgroup/subgroup_1 ]; then
> +	if ! [ -e $mount_point/subgroup_1 ]; then
>  		return
>  	fi
>  	foundlings=0
> -	cat `find /dev/cgroup/subgroup_* -name "tasks"` > $TMPFILE
> +	cat `find $mount_point/subgroup_* -name "tasks"` > $TMPFILE
>  	nlines=`cat "$TMPFILE" | wc -l`
>  	for k in `seq 1 $nlines`
>  	do
>  		cur_pid=`sed -n "$k""p" $TMPFILE`
>  		if [ -e /proc/$cur_pid/ ];then
>  			echo "ERROR: pid $cur_pid reclaimed"
> -			do_echo 0 1 "$cur_pid" "/dev/cgroup/tasks"
> +			do_echo 0 1 "$cur_pid" "$mount_point/tasks"
>  			: $((foundlings += 1))
>  		fi
>  	done
> @@ -545,18 +577,22 @@ reclaim_foundling()
>  
>  mkdir_subgroup()
>  {
> -	if ! [ -e /dev/cgroup ]; then
> -		echo "ERROR: /dev/cgroup doesn't exist... Exiting test"
> +	if ! [ -e $mount_point ]; then
> +		echo "ERROR: $mount_point doesn't exist... Exiting test"
>  		exit -1;
>  	fi
>  
> -	do_mkdir 1 1 /dev/cgroup/subgroup_1
> +	do_mkdir 1 1 $mount_point/subgroup_1

Since we are touching the code it would be better to rename the
subgroup_1 to start with 'ltp_' prefix to make sure that we will not
collide with anything else on the system. But that should be done in
followup patch.

>  }
>  
>  mount_cgroup ()
>  {
>  	expected=1
>  	PARAMETER_O="";
> +
> +	if ! [ "$mount_point" == "/dev/cgroup" ] ; then
> +		return 0
> +	fi

So we actually do not mount the mount_point when it's mounted. I guess
that the ifs in the tests that does not call this function when it's
mounted are leftovers then.

But still we should reason here given something different than the
mount_point == /dev/cgroup. I guess that the best would be global
variable set in get_mount_point.

Or we can cram it all into mount_cgroup() function and make it
initialize the mount_point variable, mount the cgroup, if needed, and
set up needs_umount variable that would be used in umount_cgroup()
function that would be called from test cleanup in order to clean
things.

>  	if [ "$subsystem" == "abc" ]; then
>  		expected=0
>  	fi
> @@ -579,10 +615,10 @@ mount_cgroup ()
>  	fi
>  	if [ "$remount_use_str" != "" ]; then
>  		if [ "$PARAMETER_O" != "" ]; then
> -			do_mount 1 1 "-o$PARAMETER_O" /dev/cgroup
> +			do_mount 1 1 "-o$PARAMETER_O" $mount_point
>  			PARAMETER_O="$PARAMETER_O"",""$remount_use_str"
>  		else
> -			do_mount 1 1 "" /dev/cgroup
> +			do_mount 1 1 "" $mount_point
>  			PARAMETER_O="$remount_use_str"
>  		fi
>  		sleep 1
> @@ -592,7 +628,7 @@ mount_cgroup ()
>  		PARAMETER_O="-o""$PARAMETER_O"
>  	fi
>  
> -	do_mount 1 $expected "$PARAMETER_O" /dev/cgroup
> +	do_mount 1 $expected "$PARAMETER_O" $mount_point
>  }
>  
>  check_para()
> -- 
> 2.1.4
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
