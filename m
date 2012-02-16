Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rxus4-0007Qw-Pe
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:31:12 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rxus0-0007fb-PN
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:31:12 +0000
Received: by pbcum15 with SMTP id um15so2271240pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Feb 2012 22:31:02 -0800 (PST)
Message-ID: <4F3CA283.3090607@casparzhang.com>
Date: Thu, 16 Feb 2012 14:30:27 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1329372380-18378-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329372380-18378-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] mm/vma04: new testcase
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

On 02/16/2012 02:06 PM, Caspar Zhang wrote:
> 
> vma04: corner cases for mbind vma merge issue
> 
> There are several corner cases (documented in mm/mmap.c) for mbind
> vma merge issue, which makes commit 8aacc9f550 slightly incorrect.
> KOSAKI Motohiro made a patch for it (commit e26a511) and composed
> a reproducer containing these corner cases. Now I backport it to
> LTP.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  runtest/mm                       |    1 +
>  testcases/kernel/mem/vma/vma04.c |  320 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 321 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/vma/vma04.c
> 

Test Status:

On a unpatched kernel:

# ./vma04
vma04       1  TFAIL  :  case4: failed. expect '2,4', actual '1,4'
vma04       2  TPASS  :  case5: passed.
vma04       3  TPASS  :  case6: passed.
vma04       4  TPASS  :  case7: passed.
vma04       5  TPASS  :  case8: passed.

On a patched kernel:

# ./vma04
vma04       1  TPASS  :  case4: passed.
vma04       2  TPASS  :  case5: passed.
vma04       3  TPASS  :  case6: passed.
vma04       4  TPASS  :  case7: passed.
vma04       5  TPASS  :  case8: passed.

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
