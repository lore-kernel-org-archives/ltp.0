Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SMsaS-0001Ds-0O
	for ltp-list@lists.sourceforge.net; Wed, 25 Apr 2012 03:08:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SMsaQ-0002Jg-7S
	for ltp-list@lists.sourceforge.net; Wed, 25 Apr 2012 03:08:11 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q3P37sLp002729
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Apr 2012 11:08:02 +0800
Message-ID: <4F976A4E.6070006@cn.fujitsu.com>
Date: Wed, 25 Apr 2012 11:06:54 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1335253407-17318-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1335253407-17318-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] memcg_move_charge_at_immigrate_test: fix a bug of
 usage_in_bytes is not 'exact'
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/24/2012 03:43 PM, Peng Haitao wrote:

> In memory.txt says:
>  usage_in_bytes is affected by the method and doesn't show 'exact' value of memory(and swap) usage, it's an fuzz value for efficient access. (Of course, when necessary, it's synchronized.) If you want to know more exact memory usage, you should use RSS+CACHE(+SWAP) value in memory.stat(see 5.2).
> 
> So memory.usage_in_bytes should be replaced with memory.stat in the case of
> memcg_move_charge_at_immigrate_test.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>


pushed, thanks Peng,

Wanlong Gao

> ---
>  testcases/kernel/controllers/memcg/functional/memcg_lib.sh     |    6 ++++--
>  .../memcg/functional/memcg_move_charge_at_immigrate_test.sh    |    8 ++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 470932d..fd2c7fd 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -380,9 +380,11 @@ test_move_charge()
>  	echo $! > subgroup_b/tasks
>  
>  	cd subgroup_b
> -	check_mem_stat memory.usage_in_bytes $4
> +	check_mem_stat "rss" $4
> +	check_mem_stat "cache" $5
>  	cd ../subgroup_a
> -	check_mem_stat memory.usage_in_bytes $5
> +	check_mem_stat "rss" $6
> +	check_mem_stat "cache" $7
>  
>  	cd ..
>  	echo $! > tasks
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> index fb639c7..cf2c603 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
> @@ -35,27 +35,27 @@ export TST_COUNT=0
>  # Test disable moving charges
>  testcase_1()
>  {
> -	test_move_charge "--mmap-anon" $PAGESIZE  0 0 $PAGESIZE
> +	test_move_charge "--mmap-anon" $PAGESIZE  0 0 0 $PAGESIZE 0
>  }
>  
>  # Test move anon
>  testcase_2()
>  {
>  	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE 1 \
> -		$PAGESIZE $((PAGESIZE*2))
> +		$PAGESIZE 0 0 $((PAGESIZE*2))
>  }
>  
>  # Test move file
>  testcase_3()
>  {
>  	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE 2 \
> -		$((PAGESIZE*2)) $PAGESIZE
> +		0 $((PAGESIZE*2)) $PAGESIZE 0
>  }
>  
>  # Test move anon and file
>  testcase_4()
>  {
> -	test_move_charge "--mmap-anon --shm" $PAGESIZE 3 $((PAGESIZE*2)) 0
> +	test_move_charge "--mmap-anon --shm" $PAGESIZE 3 $PAGESIZE $PAGESIZE 0 0
>  }
>  
>  # Run all the test cases



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
