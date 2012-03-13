Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7LHl-0004Ra-Ue
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 06:32:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7LHk-0005zQ-Rj
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 06:32:41 +0000
Message-ID: <4F5EE65B.9080707@cn.fujitsu.com>
Date: Tue, 13 Mar 2012 14:16:59 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
	<1331614605-30347-3-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-3-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 02/11] hugetlb/hugeshmat: set nr_hugepages in tests
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
> Like hugemmap tests, this patch enables nr_hugepages set/restore in each
> test of hugeshmat, so that we don't need to set the values with external
> commands.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>


Looks good to me.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/mem/hugetlb/Makefile.inc          |   16 +++++-----
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |   28 +++++++++++++++-----
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |   28 +++++++++++++++-----
>  .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |   26 ++++++++++++++----
>  testcases/kernel/mem/hugetlb/lib/ipcshm.h          |    5 +++
>  testcases/kernel/mem/hugetlb/lib/libipc.c          |    7 ++++-
>  6 files changed, 81 insertions(+), 29 deletions(-)
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
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
