Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7oJd-0007Fw-5J
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:32:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7oJX-0007XD-57
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:32:33 +0000
Message-ID: <4F609654.5020206@cn.fujitsu.com>
Date: Wed, 14 Mar 2012 21:00:04 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331704383-21085-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331704383-21085-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] hugetlb/hugemmap02: remove hugemmap02
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

On 03/14/2012 01:53 PM, Caspar Zhang wrote:

> 
> hugemmap02 testcase is broken. It is not implemented as designed, the
> hugemmap succeeded in both 32bit and 64bit. Also the design is not clear
> enough, so it's difficult to fix it. Remove it for now.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>


Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  runtest/hugetlb |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
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
