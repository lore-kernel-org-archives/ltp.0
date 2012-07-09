Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SoAw3-0005BK-Np
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:11:19 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoAvy-00024U-2V
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:11:19 +0000
Date: Mon, 09 Jul 2012 06:11:07 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <9eab5d31-5e42-42d9-9895-1c3a66ce5453@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1341827513-21908-2-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Monday, July 9, 2012 5:51:53 PM
> Subject: [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
> 
> 
> for some systems under pressure, we've observed that sleeping 5
> seconds
> is not sufficient for completing ksm scanning, to fix this, we should
> give ksmd more time to scan the mergable pages by increasing sleeping
> time to 10s.

I agreed your fixing.

Reviewed-by: Zhouping Liu <zliu@redhat.com>

> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/lib/mem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
