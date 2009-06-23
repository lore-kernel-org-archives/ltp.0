Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Wt-0005ZR-06
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:03:23 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Wr-0004rN-UM
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:03:22 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEwjBQ022368
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:58:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF3L2d253592
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:03:21 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF3LCu022432
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:03:21 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220301.n5M31cfk025228@e6.ny.us.ibm.com>
References: <200906220301.n5M31cfk025228@e6.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:37 +0530
Message-Id: <1245768577.4860.73.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Don't overwrite the exit code with junk value
	in	acl_test01
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

On Wed, 2009-06-10 at 13:13 +0200, Jiri Palecek > wrote: 
> Hello,
> 
> the variable EXIT_CODE which contains the result of acl01 test, is overwritten at the end of the test. This patch makes it preserve the correct value.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/acls/acl_test01 |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
> index 376a46c..01d068f 100755
> --- a/testcases/kernel/fs/acls/acl_test01
> +++ b/testcases/kernel/fs/acls/acl_test01
> @@ -155,8 +155,6 @@ else
>     		export TCbin=$PWD
>  	fi
>  	
> -	EXIT_CODE=$?
> -	
>  	do_cleanup
>  fi	
> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
