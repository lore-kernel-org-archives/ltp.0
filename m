Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7R6V-0008Jk-BH
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 12:45:27 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7R6N-0000zh-LY
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 12:45:27 +0000
Received: by dado14 with SMTP id o14so904543dad.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Mar 2012 05:45:13 -0700 (PDT)
Message-ID: <4F5F4112.2040309@casparzhang.com>
Date: Tue, 13 Mar 2012 20:44:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
	<1331614605-30347-11-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-11-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 10/11] hugetlb/hugeshmget03: fix broken testcase
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
To: LTP List <ltp-list@lists.sourceforge.net>

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
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 

Wanlong, thanks for review.

All: FYI, all the other patches except this one (10/11) pushed after
successful testing for enough times.

Caspar

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
