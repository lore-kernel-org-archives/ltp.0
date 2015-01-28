Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YGNuv-00028D-6l
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 08:24:05 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGNut-0004mq-6V
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 08:24:05 +0000
Message-ID: <54C89C83.7000002@cn.fujitsu.com>
Date: Wed, 28 Jan 2015 16:23:31 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
In-Reply-To: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
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
To: Li Jinyue <lijinyue@huawei.com>
Cc: ltp-list@lists.sourceforge.net, dingguofu@huawei.com, zhanyongming@huawei.com

On 01/19/2015 04:36 PM, Li Jinyue wrote:
> For kernel commit c4c27fbdda4e8ba87806c415b6d15266b07bce4b,
> disallow attaching kthreadd or PF_THREAD_BOUND threads to cgroups.
> 
> So, we kindly avoid to attach these threads in cgroup tests.
> 
> Signed-off-by: Li Jinyue <lijinyue@huawei.com>
> ---
>  testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index 30476bd..30fffb6 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -186,6 +186,16 @@ case $attach_operation in
>  	do
>  		cur_pid=`sed -n "$i""p" $TMPFILE`
>  		if [ -e /proc/$cur_pid/ ];then
> +			#For kernel 3.4.0 and higher,kernel disallow attaching kthreadd or
> +			#PF_THREAD_BOUND threads to cgroups.

I check the current kernel and find that this flag already removed now, please check the following
commit:

commit 14a40ffccd6163bbcd1d6f32b28a88ffe6149fc6
Author: Tejun Heo <tj@kernel.org>
Date:   Tue Mar 19 13:45:20 2013 -0700

    sched: replace PF_THREAD_BOUND with PF_NO_SETAFFINITY
    
    PF_THREAD_BOUND was originally used to mark kernel threads which were
    bound to a specific CPU using kthread_bind() and a task with the flag
    set allows cpus_allowed modifications only to itself.  Workqueue is
    currently abusing it to prevent userland from meddling with
    cpus_allowed of workqueue workers.


> +			#kernel commit: c4c27fbdda4e8ba87806c415b6d15266b07bce4b
> +			tst_kvercmp 3 4 0
> +			if [ $? -ne 0 ]; then

And where to go if tst_kvercmp failed and return -1?

> +				thread_flag=`cat /proc/$cur_pid/stat | awk '{print $9}'`
> +				if [ $cur_pid -eq 2 -o $((${thread_flag}&0x04000000)) -eq 67108864 ];then

These magic numbers must at least be commented to be understand easily.

Thanks,
Wanlong Gao

> +					continue
> +				fi
> +			fi
>  			do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks
>  		fi
>  	done
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
