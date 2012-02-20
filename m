Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RzSWE-00059y-V3
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 12:39:02 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RzSW9-0003Bm-Cr
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 12:39:02 +0000
Message-ID: <4F423ED9.2040303@imgtec.com>
Date: Mon, 20 Feb 2012 12:38:49 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
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
To: ltp-list@lists.sourceforge.net

On 02/20/2012 10:55 AM, Caspar Zhang wrote:

> 
> this patch fixes two problems.
> 
> 1) avoid using functions from numactl package, so compilation would pass
> w/ and w/o numactl development package installed.
> 
> 2) count_numa() functions now has a parameter, which stores the array of
> each nodes on the system. This is because some systems doesn't have
> continuous nodes or the node sequence does not start from zero, when we
> want to test specific node, we should make sure the node does exist.
> Thus, an array for node numbers is necessary. Follow-up patches will
> update count_numa() with new parameters accordingly.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/include/mem.h |    2 +-
>  testcases/kernel/mem/lib/mem.c     |   12 +++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)


That works for me (same for the other 2 patches of this series)

Tested-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos


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
