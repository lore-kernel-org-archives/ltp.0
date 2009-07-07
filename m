Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCeo-0001oT-T4
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:34 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCej-0000py-1T
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:34 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A52E085.5070706@linux.vnet.ibm.com>
References: <4A52E085.5070706@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2009 21:02:18 +0530
Message-Id: <1246980738.5539.46.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: fix parameter name clash in pi-test7
	due to	memlock option added
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

On Tue, 2009-07-07 at 11:13 +0530, gowrishankar wrote: 
> Hi Subrata,
> Please accept the patch below.
> 
> Apologies to resend it as I forgot to tag subject with [PATCH] previously :)
> 
> Thanks,
> Gowri
> ---
> realtime: fix parameter name clash in pi-test7 due to memlock option added
> 
> Below patch just renames the parameter name for number of mid priority threads
> in pi-test7 from -m to -x. Original one clashes with our common memlock option
> used across all RT tests.
> 
> Also, pi-test7 is already disabled in our default run profile, so this patch
> can silently update the test without any impact on any other test.
> 
> Testing Informations:
> Tested pi-test7 binary with the patch for the changes.
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks.

Regards--
Subrata

> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
> ---


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
