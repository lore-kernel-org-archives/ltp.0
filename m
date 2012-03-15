Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S8Bi8-0007tQ-TK
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 14:31:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S8Bi4-0003lC-LK
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 14:31:24 +0000
Message-ID: <4F61FCF8.1040304@cn.fujitsu.com>
Date: Thu, 15 Mar 2012 22:30:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331820621-10095-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<80145D4278C2654ABC4879063FB2FFA9530ACB12@G4W3231.americas.hpqcorp.net>
In-Reply-To: <80145D4278C2654ABC4879063FB2FFA9530ACB12@G4W3231.americas.hpqcorp.net>
Subject: Re: [LTP] [PATCH] MAINTAINERS: update the maintain-ship of LTP
Reply-To: gaowanlong@cn.fujitsu.com
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
To: "Rajak, Rishikesh Kumar (FEL/PQSi)" <rishikesh.rajak@hp.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vapier@gentoo.org" <vapier@gentoo.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "risrajak@linux.vnet.ibm.com" <risrajak@linux.vnet.ibm.com>

On 03/15/2012 10:19 PM, Rajak, Rishikesh Kumar (FEL/PQSi) wrote:

> Hi Wanlong,
> 
> Review-By: Rishikesh K Rajak <rishikesh.rajak@hp.com>
> 
> No issue with me. But still I am closely watching this place though my responsibilities have changed.


Thank you for your previous great work, Rishikesh.

Regards,
Wanlong Gao

> 
> Regards
> Rishi
> 
> -----Original Message-----
> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com]
> Sent: Thursday, March 15, 2012 7:40 PM
> To: akpm@linux-foundation.org
> Cc: ltp-list@lists.sourceforge.net; vapier@gentoo.org; linux-kernel@vger.kernel.org; risrajak@linux.vnet.ibm.com
> Subject: [LTP] [PATCH] MAINTAINERS: update the maintain-ship of LTP
> 
> The maintain-ship of LTP is out of date, so update it.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  MAINTAINERS |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 95e4e43..3e10e6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4173,12 +4173,14 @@ F:      Documentation/hwmon/ltc4261
>  F:     drivers/hwmon/ltc4261.c
> 
>  LTP (Linux Test Project)
> -M:     Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
> -M:     Garrett Cooper <yanegomi@gmail.com>
> +M:     Shubham Goyal <shubham@linux.vnet.ibm.com>
>  M:     Mike Frysinger <vapier@gentoo.org>
> -M:     Subrata Modak <subrata@linux.vnet.ibm.com>
> +M:     Cyril Hrubis <chrubis@suse.cz>
> +M:     Caspar Zhang <caspar@casparzhang.com>
> +M:     Wanlong Gao <gaowanlong@cn.fujitsu.com>
>  L:     ltp-list@lists.sourceforge.net (subscribers-only)
>  W:     http://ltp.sourceforge.net/
> +T:     git git://github.com/linux-test-project/ltp.git
>  T:     git git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev
>  S:     Maintained
> 
> --
> 1.7.10.rc1
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
