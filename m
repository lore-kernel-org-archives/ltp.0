Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdkFy-00063C-Vf
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 15:08:30 +0000
Date: Thu, 22 Dec 2011 16:18:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222151810.GA1494@saboteur.suse.cz>
References: <4EEB065C.4060805@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EEB065C.4060805@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong of test_proc_kill
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> test_proc_kill() tests process will be killed due to exceed memory limit, but
> when memcg_process exit due to mmap/munmap fails, the case still pass.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  .../memcg/functional/memcg_function_test.sh        |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> index 1f07cb5..6cfe9a5 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
> @@ -175,13 +175,23 @@ test_failcnt()
>  test_proc_kill()
>  {
>  	echo $1 > memory.limit_in_bytes
> -	$TEST_PATH/memcg_process $2 -s $3 &
> +	($TEST_PATH/memcg_process $2 -s $3 2>/tmp/errlog) &
>  	pid=$!
>  	sleep 1
>  	echo $pid > tasks
>  
>  	/bin/kill -s SIGUSR1 $pid 2> /dev/null
>  	sleep 1
> +
> +	if [ -s /tmp/errlog ]; then
> +		err_msg=`cat /tmp/errlog`
> +		rm -f /tmp/errlog
> +		result $FAIL "$err_msg"
> +		return
> +	fi
> +
> +	rm -f /tmp/errlog
> +

Looking into the memcg_process.c it returns return value 1 on failure,
catching it correctly is better option here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
