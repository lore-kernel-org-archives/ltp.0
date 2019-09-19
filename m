From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 19 Sep 2019 17:54:56 +0800
Subject: [LTP] [PATCH] cgroup_regression_test.sh: Remove obselte test_5
In-Reply-To: <20190919094544.GA21345@rei>
References: <1568884247-2605-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190919094544.GA21345@rei>
Message-ID: <b79f97b5-8891-4c59-23b8-a127e8ad6589@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2019/09/19 17:45, Cyril Hrubis wrote:
> Hi!
>> test_5 is a very old regresstion test and kernel code has been
>> rewritten completely since 2.6. No user will use such old kernel
>> code to test. So I think we can remove it.
> 
> Unfortunatelly we also have to renumber the tests and change TST_CNT
> otherwise the test library will attempt to run a function that is not
> present.
> 
Oh, Sorry. I forgot it(I am not familiar with ltp shell test frame, I am 
going to read doc/test-writing-guidelines.txt). Also, I will send a v2 
patch.
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   .../cgroup/cgroup_regression_test.sh          | 75 -------------------
>>   1 file changed, 75 deletions(-)
>>
>> -------------------------
>> a discussion about it:
>> https://patchwork.ozlabs.org/patch/1113680/
>> -------------------------
>>
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> index e197f5d3f..a32ed172c 100755
>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> @@ -232,81 +232,6 @@ test4()
>>   	tst_res TPASS "no lockdep BUG was found"
>>   }
>>   
>> -#---------------------------------------------------------------------------
>> -# Bug:    When mount cgroup fs and the fs was busy, root_count should not be
>> -#         decremented in cgroup_kill_sb()
>> -# Kernel: 2.6.29-rcX
>> -# Links:  https://openvz.org/pipermail/devel/2009-January/016345.html
>> -#         http://lkml.org/lkml/2009/1/28/190
>> -# Fix:    commit 839ec5452ebfd5905b9c69b20ceb640903a8ea1a
>> -#---------------------------------------------------------------------------
>> -test5()
>> -{
>> -	local mounted
>> -	local failing
>> -	local mntpoint
>> -
>> -	local lines=`cat /proc/cgroups | wc -l`
>> -	if [ $lines -le 2 ]; then
>> -		tst_res TCONF "require at least 2 cgroup subsystems"
>> -		return
>> -	fi
>> -
>> -	local subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
>> -	local subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
>> -
>> -	# Accounting here for the fact that the chosen subsystems could
>> -	# have been already previously mounted at boot time: in such a
>> -	# case we must skip the initial co-mount step (which would
>> -	# fail anyway) and properly re-organize the $mntpoint and
>> -	# $failing params to be used in the following expected-to-fail
>> -	# mount action. Note that the subsysN name itself will be listed
>> -	# amongst mounts options.
>> -	get_cgroup_mountpoint $subsys1 >/dev/null && mounted=$subsys1
>> -	[ -z "$mounted" ] && get_cgroup_mountpoint $subsys2 >/dev/null && mounted=$subsys2
>> -	if [ -z "$mounted" ]; then
>> -		mntpoint=cgroup
>> -		failing=$subsys1
>> -		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/
>> -		if [ $? -ne 0 ]; then
>> -			tst_res TFAIL "mount $subsys1 and $subsys2 failed"
>> -			return
>> -		fi
>> -	else
>> -		# Use the pre-esistent mountpoint as $mntpoint and use a
>> -		# co-mount with $failing: this way the 2nd mount will
>> -		# also fail (as expected) in this 'mirrored' configuration.
>> -		mntpoint=$(get_cgroup_mountpoint $mounted)
>> -		failing=$subsys1,$subsys2
>> -	fi
>> -
>> -	# This 2nd mount has been properly configured to fail
>> -	mount -t cgroup -o $failing xxx $mntpoint/ 2> /dev/null
>> -	if [ $? -eq 0 ]; then
>> -		tst_res TFAIL "mount $failing should fail"
>> -		# Do NOT unmount pre-existent mountpoints...
>> -		[ -z "$mounted" ] && umount $mntpoint/
>> -		return
>> -	fi
>> -
>> -	mkdir $mntpoint/0
>> -	# Otherwise we can't attach task
>> -	if [ "$subsys1" = cpuset -o "$subsys2" = cpuset ]; then
>> -		echo 0 > $mntpoint/0/cpuset.cpus 2> /dev/null
>> -		echo 0 > $mntpoint/0/cpuset.mems 2> /dev/null
>> -	fi
>> -
>> -	sleep 100 &
>> -	echo $! > $mntpoint/0/tasks
>> -
>> -	kill -TERM $! > /dev/null
>> -	wait $! 2>/dev/null
>> -	rmdir $mntpoint/0
>> -	# Do NOT unmount pre-existent mountpoints...
>> -	[ -z "$mounted" ] && umount $mntpoint/
>> -	check_kernel_bug
>> -}
>> -
>>   #---------------------------------------------------------------------------
>>   # Bug:    There was a race between cgroup_clone and umount
>>   # Kernel: 2.6.24 - 2.6.28, 2.6.29-rcX
>> -- 
>> 2.18.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


