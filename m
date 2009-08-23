Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7Vt-0008Iy-Ef
	for Ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:17 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Vk-0001oi-PU
	for Ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:17 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7R4as030010
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:27:04 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7T3FA165162
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7T2P2010039
	for <Ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:03 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Date: Sun, 23 Aug 2009 12:58:50 +0530
Message-Id: <1251012531.16822.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] cron tests: autodetect crond vs. cron
Reply-To: subrata@linux.vnet.ibm.com
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Ltp-list@lists.sourceforge.net

On Thu, 2009-08-20 at 17:25 +0200, Geert Uytterhoeven wrote: 
> The cron tests check for Red Hat to decide whether to use /etc/init.d/crond
> or /etc/init.d/cron. This fails on other distros that use crond, e.g. on
> Yellow Dog Linux.
> 
> Replace the distro test by an actual file existence test, as is done in
> testcases/kdump/runkdump.sh.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/commands/cron/cron02 |   17 ++++++-----------
>  testcases/commands/cron/cron03 |   17 ++++++-----------
>  2 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/testcases/commands/cron/cron02 b/testcases/commands/cron/cron02
> index 6e4d8fe..b2656e3 100755
> --- a/testcases/commands/cron/cron02
> +++ b/testcases/commands/cron/cron02
> @@ -53,17 +53,12 @@ do_setup(){
>          fi
> 
>  	# restart cron daemon
> -# Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
> -tvar=${MACHTYPE%-*}
> -tvar=${tvar#*-}
> -printf "Distro type is: $tvar\n\n"
> -
> -if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
> -
> -	/etc/init.d/cron restart
> -else
> -	/etc/init.d/crond restart
> -fi
> +	# Red Hat uses crond, SuSE/Other uses cron.
> +	if [ -f /etc/init.d/crond ]; then
> +		/etc/init.d/crond restart
> +	else
> +		/etc/init.d/cron restart
> +	fi
>  }
> 
>  #-----------------------------------------------------------------------
> diff --git a/testcases/commands/cron/cron03 b/testcases/commands/cron/cron03
> index 9448cc4..2cb157a 100755
> --- a/testcases/commands/cron/cron03
> +++ b/testcases/commands/cron/cron03
> @@ -56,17 +56,12 @@ do_setup(){
>          }
>          fi
>          # restart cron daemon
> -# Red Hat uses crond, SuSE/Other uses cron. Check if this is Red Hat/SuSE/Other
> -tvar=${MACHTYPE%-*}
> -tvar=${tvar#*-}
> -printf "Distro type is: $tvar\n\n"
> -
> -if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]; then
> -
> -	/etc/init.d/cron restart
> -else
> -	/etc/init.d/crond restart
> -fi
> +	# Red Hat uses crond, SuSE/Other uses cron.
> +	if [ -f /etc/init.d/crond ]; then
> +		/etc/init.d/crond restart
> +	else
> +		/etc/init.d/cron restart
> +	fi
>  }
> 
>  #-----------------------------------------------------------------------


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
