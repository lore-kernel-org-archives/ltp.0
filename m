Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VPAKD-00045G-KW
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 12:05:41 +0000
Date: Thu, 26 Sep 2013 14:06:01 +0200
From: chrubis@suse.cz
Message-ID: <20130926120601.GE14003@rei.suse.cz>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 6/7] cpuset_memory_spread_test: number of nodes
 and sleep timeout
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> For unification number of nodes is set based on environment.
> 
> I've not found a better way to guarantee dropping of caches than
> just increasing sleep timeout twice (to 20 seconds).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  .../cpuset_memory_spread_testset.sh                |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> index a357e22..4d7bbeb 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> @@ -32,8 +32,8 @@ export TST_COUNT=1
>  
>  exit_status=0
>  # must >= 3 for: 1-$((nr_mems-2))
> -nr_cpus=4
> -nr_mems=3
> +nr_cpus=$NR_CPUS
> +nr_mems=$N_NODES
>  
>  # In general, the cache hog will use more than 10000 kb slab space on the nodes
>  # on which it is running. The other nodes' slab space has littler change.(less
> @@ -231,7 +231,7 @@ general_memory_spread_test()
>  	fi
>  
>  	# wait for droping the cache
> -	sleep 10
> +	sleep 20

I've asked our kernel guys and the drop_caches is synchronous interface,
so at the time the cat returns the caches should be dropped. See
fs/drop_caches.c the sysctl handler just does the work, there is nothing
deffered to working threads.

What exactly goes wrong when this sleep is missing here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
