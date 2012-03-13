Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7LEj-0007dB-Ev
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 06:29:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7LEe-0007gp-Cm
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 06:29:33 +0000
Message-ID: <4F5EE8FD.30600@cn.fujitsu.com>
Date: Tue, 13 Mar 2012 14:28:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
	<1331614605-30347-12-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-12-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 11/11] libltp: remove
	system_specific_hugepages_info
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
> system_specific_hugepages_info is not well-implemented and has been
> deprecated, all functions in it can be replaced with libmem. So removing
> it.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>


Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  include/system_specific_hugepages_info.h           |   30 ------
>  lib/system_specific_hugepages_info.c               |   93 --------------------
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   19 ++--
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    5 +-
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    1 -
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   24 ++---
>  6 files changed, 21 insertions(+), 151 deletions(-)
>  delete mode 100644 include/system_specific_hugepages_info.h
>  delete mode 100644 lib/system_specific_hugepages_info.c
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
