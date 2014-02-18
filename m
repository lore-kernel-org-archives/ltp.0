Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WFgfY-0000FK-Qr
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:08:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFgfW-0003w2-TC
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:08:48 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1I98Z3k026942
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 17:08:37 +0800
Message-ID: <53032292.8050202@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 17:06:26 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1392180624-18697-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392180624-18697-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] getdents/getdents02.c: add ENOENT test for
	getdents(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 02/12/2014 12:50 PM, Xiaoguang Wang wrote:
> Merge getdents02.c, getdents03.c, getdents04.c into one getdents02
> test, which contains EBADF, EINVAL and ENOTDIR error value tests.
> 
> And add new ENOENT error value test.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/ltplite                                 |   2 -
>  runtest/stress.part3                            |   2 -
>  runtest/syscalls                                |   4 -
>  testcases/kernel/syscalls/getdents/getdents02.c | 160 ++++++++++++++++++------
>  testcases/kernel/syscalls/getdents/getdents03.c | 126 -------------------
>  testcases/kernel/syscalls/getdents/getdents04.c | 127 -------------------
>  6 files changed, 125 insertions(+), 296 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/getdents/getdents03.c
>  delete mode 100644 testcases/kernel/syscalls/getdents/getdents04.c


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
