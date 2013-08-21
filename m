Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VC1xt-0004Xv-Rp
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 06:32:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VC1xq-0002Kp-9n
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 06:32:21 +0000
Message-ID: <52145ECA.5060602@cn.fujitsu.com>
Date: Wed, 21 Aug 2013 14:31:38 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5213D2DF.20802@oracle.com>
In-Reply-To: <5213D2DF.20802@oracle.com>
Subject: Re: [LTP] [PATCH] ltp: handle missing online file
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
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: ltp-list@lists.sourceforge.net

On 08/21/2013 04:34 AM, Dave Kleikamp wrote:
> gather_node_cpus() fails if the /sys/devices/system/node/nodeX/cpuX/online
> file is missing for any cpu other than cpu0. The absence of the online file
> should not be treated as a failure, but as an indication that the cpu is
> not hot-pluggable and cannot be taken offline.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 9bc926e..99243a6 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -786,16 +786,14 @@ static void gather_node_cpus(char *cpus, long nd)
>  		if (path_exist(path, nd, i)) {
>  			snprintf(path1, BUFSIZ, "%s/online", path);
>  			/*
> -			 * No cpu0/online knob, as it can't support to
> -			 * on/offline cpu0, so if the 'nd' node contains
> -			 * cpu0, it should skip to check cpu0/online's value.
> +			 * if there is no online knob, then the cpu cannot
> +			 * be taken offline
>  			 */
> -			if (i == 0)
> -				goto next;
> -			SAFE_FILE_SCANF(cleanup, path1, "%ld", &online);
> -			if (online == 0)
> -				continue;
> -next:
> +			if (path_exist(path1)) {
> +				SAFE_FILE_SCANF(cleanup, path1, "%ld", &online);
> +				if (online == 0)
> +					continue;
> +			}
>  			sprintf(buf, "%d,", i);
>  			strcat(cpus, buf);
>  		}
> 
> ------------------------------------------------------------------------------
> Introducing Performance Central, a new site from SourceForge and 
> AppDynamics. Performance Central is your source for news, insights, 
> analysis and resources for efficient Application Performance Management. 
> Visit us today!
> http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
