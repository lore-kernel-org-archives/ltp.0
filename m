Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1RzTKV-00020k-W2
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 13:30:59 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RzTKR-0001rM-P6
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 13:30:59 +0000
Date: Mon, 20 Feb 2012 08:30:48 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <86099ec9-9ecb-40ae-a00c-f97991edf4f0@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] mm/lib: change count_numa() behavior
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

hi, 
> 
> this patch fixes two problems.
> 
> 1) avoid using functions from numactl package, so compilation would
> pass
> w/ and w/o numactl development package installed.
> 
> 2) count_numa() functions now has a parameter, which stores the array
> of
> each nodes on the system. This is because some systems doesn't have
> continuous nodes or the node sequence does not start from zero, when
> we
> want to test specific node, we should make sure the node does exist.
> Thus, an array for node numbers is necessary. Follow-up patches will
> update count_numa() with new parameters accordingly.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/include/mem.h |    2 +-
>  testcases/kernel/mem/lib/mem.c     |   12 +++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 

It's good for me.

Acked-by: Zhouping Liu <zliu@redhat.com>

Thanks,
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
