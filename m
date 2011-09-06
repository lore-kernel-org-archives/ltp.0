Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1R0rvC-0001Rd-V0
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 09:26:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R0rvC-0004Og-40
	for ltp-list@lists.sourceforge.net; Tue, 06 Sep 2011 09:26:22 +0000
Message-ID: <4E65E6B4.2030209@redhat.com>
Date: Tue, 06 Sep 2011 17:24:04 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4E64A194.2070805@linux.vnet.ibm.com>
In-Reply-To: <4E64A194.2070805@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch 1/4] KSM test case fixes - ksm01
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
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 09/05/2011 06:16 PM, Nageswara R Sastry wrote:
> +
> +	char *fname = "/sys/kernel/mm/ksm/";
> +
> +        if( access( fname, F_OK ) == -1 ) {
> +                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> +        }
>   }

Hi, thanks for the patch. However, there is already a macro defined in 
include/mem.h:

#define PATH_KSM                "/sys/kernel/mm/ksm/"

And I think the braces are not necessary here?

Thanks,
Caspar

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
