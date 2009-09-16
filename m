Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mnwld-0003C4-DX
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:50:01 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwlZ-0000iP-2v
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:50:00 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFDMpR004166
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:13:22 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHiB8094538
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFHhwu006109
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 09:17:43 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0909151730060.29837@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909151730060.29837@vixen.sonytel.be>
Date: Wed, 16 Sep 2009 20:47:31 +0530
Message-Id: <1253114251.6343.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Filecaps: Return TCONF if file capabilities
	are	not supported
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
> Currently the test just fails if file capabilities are not supported.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/security/filecaps/filecapstest.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
> index 89a4ea7..c95291a 100755
> --- a/testcases/kernel/security/filecaps/filecapstest.sh
> +++ b/testcases/kernel/security/filecaps/filecapstest.sh
> @@ -30,7 +30,8 @@ fi
>  checkforfilecaps.sh
>  ret=$?
>  if [ $ret -ne 0 ]; then
> -	exit 1
> +	echo "Filecaps 0 CONF : File capabilities not available"
> +	exit 0
>  fi
>  
>  echo "Running in:"


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
