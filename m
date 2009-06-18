Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTm-0007it-Hy
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:50 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTl-0000Jm-Ab
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:50 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHUjK1017763
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:30:45 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHWm3n221138
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHWlGJ029991
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:32:48 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245327683-8493-1-git-send-email-nobuhiro@andestech.com>
References: <1245327683-8493-1-git-send-email-nobuhiro@andestech.com>
Date: Thu, 18 Jun 2009 23:01:59 +0530
Message-Id: <1245346319.5041.44.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] growfiles: fix static build which needs to
	link	the pthread library
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
To: nobuhiro <nobuhiro@andestech.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, 2009-06-18 at 20:21 +0800, nobuhiro wrote: 
> Signed-off-by: nobuhiro <nobuhiro@andestech.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/doio/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/fs/doio/Makefile b/testcases/kernel/fs/doio/Makefile
> index 4e0cd24..6e8f2de 100644
> --- a/testcases/kernel/fs/doio/Makefile
> +++ b/testcases/kernel/fs/doio/Makefile
> @@ -1,6 +1,6 @@
> 
>  CFLAGS+= -Wall -I../../../../include -D_LARGEFILE64_SOURCE
> -LDLIBS+= -L../../../../lib -lltp -lrt
> +LDLIBS+= -L../../../../lib -lltp -lrt -lpthread
> 
>  TARGETS=doio growfiles rwtest iogen
>  SRCS=$(wildcard *.c)


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
