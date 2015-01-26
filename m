Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFlVl-0002xs-73
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 15:23:33 +0000
Date: Mon, 26 Jan 2015 16:22:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126152234.GA27890@rei.suse.de>
References: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421656612-15165-1-git-send-email-lijinyue@huawei.com>
Subject: Re: [LTP] [PATCH] controllers: disallow attaching kthreadd or
 PF_THREAD_BOUND threads to cgroups on kernel > 3.4.0
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

Hi!
> For kernel commit c4c27fbdda4e8ba87806c415b6d15266b07bce4b,
> disallow attaching kthreadd or PF_THREAD_BOUND threads to cgroups.
> 
> So, we kindly avoid to attach these threads in cgroup tests.

What happens when we try that out? Can you include the error message (if
any)?

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
> +			#kernel commit: c4c27fbdda4e8ba87806c415b6d15266b07bce4b
> +			tst_kvercmp 3 4 0
> +			if [ $? -ne 0 ]; then
> +				thread_flag=`cat /proc/$cur_pid/stat | awk '{print $9}'`

Why not just thread_flag=$(awk '{print $9}'/proc/$cur_pid/stat) ?

> +				if [ $cur_pid -eq 2 -o $((${thread_flag}&0x04000000)) -eq 67108864 ];then

So you are relying on fact that kthreadadd pid is 2. Is that specified
somewhere? I doubt that this will hold forever.

Also the magical constant 67108864 is very cryptic, what about using
-ne 0 instead -eq 67108864?

-- 
Cyril Hrubis
chrubis@suse.cz

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
