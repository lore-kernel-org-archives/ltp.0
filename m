Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwGn-0001HU-4h
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:18:09 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwGi-0005WU-2S
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:18:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFDei0012893
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:13:40 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHeT4181982
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHe7q008747
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:40 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151729460.29769@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151729460.29769@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:28 +0530
Message-Id: <1253114248.6343.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] smt_smp: Return TCONF if SMT/SMP is not supported
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
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Tue, 2009-09-15 at 17:30 +0200, Geert Uytterhoeven wrote: 
> Currently the tests just fails if SMT/SMP is not supported.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  .../hyperthreading/ht_affinity/smt_smp_affinity.sh |    3 +--
>  .../hyperthreading/ht_enabled/smt_smp_enabled.sh   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> index 109800d..0a33f51 100755
> --- a/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> +++ b/testcases/kernel/sched/hyperthreading/ht_affinity/smt_smp_affinity.sh
> @@ -44,8 +44,7 @@ if [ -f ./ht_enabled ];then
>  	if [ $ret_value -ne 0 ];then
>  		tst_resm TCONF "SMT/SMP is not supported"
>  		tst_resm TINFO "End: SMT/SMP Affinity"
> -		TFAILCNT=$(( $TFAILCNT+1 ))
> -		exit $TFAILCNT
> +		exit 0
>  	fi
>  else
>  	tst_resm TBROK "ht_enabled:File not found"
> diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> index 8b8a909..e234ea4 100755
> --- a/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> +++ b/testcases/kernel/sched/hyperthreading/ht_enabled/smt_smp_enabled.sh
> @@ -41,8 +41,7 @@ if [ -f ./ht_enabled ];then
>  	if [ $ret_value -ne 0 ];then
>  		tst_resm TCONF "SMT/SMP is not supported"
>  		tst_resm TINFO "End: SMT/SMP Enabled"
> -		TFAILCNT=$(( $TFAILCNT+1 ))
> -		exit $TFAILCNT
> +		exit 0
>  	fi
>  else
>  	tst_resm TBROK "ht_enabled:File not found"


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
