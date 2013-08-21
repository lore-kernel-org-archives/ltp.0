Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VC2FL-0006EX-RV
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 06:50:23 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VC2FK-0001Uw-DQ
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 06:50:23 +0000
Date: Wed, 21 Aug 2013 02:50:15 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <930235670.1613017.1377067815751.JavaMail.root@redhat.com>
In-Reply-To: <5213D2DF.20802@oracle.com>
References: <5213D2DF.20802@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ltp: handle missing online file
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





----- Original Message -----
> From: "Dave Kleikamp" <dave.kleikamp@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 20 August, 2013 10:34:39 PM
> Subject: [LTP] [PATCH] ltp: handle missing online file
> 
> gather_node_cpus() fails if the /sys/devices/system/node/nodeX/cpuX/online
> file is missing for any cpu other than cpu0. The absence of the online file
> should not be treated as a failure, but as an indication that the cpu is
> not hot-pluggable and cannot be taken offline.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Looks good to me. One comment inline.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 9bc926e..99243a6 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -786,16 +786,14 @@ static void gather_node_cpus(char *cpus, long nd)
>  		if (path_exist(path, nd, i)) {
                                     ^^  ^^
                                     |---|--> Are these parameters used for anything?
                                              Line above already does snprintf.

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
