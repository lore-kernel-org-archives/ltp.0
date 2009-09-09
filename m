Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MlH0c-0000bJ-Tu
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:26 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlH0V-00054P-EP
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 06:50:26 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n896jhA5017801
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:45:43 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n896oDAK123494
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:50:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n896oD3M010028
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 00:50:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA5B1F3.7020403@redhat.com>
References: <4AA4EC94.6020209@redhat.com>
	<1252323511.4922.22.camel@subratamodak.linux.ibm.com>
	<4AA5B1F3.7020403@redhat.com>
Date: Wed, 09 Sep 2009 12:19:56 +0530
Message-Id: <1252478998.5006.11.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] network: Fix ip_tests error 2
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
To: Hushan Jia <hjia@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-09-08 at 09:22 +0800, Hushan Jia wrote: 
> Hi Subrata,
> I have remade the patch based on the first ip_tests.sh patch, changes:
> 
> 1. Test #4:
> ip tools now print nud state as follows:
> REACHABLE, STALE, FAILED, etc.
> 
> 2. Test #3, #4, #5:
> If delete entry succefully, grep will return 1,
> indicating test PASS, so return code RC should be set to 0.
> 
> Thanks&  Regards,
> Hushan
> 
> ---
> network: Fix iproute test case error 2
> 
> Signed-off-by: Hushan Jia<hjia@redhat.com>

Sorry, this fail to apply too:

patching file testcases/network/iproute/ip_tests.sh
Hunk #1 FAILED at 310.
Hunk #2 FAILED at 356.
Hunk #3 FAILED at 386.
Hunk #4 FAILED at 486.
Hunk #5 FAILED at 576.
5 out of 5 hunks FAILED -- saving rejects to file
testcases/network/iproute/ip_tests.sh.rej

Regards--
Subrata

> 
> --- ltp-full-20090831/testcases/network/iproute/ip_tests.sh.orig	2009-09-08 09:04:54.000000000 +0800
> +++ ltp-full-20090831/testcases/network/iproute/ip_tests.sh	2009-09-08 09:11:21.000000000 +0800
> @@ -310,7 +310,9 @@ test03()
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #3: ip addr del command failed. Reason: "
>   				return $(($RC+1))
> -		fi
> +			else
> +				RC=0
> +			fi
>   		
>   		tst_resm TPASS \
>   			"Test #3: ip addr command tests successful"
> @@ -354,7 +356,7 @@ test04()
>   		 "Test #4: ip neigh show - shows all neighbour entries in arp tables."
> 
>   		cat>  $LTPTMP/tst_ip.exp<<-EOF
> -		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 nud reachable
> +		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
>   		EOF
> 
>   		ip neigh show 127.0.0.1 | head -n1>$LTPTMP/tst_ip.out 2>&1 || RC=$?
> @@ -384,12 +386,14 @@ test04()
>   				"Test #4: ip neigh del command failed return = $RC. Reason: "
>   			return $RC
>   		else
> -			ip neigh show | grep 127.0.0.1 grep -v "nud failed$">$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$">$LTPTMP/tst_ip.err 2>&1 || RC=$?
>   			if [ $RC -eq 0 ]
>   			then
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #4: 127.0.0.1 still listed in arp. ip cmd Error Message:"
>   				return $(($RC+1))
> +			else
> +				RC=0
>   			fi
>   		fi
>   		
> @@ -482,6 +486,8 @@ test05()
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #5: route not deleted. ip route show:"
>   				return $(($RC+1))
> +			else
> +				RC=0
>   			fi
>   		fi
>   		
> @@ -570,6 +576,8 @@ test06()
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #6: 66:66:00:00:00:66 is not deleted. Details:"
>   				return $(($RC+1))
> +			else
> +				RC=0
>   			fi
>   		fi
>   		
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
