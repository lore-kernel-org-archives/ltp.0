Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryIY-0001a2-0w
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:38 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryIP-00017Q-Jt
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:37 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RICKnr016435
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:12:20 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIGNpe258550
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIGN7h022583
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:23 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1254005162-27353-5-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
	<1254005162-27353-3-git-send-email-avagin@gmail.com>
	<1254005162-27353-4-git-send-email-avagin@gmail.com>
	<1254005162-27353-5-git-send-email-avagin@gmail.com>
Date: Sun, 27 Sep 2009 23:45:36 +0530
Message-Id: <1254075338.10457.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 5/5] fsstress: renew flist if clean up test
	directory
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
To: Andrew Vagin <avagin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, 2009-09-27 at 02:46 +0400, Andrew Vagin wrote: 
> flist contain all files created by fsstress. If test clean up direcory
> on each interations that it should reinitilize flist.
> 
> Signed-off-by: Andrew Vagin <avagin@gmail.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/fsstress/fsstress.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index cf7ba76..736bd53 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -491,6 +491,12 @@ int main(int argc, char **argv)
>  		{
>  			sprintf(cmd,"rm -rf %s/*",dirname);
>  			system(cmd);
> +			for (i = 0; i < FT_nft; i++) {
> +				flist[i].nslots = 0;
> +				flist[i].nfiles = 0;
> +				free(flist[i].fents);
> +				flist[i].fents = NULL;
> +			}
>  		}
>  		loopcntr++;
>  	}


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
