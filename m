From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 18 Jan 2019 18:09:10 +0800
Subject: [LTP] [PATCH] controllers/cgroup_regression_test.sh: Fix two
 issues
In-Reply-To: <7b0942d2-9111-375c-89ba-6cea22152d0b@arm.com>
References: <1547810171-4906-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <7b0942d2-9111-375c-89ba-6cea22152d0b@arm.com>
Message-ID: <5C41A5C6.9080205@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2019/01/17 20:59, Cristian Marussi 写道:
> Hi
>
> On 18/01/2019 11:16, Xiao Yang wrote:
>> 1) "umount cgroup" operation will umount pre-existent cgroup subsystem
>>     if "cgroup" mountpoint doesn't exist, because "cgroup" was treated
>>     as source(device) instead of target(mountpoint) in this case.  e.g.
>>     -----------------------------------------------------------
>>     cd /tmp
>>     mount -t cgroup -o cpu xxx cgroup/
>>     mount | egrep "cpu|pids"
>>     cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,pids)
>>     xxx on /tmp/cgroup type cgroup (rw,relatime,seclabel,cpu)
>>     umount cgroup
>>     mount | egrep "cpu|pids"
>>     cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,pids)
>>     umount cgroup
>>     mount | egrep "cpu|pids"
>>     (nothing)
>>     -----------------------------------------------------------
> ops..Good catch.
> Tested locally with your patch is fine.
>
> Reviewed-by: Cristian Marussi<cristian.marussi@arm.com>
Hi Cristian,

Thanks for your review and test.
Pushed, thanks.  :-)

Best Regards,
Xiao Yang

> Thanks
>
> Regards
>
> Cristian
>
>> 2) If pre-existent cgroup subsystem mountpoint is used, test3()
>>     may remove the directories that are not created by test.
>>
>> Fixes: 3cac1f80d ("cgroup: cgroup_regression_test.sh ported to newlib")
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   .../controllers/cgroup/cgroup_regression_test.sh   | 28 +++++++++++-----------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> index 0e17ad1..6868609 100755
>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> @@ -37,7 +37,7 @@ do_cleanup()
>>   {
>>   	if mountpoint -q cgroup/; then
>>   		find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
>> -		umount cgroup
>> +		umount cgroup/
>>   		rmdir cgroup
>>   	fi
>>   }
>> @@ -109,7 +109,7 @@ test1()
>>
>>   	kill -TERM $!
>>   	wait $! 2>/dev/null
>> -	umount cgroup
>> +	umount cgroup/
>>   	check_kernel_bug
>>   }
>>
>> @@ -145,7 +145,7 @@ test2()
>>   	fi
>>
>>   	rmdir cgroup/0 cgroup/1
>> -	umount cgroup
>> +	umount cgroup/
>>   }
>>
>>   #---------------------------------------------------------------------------
>> @@ -192,8 +192,8 @@ test3()
>>   	wait $pid1 2>/dev/null
>>   	wait $pid2 2>/dev/null
>>
>> -	rmdir $cpu_subsys_path/* 2>  /dev/null
>> -	umount cgroup 2>  /dev/null
>> +	rmdir $cpu_subsys_path/0 2>  /dev/null
>> +	umount cgroup/ 2>  /dev/null
>>   	check_kernel_bug
>>   }
>>
>> @@ -222,7 +222,7 @@ test4()
>>   	mount -t cgroup -o none,name=foo cgroup cgroup/
>>   	mkdir cgroup/0
>>   	rmdir cgroup/0
>> -	umount cgroup
>> +	umount cgroup/
>>
>>   	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
>>   		tst_res TFAIL "lockdep BUG was found"
>> @@ -285,7 +285,7 @@ test5()
>>   	if [ $? -eq 0 ]; then
>>   		tst_res TFAIL "mount $failing should fail"
>>   		# Do NOT unmount pre-existent mountpoints...
>> -		[ -z "$mounted" ]&&  umount $mntpoint
>> +		[ -z "$mounted" ]&&  umount $mntpoint/
>>   		return
>>   	fi
>>
>> @@ -303,7 +303,7 @@ test5()
>>   	wait $! 2>/dev/null
>>   	rmdir $mntpoint/0
>>   	# Do NOT unmount pre-existent mountpoints...
>> -	[ -z "$mounted" ]&&  umount $mntpoint
>> +	[ -z "$mounted" ]&&  umount $mntpoint/
>>   	check_kernel_bug
>>   }
>>
>> @@ -339,7 +339,7 @@ test6()
>>
>>   	mount -t cgroup -o ns xxx cgroup/>  /dev/null 2>&1
>>   	rmdir cgroup/[1-9]*>  /dev/null 2>&1
>> -	umount cgroup
>> +	umount cgroup/
>>   	check_kernel_bug
>>   }
>>
>> @@ -381,7 +381,7 @@ test_7_1()
>>   		mount -t cgroup -o remount xxx cgroup/ 2>  /dev/null
>>   		kill -TERM $!
>>   		wait $! 2>/dev/null
>> -		umount cgroup
>> +		umount cgroup/
>>   	fi
>>   }
>>
>> @@ -404,7 +404,7 @@ test_7_2()
>>   	mount -t cgroup -o remount,$subsys xxx cgroup/ 2>  /dev/null
>>   	kill -TERM $!
>>   	wait $! 2>/dev/null
>> -	umount cgroup
>> +	umount cgroup/
>>
>>   	grep -q -w "cpu" /proc/cgroups
>>   	if [ $? -ne 0 -o ! -e /proc/sched_debug ]; then
>> @@ -460,7 +460,7 @@ test8()
>>   		tst_res TFAIL "should have failed to get cgroupstat of tasks file"
>>   	fi
>>
>> -	umount cgroup
>> +	umount cgroup/
>>   	check_kernel_bug
>>   }
>>
>> @@ -484,7 +484,7 @@ test9()
>>   	wait $pid1 2>/dev/null
>>   	wait $pid2 2>/dev/null
>>
>> -	umount cgroup 2>  /dev/null
>> +	umount cgroup/ 2>  /dev/null
>>   	check_kernel_bug
>>   }
>>
>> @@ -510,7 +510,7 @@ test10()
>>   	mount -t cgroup none cgroup 2>  /dev/null
>>   	mkdir cgroup/0
>>   	rmdir cgroup/0
>> -	umount cgroup 2>  /dev/null
>> +	umount cgroup/ 2>  /dev/null
>>   	check_kernel_bug
>>   }
>>
>>
>



