Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY8d-0007Vo-PH
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:52:23 +0000
Received: from [32.97.110.149] (helo=e31.co.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY8c-0005CZ-KF
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:52:23 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A4998D3.1070105@linux.vnet.ibm.com>
References: <4A4998D3.1070105@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 13:11:35 +0530
Message-Id: <1246347695.4819.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: use mlockall optionally in realtime
	tests
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
Cc: ltp-list@lists.sf.net, Vernon Mauery <vernux@us.ibm.com>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Tue, 2009-06-30 at 10:17 +0530, gowrishankar wrote: 
> Hi Subrata,
> Please accept the patch below.
> 
> Thanks,
> Gowri
> ---
> 
> realtime: use mlockall optionally in realtime tests
> 
> Below patch adds the support to enable memory lock in realtime testcases
> optionally (with -m).
> 
> Testing Informations:
>    Tested the realtime tests in their default profile and as well
>    as using mlock option.
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks.

Regards--
Subrata

> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> Acked-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
> Acked-by: Dinakar Guniguntala <dino@in.ibm.com>
> Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
> Acked-by: Darren Hart <dvhltc@us.ibm.com>
> ---


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
