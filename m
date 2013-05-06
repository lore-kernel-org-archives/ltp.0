Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UZHXa-0006Ku-Gi
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 09:17:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UZHXY-0005C3-L7
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 09:17:02 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r469GsDB018323
	for <ltp-list@lists.sourceforge.net>; Mon, 6 May 2013 17:16:54 +0800
Message-ID: <51877502.8000002@cn.fujitsu.com>
Date: Mon, 06 May 2013 17:16:50 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <517A31DE.2050003@cn.fujitsu.com> <517A3282.2050809@cn.fujitsu.com>
In-Reply-To: <517A3282.2050809@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/mount/mount02.c: modify array
	"exp_enos"
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 04/26/2013 03:53 PM, DAN LI wrote:
> Expected errno setted in array "exp_enos" do not match
> echo test item rightly, leading to two problems:
> 
> * Not every test item in mount02 is executed.
>      There are 13 test items in mount02 currently to test error:
>      ENODEV, ENOTBLK, EBUSY, EBUSY, EINVAL, EINVAL, EINVAL, EFAULT,
>      EFAULT, ENAMETOOLONG, ENOENT, ENOENT, ENOTDIR
> 
>      But, only 8 of them are tested as specified in array "exp_enos":
>      ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,
>      ENOENT, ENOTDIR
> 
> * For test item which is executed, its errno returned is maybe not
> the one expected.
> 
> This patch modifies array "exp_enos" to make it one-to-one correspondent
> with echo test item, to fix above problems.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Applied with s/echo/each/, thanks for you and Mike.

Wanlong Gao


------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
