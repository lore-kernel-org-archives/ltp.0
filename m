Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME61V-0001VH-Ll
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:13 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME61T-0001gs-UJ
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:13 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59ILJ0n019081
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:21:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IQAe9138890
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:26:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59INuNK030267
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:23:56 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081333.42673.jpalecek@web.de>
References: <200906081333.42673.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:20 +0530
Message-Id: <1244571921.5497.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Return immediately when the ZOO file couldn't
	be	opened, prevent crash later
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

On Mon, 2009-06-08 at 13:33 +0200, Jiri Palecek wrote: 
> Hello,
> 
> there was a crash in pan when the zoofile couldn't be opened; this patch fixes it by disallowing the zoo_open function to continue.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> 
> ---
>  pan/zoolib.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/pan/zoolib.c b/pan/zoolib.c
> index 3e31733..72ddfb0 100644
> --- a/pan/zoolib.c
> +++ b/pan/zoolib.c
> @@ -104,6 +104,7 @@ zoo_open(char *zooname)
>  		snprintf(zoo_error, ZELEN, 
>  				"Could not open zoo as \"%s\", errno:%d %s", 
>  				zooname, errno, strerror(errno));
> +		return 0;
>  	    }
>  	    fclose(new_zoo);
>  	    new_zoo = fopen(zooname, "r+");


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
