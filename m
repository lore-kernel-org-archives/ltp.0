Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U30oe-0001gz-AI
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 08:57:16 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U30od-0006wm-4a
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 08:57:16 +0000
Date: Wed, 6 Feb 2013 03:57:06 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1617294472.837757.1360141026616.JavaMail.root@redhat.com>
In-Reply-To: <511218D1.7090102@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] setns: add new syscall test setns01
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net
> Sent: Wednesday, 6 February, 2013 9:48:17 AM
> Subject: Re: [LTP] [PATCH 2/3] setns: add new syscall test setns01
> 
> 
> So, how about adding fd and ns_type setting in setup4:
> 
> +	int i;
> +	for (i = 0; i < NS_TOTAL; i++)
> +		if (ns_fds[i] != -1) {
> +			t->fd = ns_fds[i];
> +			t->ns_type = ns_types[i];
> +			return;
> +		}
> +	t->skip = 1;
> 
> 
> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> Thanks,
> Wanlong Gao

Thanks for having a look. I was thinking the same, I'm just building
latest kernel tree to double check it. I'll send v2 afterwards.

Regards,
Jan

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
