Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YGObw-0008Gh-Hj
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 09:08:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGObt-00089n-KW
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 09:08:32 +0000
Message-ID: <54C8A6EC.3020006@cn.fujitsu.com>
Date: Wed, 28 Jan 2015 17:07:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
	<54C89C83.7000002@cn.fujitsu.com> <54C8A2A5.1070609@huawei.com>
In-Reply-To: <54C8A2A5.1070609@huawei.com>
Subject: Re: [LTP] [PATCH] controllers: disallow attaching kthreadd or
 PF_THREAD_BOUND threads to cgroups on kernel > 3.4.0
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Lijinyue <lijinyue@huawei.com>
Cc: ltp-list@lists.sourceforge.net, dingguofu@huawei.com, zhanyongming@huawei.com

On 01/28/2015 04:49 PM, Lijinyue wrote:
> On 2015/1/28 16:23, Wanlong Gao wrote:
>> On 01/19/2015 04:36 PM, Li Jinyue wrote:
>>> For kernel commit c4c27fbdda4e8ba87806c415b6d15266b07bce4b,
>>> disallow attaching kthreadd or PF_THREAD_BOUND threads to cgroups.
>>>
>>> So, we kindly avoid to attach these threads in cgroup tests.
>>>
>>> Signed-off-by: Li Jinyue <lijinyue@huawei.com>
>>> ---
>>>  testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
>>> index 30476bd..30fffb6 100755
>>> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
>>> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
>>> @@ -186,6 +186,16 @@ case $attach_operation in
>>>  	do
>>>  		cur_pid=`sed -n "$i""p" $TMPFILE`
>>>  		if [ -e /proc/$cur_pid/ ];then
>>> +			#For kernel 3.4.0 and higher,kernel disallow attaching kthreadd or
>>> +			#PF_THREAD_BOUND threads to cgroups.
>>
>> I check the current kernel and find that this flag already removed now, please check the following
>> commit:
>>
>> commit 14a40ffccd6163bbcd1d6f32b28a88ffe6149fc6
>> Author: Tejun Heo <tj@kernel.org>
>> Date:   Tue Mar 19 13:45:20 2013 -0700
>>
>>     sched: replace PF_THREAD_BOUND with PF_NO_SETAFFINITY
>>     
>>     PF_THREAD_BOUND was originally used to mark kernel threads which were
>>     bound to a specific CPU using kthread_bind() and a task with the flag
>>     set allows cpus_allowed modifications only to itself.  Workqueue is
>>     currently abusing it to prevent userland from meddling with
>>     cpus_allowed of workqueue workers.
>>
>>
> Yes,I had also checked this patch. Actually,the PF_THREAD_BOUND had been replaced with PF_NO_SETAFFINITY.
> However, Kernel still disallow attaching kthreadd or threads with flag 0x04000000 to cgroups.


I know, I mean you should comment this change at least, because future users may
ask, "what's PF_THREAD_BOUND ? I never see this flag".

And as I said, you should also comment that the 0x04000000 is just PF_THREAD_BOUND or PF_NO_SETAFFINITY,
because you used it in the following code but others don't know where this magic number come from.

Thanks,
Wanlong Gao


> -#define PF_THREAD_BOUND	0x04000000	/* Thread bound to specific cpu */
> +#define PF_NO_SETAFFINITY 0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
> 
> diff --git a/kernel/cgroup.c b/kernel/cgroup.c
> index a32f943..3852d92 100644
> --- a/kernel/cgroup.c
> +++ b/kernel/cgroup.c
>  <at>  <at>  -2224,11 +2224,11  <at>  <at>  retry_find_task:
>  		tsk = tsk->group_leader;
> 
>  	/*
> -	 * Workqueue threads may acquire PF_THREAD_BOUND and become
> +	 * Workqueue threads may acquire PF_NO_SETAFFINITY and become
>  	 * trapped in a cpuset, or RT worker may be born in a cgroup
>  	 * with no rt_runtime allocated.  Just say no.
>  	 */
> -	if (tsk == kthreadd_task || (tsk->flags & PF_THREAD_BOUND)) {
> +	if (tsk == kthreadd_task || (tsk->flags & PF_NO_SETAFFINITY)) {
>  		ret = -EINVAL;
>  		rcu_read_unlock();
>  		goto out_unlock_cgroup;
>>> +			#kernel commit: c4c27fbdda4e8ba87806c415b6d15266b07bce4b
>>> +			tst_kvercmp 3 4 0
>>> +			if [ $? -ne 0 ]; then
>>
>> And where to go if tst_kvercmp failed and return -1?
> For kernel <3.4, we just attach all tasks to the cgroup as before.
> "do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks"
> 
> I had test passed with the v2 patch on kernel 3.10.
> cgroup_test_fj    1  TPASS  :  case98(function	1 1 1 1 1 3 1 1 1)    PASS
> /tmp/ltp/ltp/testcases/bin/cgroup_fj_utility.sh: line 497: 31010 Killed                  $TESTROOT/cgroup_fj_proc
> /tmp/ltp/ltp/testcases/bin/cgroup_fj_utility.sh: line 497: 31012 Killed                  $TESTROOT/cgroup_fj_proc
> cgroup_test_fj    1  TPASS  :  case99(function	1 1 1 1 1 3 2 1 1)    PASS
> /tmp/ltp/ltp/testcases/bin/cgroup_fj_function.sh: line 273: 31511 Killed                  $TESTROOT/cgroup_fj_proc
> /tmp/ltp/ltp/testcases/bin/cgroup_fj_utility.sh: line 497: 31513 Killed                  $TESTROOT/cgroup_fj_proc
> cgroup_test_fj    1  TPASS  :  case100(function	1 1 1 1 1 3 4 1 1)    PASS
> /tmp/ltp/ltp/testcases/bin/cgroup_fj_utility.sh: line 497: 32010 Killed
> 
> Regards,
> Li Jinyue
>>
>>> +				thread_flag=`cat /proc/$cur_pid/stat | awk '{print $9}'`
>>> +				if [ $cur_pid -eq 2 -o $((${thread_flag}&0x04000000)) -eq 67108864 ];then
>>
>> These magic numbers must at least be commented to be understand easily.
>>
>> Thanks,
>> Wanlong Gao
>>
>>> +					continue
>>> +				fi
>>> +			fi
>>>  			do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks
>>>  		fi
>>>  	done
>>>
>>
>>
>> .
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
