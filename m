Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Sf-0004te-AQ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:59:01 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7SY-0007IK-8F
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:58:55 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEsfYZ003094
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:54:41 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NEwbAR098730
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:58:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NEwav0021938
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:58:36 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220106.n5M16dD9008479@e4.ny.us.ibm.com>
References: <200906220106.n5M16dD9008479@e4.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:18:59 +0530
Message-Id: <1245768539.4860.63.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Report error with the correct error file
	in	tar_tests.sh
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-05-05 at 00:25 +0200, Jiri Palecek > wrote: 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/commands/tar/tar_tests.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
> index a3a197f..6858161 100755
> --- a/testcases/commands/tar/tar_tests.sh
> +++ b/testcases/commands/tar/tar_tests.sh
> @@ -258,7 +258,7 @@ else
>  		TFAILCNT=$(( $TFAILCNT+1 ))
>  	    fi
>  	else
> -	    $LTPBIN/tst_brk TBROK $LTPTMP/file.out NULL \
> +	    $LTPBIN/tst_brk TBROK $LTPTMP/tar_tst.out NULL \
>  		"tar: command failed while creating compressed archive. Reason:"
>  	    TFAILCNT=$(( $TFAILCNT+1 ))
>  	fi


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
