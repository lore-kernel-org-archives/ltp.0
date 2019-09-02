From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 2 Sep 2019 15:44:46 +0800
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fix test_5 possible
 mount failure because of cgroup hierarchy
In-Reply-To: <5D440CAA.9080701@cn.fujitsu.com>
References: <1560250815-2308-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5D2D681D.1050909@cn.fujitsu.com> <5D440CAA.9080701@cn.fujitsu.com>
Message-ID: <5D6CC86E.5020009@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
Have somebody noticed this patch? ping.:-)
> Hi
> Ping. :-)
>> Hi 
>>
>> Ping.  :-) 
>>
>>> Currently, if systems doesn't mount subsys1,subsys2 and the hierarchy is not equal to 0, running it
>>> reports the following error:
>>>
>>> mount: xxx is already mounted or /tmp/ltp-wPw08anmTI/LTP_cgroup_regression_test.V4jf0qrS7z/cgroup busy
>>> cgroup_regression_test 5 TFAIL: mount net_prio and pids failed
>>>
>>> It fails because libcgroup doesn't permmit destroy cgroup subsystem hierarchies.
>>> Simple umnout does not destroy the hierarchies. They still live inside kernel!
>>>
>>> When  hierarchy is equal to 0 in /proc/cgroups, we can mount them together on
>>> a new mountpoint.
>>>
>>> I add a check for subsystem hierarchy and get subsystem from head.
>>>
>>> Notice:
>>> more information about"Bug 612805 - cgroup: mount: none already mounted or /cgroups busy"
>>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>>  .../cgroup/cgroup_regression_test.sh           | 18 +++++++++++++-----
>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>>> index e197f5d3f..38cb760c2 100755
>>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>>> @@ -252,8 +252,10 @@ test5()
>>>  		return
>>>  	fi
>>>  
>>> -	local subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
>>> -	local subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
>>> +	local subsys1=`head -2 /proc/cgroups | tail -n 1 | awk '{ print $1 }'`
>>> +	local subsys1_hierarchy=`head -2 /proc/cgroups | tail -n 1 | awk '{ print $2 }'`
>>> +	local subsys2=`head -3 /proc/cgroups | tail -n 1 | awk '{ print $1 }'`
>>> +	local subsys2_hierarchy=`head -3 /proc/cgroups | tail -n 1 | awk '{ print $2 }'`
>>>  
>>>  	# Accounting here for the fact that the chosen subsystems could
>>>  	# have been already previously mounted at boot time: in such a
>>> @@ -267,10 +269,16 @@ test5()
>>>  	if [ -z "$mounted" ]; then
>>>  		mntpoint=cgroup
>>>  		failing=$subsys1
>>> -		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/
>>> +		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/ 2>/dev/null
>>> +		# Even subsystem has not been mounted, it still live in kernel.
>>> +		# So we will get EBUSY when both mount subsys1 and subsys2 if
>>> +		# hierarchy isn't equal to 0.
>>>  		if [ $? -ne 0 ]; then
>>> -			tst_res TFAIL "mount $subsys1 and $subsys2 failed"
>>> -			return
>>> +			if [ "$subsys1_hierarchy" = 0 -a "$subsys2_hierarchy" = 0 ]; then
>>> +				tst_res TFAIL "mount $subsys1 and $subsys2 failed"
>>> +				return
>>> +			fi
>>> +			failing=$subsys1,$subsys2
>>>  		fi
>>>  	else
>>>  		# Use the pre-esistent mountpoint as $mntpoint and use a



