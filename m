Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P0Ebq-00039m-QM
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 14:23:14 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0Ebn-0000TQ-R5
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 14:23:12 +0000
Date: Mon, 27 Sep 2010 09:23:04 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20100927142304.GA23119@hallyn.com>
References: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
Subject: Re: [LTP] [PATCH] Compilation Error Fixed in filecaps.
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
To: Sravan V Dodla <sravan@linux.vnet.ibm.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

Quoting Sravan V Dodla (sravan@linux.vnet.ibm.com):
> Hello,
> 
> I have been facing an compilation issue with the latest version of LTP. After some debugging I found out that the

I don't see that code in current ltp head.  It checks HAVE_LIBCAP.
What code are you looking at?

> flag HAVE_SYS_CAPABILITY_H is not used and sys/capability.h is being included.
> So here is the patch to get rid of this error.
> 
> Signed-off-by: Sravan V Dodla <sravan@linux.vnet.ibm.com>.
> 
> --- c.c	2010-09-23 06:09:27.257635313 +0530
> +++ c.c.orig	2010-09-23 06:08:54.643698431 +0530
> @@ -20,9 +20,7 @@
>  
>  
>  #include <stdio.h>
> -#if HAVE_SYS_CAPABILITY_H
>  #include <sys/capability.h>
> -#endif
>  
>  int main()
>  {
> 
> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
