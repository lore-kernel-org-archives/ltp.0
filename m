Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7dUm-00070R-Fn
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 01:59:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7dUk-0002c4-IJ
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 01:59:20 +0000
Message-ID: <4F5FFB36.60609@cn.fujitsu.com>
Date: Wed, 14 Mar 2012 09:58:14 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
	<1331614605-30347-11-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-11-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 10/11] hugetlb/hugeshmget03: fix broken testcase
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/13/2012 12:56 PM, Caspar Zhang wrote:

> 
> hugeshmget03 often returns ENOMEM, so that causes test fails. This patch
> fixes the problem by making the following changes:
> 
> 1) reduce shm_size to minimum (1 hugepage);
> 2) reduce shmmni to 1/2 * nr_hugepages.
> 
> so that when all shmids taken, memory allocated ~=
> 
>     1/2 * nr_hugepages * hugepagesize < free memory
> 
> Which means there will be no ENOMEM occurs, but ENOSPC as expected.


Hi Caspar:

IMO, this looks good and test OK . So

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
