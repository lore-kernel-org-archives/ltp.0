From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Sep 2015 20:23:21 +0200
Subject: [LTP] [PATCH V2] cgroup_fj: split the tests to run them
 separately and removed the LOGFILE
In-Reply-To: <1441807900-5570-1-git-send-email-chnyda@suse.com>
References: <1441807900-5570-1-git-send-email-chnyda@suse.com>
Message-ID: <20150924182321.GB1094@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +function_debug_yes_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 1 yes 2 3 2 1
> +function_debug_no_yes_1_yes_2_3_2_1 run_cgroup_test_fj.sh function debug no yes 1 yes 2 3 2 1
> +function_debug_yes_yes_2_yes_2_3_2_1 run_cgroup_test_fj.sh function debug yes yes 2 yes 2 3 2 1

The testcase names should be prefixed with 'cgroup_' otherwise it's not
clear that they are testing cgroups. Please fix this.

>  cpuset_base_ops	cpuset_base_ops_testset.sh
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index 673a942..2202708 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -120,23 +120,21 @@ usage()
>  }
>  
>  export TESTROOT=`pwd`
> -if [ "$LOGFILE" = "" ]; then
> -	LOGFILE="/dev/stdout"
> -fi
> +
>  export TMPFILE=$TESTROOT/tmp_tasks
>  
>  . $TESTROOT/cgroup_fj_utility.sh
>  
>  ##########################  main   #######################
>  if [ "$#" -ne "9" ]; then
> -	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE;
> +	echo "ERROR: Wrong inputed parameter..Exiting test";
>  	usage;
>  	exit -1;
>  fi
>  
> -echo "-------------------------------------------------------------------------" >> $LOGFILE
> -echo "case no : $CASENO1" >> $LOGFILE
> -echo `date` >> $LOGFILE
> +echo "-------------------------------------------------------------------------"
> +echo "case no : $CASENO1"
> +echo `date`
>  
>  check_para;
>  if [ $? -ne 0 ]; then
> @@ -145,7 +143,7 @@ if [ $? -ne 0 ]; then
>  fi
>  setup;
>  
> -echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
> +echo "INFO: now we begin to test no $CASENO1 ..."

Given that we are splitting the testcases we can remove this echo and
the echo above. There is no need to print the separators like '-----' to
the output since it will be separated by the test driver now.

>  mount_cgroup;
>  
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> index 2b47df1..57d131d 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
> @@ -10,7 +10,7 @@
>  ## (at your option) any later version.                                        ##
>  ##                                                                            ##
>  ## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## WITHOUT ANY WARRANTY; without evsen the implied warranty of MERCHANTABILITY ##
                                     ^
				     Newly introduced typo

>  ## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>  ## for more details.                                                          ##
>  ##                                                                            ##
> @@ -45,14 +45,11 @@ usage()
>  
>  exit_parameter()
>  {
> -	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
> +	echo "ERROR: Wrong inputed parameter..Exiting test"
>  	exit -1;
>  }
>  
>  export TESTROOT=`pwd`
> -if [ "$LOGFILE" = "" ]; then
> -	LOGFILE="/dev/stdout"
> -fi
>  export TMPFILE=$TESTROOT/tmp_tasks
>  
>  . $TESTROOT/cgroup_fj_utility.sh
> @@ -303,14 +300,14 @@ if [ "$#" -ne "1" ] || [ $caseno -lt 1 ] || [ $caseno -gt 13 ]; then
>  	exit_parameter;
>  fi
>  
> -echo "-------------------------------------------------------------------------" >> $LOGFILE
> -echo "case no : $CASENO1" >> $LOGFILE
> -echo `date` >> $LOGFILE
> +echo "-------------------------------------------------------------------------"
> +echo "case no : $CASENO1"
> +echo `date`
>  
>  exist_subsystem "debug"
>  setup;
>  
> -echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
> +echo "INFO: now we begin to test no $CASENO1 ..."

Here as well.

>  if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
>  	mount_cgroup;
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> index 972a717..fd9fa2a 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> @@ -76,14 +76,11 @@ usage()
>  
>  exit_parameter()
>  {
> -	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
> +	echo "ERROR: Wrong inputed parameter..Exiting test"
>  	exit -1;
>  }
>  
>  export TESTROOT=`pwd`
> -if [ "$LOGFILE" = "" ]; then
> -	LOGFILE="/dev/stdout"
> -fi
>  export TMPFILE=$TESTROOT/tmp_tasks
>  
>  . $TESTROOT/cgroup_fj_utility.sh
> @@ -150,13 +147,13 @@ case $subgroup_hiers in
>  esac
>  
>  ##########################  main   #######################
> -echo "-------------------------------------------------------------------------" >> $LOGFILE
> -echo "case no : $CASENO2" >> $LOGFILE
> -echo `date` >> $LOGFILE
> +echo "-------------------------------------------------------------------------"
> +echo "case no : $CASENO2"
> +echo `date`
>  
>  setup;
>  
> -echo "INFO: now we begin to stress test no $CASENO2 ..." >> $LOGFILE
> +echo "INFO: now we begin to stress test no $CASENO2 ..."

And here as well.

>  mount_cgroup;
>  
> @@ -209,9 +206,9 @@ if [ $mount_times -ne 1 ]; then
>  			fi
>  		fi
>  		let "count = $count + 1"
> -		echo "$count .. OK" >> $LOGFILE
> +		echo "$count .. OK"
>  	done
> -	echo "...executed $count times" >> $LOGFILE
> +	echo "...executed $count times"
>  else
>  	get_subgroup_path2 $subgroup_hiers
>  	count=0
> @@ -242,7 +239,7 @@ else
>  			pathes[$count]="$cur_subgroup_path1""$cur_subgroup_path2"
>  		done
>  	done
> -	echo "...mkdired $count times" >> $LOGFILE
> +	echo "...mkdired $count times"
>  
>  	sleep 1
>  
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> index 1e2e521..75c0dcb 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
> @@ -228,7 +228,7 @@ get_release_agent()
>  do_exit()
>  {
>  	if [ "$#" -ne "3" ]; then
> -		echo "ERROR: exit failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: exit failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -238,7 +238,7 @@ do_exit()
>  
>  	if [ $exit_status -eq 0 ] ;then
>  		if [ $expectted -lt 1 ]; then
> -			echo "								against with expectted" >> $LOGFILE
> +			echo "								against with expectted"
>  			if [ $exit_here -ge 1 ]; then
>  				cleanup;
>  				exit -1
> @@ -246,7 +246,7 @@ do_exit()
>  		fi
>  	else
>  		if [ $expectted -ge 1 ]; then
> -			echo "								against with expectted" >> $LOGFILE
> +			echo "								against with expectted"
>  			if [ $exit_here -ge 1 ]; then
>  				cleanup;
>  				exit -1
> @@ -263,7 +263,7 @@ do_exit()
>  do_echo()
>  {
>  	if [ "$#" -ne "4" ]; then
> -		echo "ERROR: echo failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: echo failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -274,20 +274,20 @@ do_echo()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"echo $value > $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"echo $value > $target\" (expectted: success)"
>  		else
> -			echo "\"echo $value > $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"echo $value > $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	`echo $value > $target` >> $LOGFILE 2>&1
> +	`echo $value > $target`
>  	do_exit $exit_here $expectted $?;
>  }
>  
>  do_mkdir()
>  {
>  	if [ "$#" -ne "3" ] && [ "$#" -ne "4" ]; then
> -		echo "ERROR: mkdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: mkdir failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -301,9 +301,9 @@ do_mkdir()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"mkdir $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"mkdir $target\" (expectted: success)"
>  		else
> -			echo "\"mkdir $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"mkdir $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> @@ -312,9 +312,9 @@ do_mkdir()
>  	fi
>  
>  	if [ $parents -ne "1" ]; then
> -		mkdir $target >> $LOGFILE 2>&1
> +		mkdir $target
>  	else
> -		mkdir -p $target >> $LOGFILE 2>&1
> +		mkdir -p $target
>  	fi
>  	do_exit $exit_here $expectted $?;
>  }
> @@ -322,7 +322,7 @@ do_mkdir()
>  do_rmdir()
>  {
>  	if [ "$#" -lt "3" ]; then
> -		echo "ERROR: rmdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: rmdir failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -331,26 +331,26 @@ do_rmdir()
>  	target=$3
>  
>  	if ! [ -e $target ]; then
> -		echo "INFO: $target is not exist" >> $LOGFILE
> +		echo "INFO: $target is not exist"
>  		return
>  	fi
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"rmdir $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"rmdir $target\" (expectted: success)"
>  		else
> -			echo "\"rmdir $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"rmdir $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	rmdir $3 $4 $5 >> $LOGFILE 2>&1
> +	rmdir $3 $4 $5
>  	do_exit $exit_here $expectted $?;
>  }
>  
>  do_mount()
>  {
>  	if [ "$#" -ne "4" ] && [ "$#" -ne "5" ] ; then
> -		echo "ERROR: mount failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: mount failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -365,20 +365,20 @@ do_mount()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)"
>  		else
> -			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	mount -t cgroup $para_o $something $target >> $LOGFILE 2>&1
> +	mount -t cgroup $para_o $something $target
>  	do_exit $exit_here $expectted $?;
>  }
>  
>  do_umount()
>  {
>  	if [ "$#" -ne "3" ]; then
> -		echo "ERROR: umount failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: umount failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -388,20 +388,20 @@ do_umount()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"umount $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"umount $target\" (expectted: success)"
>  		else
> -			echo "\"umount $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"umount $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	umount $target >> $LOGFILE 2>&1
> +	umount $target
>  	do_exit $exit_here $expectted $?;
>  }
>  
>  do_mv()
>  {
>  	if [ "$#" -ne "4" ]; then
> -		echo "ERROR: mv failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: mv failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -412,20 +412,20 @@ do_mv()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"mv $source $target\" (expectted: success)" >> $LOGFILE
> +			echo "\"mv $source $target\" (expectted: success)"
>  		else
> -			echo "\"mv $source $target\" (expectted: fail)" >> $LOGFILE
> +			echo "\"mv $source $target\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	mv $source $target >> $LOGFILE 2>&1
> +	mv $source $target
>  	do_exit $exit_here $expectted $?;
>  }
>  
>  do_kill()
>  {
>  	if [ "$#" -ne "4" ]; then
> -		echo "ERROR: kill failed,your parameter is wrong..Exiting test" >> $LOGFILE
> +		echo "ERROR: kill failed,your parameter is wrong..Exiting test"
>  		exit -1
>  	fi
>  
> @@ -440,13 +440,13 @@ do_kill()
>  
>  	if [ $no_debug -ne 1 ]; then
>  		if [ $expectted -ge 1 ]; then
> -			echo "\"kill -$signo $pid\" (expectted: success)" >> $LOGFILE
> +			echo "\"kill -$signo $pid\" (expectted: success)"
>  		else
> -			echo "\"kill -$signo $pid\" (expectted: fail)" >> $LOGFILE
> +			echo "\"kill -$signo $pid\" (expectted: fail)"
>  		fi
>  	fi
>  
> -	kill -s $signo $pid >> $LOGFILE 2>&1
> +	kill -s $signo $pid
>  	do_exit $exit_here $expectted $?;
>  }
>  
> @@ -464,7 +464,7 @@ setup()
>  		cp -f $TESTROOT/cgroup_fj_release_agent /root
>  		chmod a+x /root/cgroup_fj_release_agent
>  	else
> -		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test" >> $LOGFILE
> +		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test"
>  		exit -1;
>  	fi
>  
> @@ -476,7 +476,7 @@ setup()
>  	then
>  		chmod a+x $TESTROOT/cgroup_fj_proc
>  	else
> -		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test" >> $LOGFILE
> +		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test"
>  		exit -1;
>  	fi
>  }
> @@ -484,7 +484,7 @@ setup()
>  cleanup()
>  {
>  	if [ $no_debug -ne 1 ]; then
> -		echo "INFO: we now cleanup ..." >> $LOGFILE
> +		echo "INFO: we now cleanup ..."
>  	fi
>  
>  	export LANG=en_US.UTF-8
> @@ -547,7 +547,7 @@ reclaim_foundling()
>  mkdir_subgroup()
>  {
>  	if ! [ -e /dev/cgroup ]; then
> -		echo "ERROR: /dev/cgroup isn't exist..Exiting test" >> $LOGFILE
> +		echo "ERROR: /dev/cgroup isn't exist..Exiting test"
>  		exit -1;
>  	fi
>  
> @@ -613,7 +613,7 @@ check_para()
>  
>  	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret3 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ]
>  	then
> -		echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
> +		echo "ERROR: Wrong inputed parameter..Exiting test"
>  		return -1
>  	fi
>  
> diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
> index f0b43b8..c8e698b 100755
> --- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
> @@ -23,12 +23,21 @@
>  ################################################################################
>  cd $LTPROOT/testcases/bin
>  
> -export TCID="cgroup_test_fj"
> -export TST_TOTAL=194
> +
> +cnt=1
> +for arg; do
> +	if [ $cnt -gt 1 ]; then
> +		NAME+="_"
> +		NAME+=$arg
> +	fi
> +	cnt=$(( $cnt + 1 ))
> +done
> +
> +export TCID=$1$NAME
> +export TST_TOTAL=1
>  export TST_COUNT=1
>  
>  export TESTROOT=`pwd`
> -export LOGFILE=$LTPROOT/output/cgroup_fj_log_`date +%F`.txt
>  export TMPFILE=$TESTROOT/tmp_tasks
>  export CASENO1=0
>  export CASENO2=0
> @@ -86,47 +95,38 @@ if [ "$SYBSYSCOMPILED" = "" ];then	# Warning and exit if all cgroup subsystem ar
>  	exit -2;
>  fi
>  
> -echo "Now, we start the test for cgroup...";
> +echo `date`
> +echo `uname -a`
>  
> -rm -f $LOGFILE 2>/dev/null
> -echo `date` > $LOGFILE
> -echo `uname -a` >> $LOGFILE
> +echo ""

And we can remove the echo `date` and `uname -a` as well as it will only
add more useless output.

> -echo "" >> $LOGFILE
> -echo "Now, we start the test for basic function of cgroup..." >> $LOGFILE
> +CASETYPE=$1
> +shift
> +CASECMD=$@
>  
> -nlines=`cat cgroup_fj_testcases.sh | wc -l`
> -for i in `seq 1 $nlines`
> -do
> -	CASETYPE=`sed -n "$i""p" cgroup_fj_testcases.sh | cut -f1`
> -	CASECMD=`sed -n "$i""p" cgroup_fj_testcases.sh | cut -f2`
> -	echo $CASETYPE | grep "#"
> -	if [ $? -ne 0 ]; then
> -		case $CASETYPE in
> -		"function" )
> -			: $(( CASENO1 += 1 ))
> -			export CASENO1=$CASENO1
> -			$TESTROOT/cgroup_fj_function.sh $CASECMD
> -			;;
> -		"function2" )
> -			: $(( CASENO1 += 1 ))
> -			export CASENO1=$CASENO1
> -			$TESTROOT/cgroup_fj_function2.sh $CASECMD
> -			;;
> -		"stress" )
> -			: $(( CASENO2 += 1 ))
> -			export CASENO2=$CASENO2
> -			$TESTROOT/cgroup_fj_stress.sh $CASECMD
> -			;;
> -		esac
> +case $CASETYPE in
> +"function" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	$TESTROOT/cgroup_fj_function.sh $CASECMD
> +	;;
> +"function2" )
> +	: $(( CASENO1 += 1 ))
> +	export CASENO1=$CASENO1
> +	$TESTROOT/cgroup_fj_function2.sh $CASECMD
> +	;;
> +"stress" )
> +	: $(( CASENO2 += 1 ))
> +	export CASENO2=$CASENO2
> +	$TESTROOT/cgroup_fj_stress.sh $CASECMD
> +	;;
> +esac

Given that path to the LTP test binaries is in $PATH while testcases are
executed we just execute the script as 'cgroup_fj_stress.sh $CASECMD'
(without the full path).


Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
