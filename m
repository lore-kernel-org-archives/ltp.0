Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WGN4U-0006Ku-29
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 06:25:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGN4S-0007zw-Nf
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 06:25:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1K6P6Dk026007
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Feb 2014 14:25:13 +0800
Message-ID: <53059F45.6000901@cn.fujitsu.com>
Date: Thu, 20 Feb 2014 14:23:01 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1388049105.1587.22.camel@G08JYZSD130126>
	<1392732018.2654.7.camel@G08JYZSD130126>
In-Reply-To: <1392732018.2654.7.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] link/link08.c: add new error tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 02/18/2014 10:00 PM, Zeng Linggang wrote:
> Add new error number tests for link(2):
> * EPERM
> * EXDEV
> * EROFS
> * ELOOP
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  runtest/ltplite                         |   1 +
>  runtest/stress.part3                    |   1 +
>  runtest/syscalls                        |   1 +
>  testcases/kernel/syscalls/.gitignore    |   1 +
>  testcases/kernel/syscalls/link/link08.c | 191 ++++++++++++++++++++++++++++++++
>  5 files changed, 195 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/link/link08.c

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
