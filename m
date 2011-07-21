Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QjwWz-0000CM-NT
	for ltp-list@lists.sourceforge.net; Thu, 21 Jul 2011 16:55:25 +0000
Date: Thu, 21 Jul 2011 18:57:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110721165737.GB7179@saboteur.suse.cz>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
	<1309414787-2022-3-git-send-email-yanpai.chen@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309414787-2022-3-git-send-email-yanpai.chen@gmail.com>
Subject: Re: [LTP] [PATCH 3/7] testcases: controllers: fix wrong cpu number
 calculated
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
To: Andrew Chen <yanpai.chen@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ypchen@faraday-tech.com

Hi!
> From: Andrew Chen <ypchen@faraday-tech.com>
> 
> Only "Processor" will be showed up in /proc/cpuinfo for ARM non-SMP CPUs.
> Ignore case to fix this issue.
> 
> Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
> ---
>  .../kernel/controllers/cpuacct/run_cpuacct_test.sh |    2 +-
>  .../controllers/cpuctl/run_cpuctl_latency_test.sh  |    4 ++--
>  .../controllers/cpuctl/run_cpuctl_stress_test.sh   |    2 +-
>  .../kernel/controllers/cpuctl/run_cpuctl_test.sh   |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
> index 38b2ab6..332a5ae 100755
> --- a/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
> +++ b/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
> @@ -68,7 +68,7 @@ cleanup
>  
>  mes="CPU Accounting Controller"
>  cg_path="/dev/cpuacct";
> -num_online_cpus=`cat /proc/cpuinfo | grep -w processor | wc -l`
> +num_online_cpus=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
>  
>  #Function to create tasks equal to num_online_cpus.
>  nr_tasks ()
> diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
> index 51d6df0..d75d356 100755
> --- a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
> +++ b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
> @@ -99,7 +99,7 @@ calc_allowed_latency()
>  		sys_latency=`cat /proc/sys/kernel/sched_wakeup_granularity_ns`
>  		allowed_latency=`expr $sys_latency / 1000` # in microseconds
>  	else
> -		num_cpus=`cat /proc/cpuinfo | grep -w processor | wc -l`
> +		num_cpus=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
>  		log2 $num_cpus;
>  		ln_num_cpus=$?
>  		ln_num_cpus=`expr $ln_num_cpus + 1`
> @@ -170,7 +170,7 @@ PWD=`pwd`
>  	"2")	# With group scheduling
>  		echo TINFO "Running cpuctl Latency Test 2"
>  
> -		NUM_CPUS=`cat /proc/cpuinfo | grep -w processor | wc -l`;
> +		NUM_CPUS=`cat /proc/cpuinfo | grep -w -i processor | wc -l`;
>  		get_num_groups;	# NUM_GROUPS is set now
>  		do_setup;

Same for this one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
