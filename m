Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VbhZO-0004mt-Nt
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 02:01:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbhZN-0001tF-O6
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 02:01:10 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9V212gq026005
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 10:01:02 +0800
Message-ID: <5271B9CF.6010406@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 10:00:47 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <526A2834.5090503@cn.fujitsu.com>
In-Reply-To: <526A2834.5090503@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] chmod/chmod06.c: add ELOOP,
 EROFS error number test for chmod(2)
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
To: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

On 10/25/2013 04:13 PM, Wang, Xiaoguang wrote:
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/syscalls                          |    2 +-
>  testcases/kernel/syscalls/chmod/chmod06.c |   65 +++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 4 deletions(-)


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
