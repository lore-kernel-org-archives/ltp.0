Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1RzTfn-0002tr-1y
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 13:52:59 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RzTfi-0005rN-Rd
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 13:52:59 +0000
Date: Mon, 20 Feb 2012 08:52:47 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <2a06c812-84d8-40f7-ba3f-271da9fbb81a@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1329735301-17676-2-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] mm/ksm,oom: fix count_numa()
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
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Zhouping Liu" <zliu@redhat.com>, "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Monday, February 20, 2012 6:55:01 PM
> Subject: [PATCH 2/2] mm/ksm,oom: fix count_numa()
> 
> 
> This patch makes ksm on oom tests use the new count_numa() function.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/ksm/ksm02.c |    7 ++++---
>  testcases/kernel/mem/ksm/ksm04.c |    7 ++++---
>  testcases/kernel/mem/oom/oom02.c |    3 ++-
>  testcases/kernel/mem/oom/oom04.c |    5 +++--
>  4 files changed, 13 insertions(+), 9 deletions(-)
> 
> 
tested in my system, it's good.

thanks,
Zhouping

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
