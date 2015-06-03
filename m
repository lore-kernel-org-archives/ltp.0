Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z026n-0007UR-Hb
	for Ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 06:25:01 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z026m-0002T9-Ad
	for Ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 06:25:01 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 3 Jun 2015 06:25:02 +0000
Message-ID: <1433312690.1911.3.camel@localhost>
References: <556E9A9E.7080202@windriver.com>
In-Reply-To: <556E9A9E.7080202@windriver.com>
Content-Language: en-US
Content-ID: <55A510F95CD5F84483827A807800F90F@fujitsu.local>
MIME-Version: 1.0
Subject: Re: [LTP] ltp: vma03 fix the alginment of page size
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
To: "chuang.dong@windriver.com" <chuang.dong@windriver.com>
Cc: "Ltp-list@lists.sourceforge.net" <Ltp-list@lists.sourceforge.net>

Hi,
Maybe you had to fix your typo in commit message.
You can using 'set spell' to check it before pushing it. 

Regards,
Wei
On Wed, 2015-06-03 at 14:11 +0800, cdong wrote:
> Hi,
>         There is a patch to fix vma03 test case,the below information is 
> detail it:
> 
>         the offset the parameter of mmap2() doesn't align the page 
> size,but,this parameter
>         allow must be a multiple of the page size as returned by 
> sysconf(_SC_PAGE_SIZE).
>         meanwhile offset * 4096 must be a multiple of the system page 
> size,so modify
>         the input param of offset pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));
> 
>      Regards,
>      Apollo
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
