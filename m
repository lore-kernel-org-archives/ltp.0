Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SnX7c-0001oD-LE
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:40:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SnX7b-0002C6-Un
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:40:36 +0000
Received: from zmail13.collab.prod.int.phx2.redhat.com
	(zmail13.collab.prod.int.phx2.redhat.com [10.5.83.15])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q67FeUgp028698
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Jul 2012 11:40:30 -0400
Date: Sat, 07 Jul 2012 11:40:30 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <ec65d42d-058d-4e51-b05a-5e8f4d7b51d7@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <f349fd3efe7a762358ed386c9b056f21a7493c6f.1341673870.git.zliu@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] safe_macros: add SAFE_STRTOUL
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
To: LTP list <ltp-list@lists.sourceforge.net>

Hi,

----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Saturday, July 7, 2012 11:14:39 PM
> Subject: [LTP]  [PATCH] safe_macros: add SAFE_STRTOUL
> 
> commit 586992b33b tried to set ULONG_MAX as SAFE_STRTOL upper bound,
> but this would cause the new issue:
> 
>  [root@localhost hugeshmat]# ./hugeshmat01
>  hugeshmat01    0  TINFO  :  set nr_hugepages to 128
>  hugeshmat01    1  TBROK  :  converted value out of range (0 - -1) at
>  mem.c:840
>  hugeshmat01    2  TBROK  :  Remaining cases broken
>  hugeshmat01    0  TINFO  :  set nr_hugepages to 0
> 
> the failure is because SAFE_STRTOL converts ULONG_MAX as long type,
> which
> will change 'ULONG_MAX' as -1.
> 
> the patch add a new macro SAFE_STRTOUL, which is a safe mode of
> strtoul()
> 

I'm sorry for forgetting to mark the order of the patch set.

this patch is depend on 'hugetlb: add a new function get_available_hugepages'
it should be like this:
 [PATCH 1/2] hugetlb: add a new function get_available_hugepages
 [PATCH 2/2] safe_macros: add SAFE_STRTOUL

> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  include/safe_macros.h          |    5 +++++
>  lib/safe_macros.c              |   25 +++++++++++++++++++++++++
>  testcases/kernel/mem/lib/mem.c |    2 +-
>  3 files changed, 31 insertions(+), 1 deletion(-)

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
