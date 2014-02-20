Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WGN1R-0006ER-R5
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 06:22:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGN1Q-0007qE-7l
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 06:22:13 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1K6LxtZ025860
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Feb 2014 14:22:02 +0800
Message-ID: <53059E84.6080909@cn.fujitsu.com>
Date: Thu, 20 Feb 2014 14:19:48 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1392706877-7286-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392706877-7286-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] llseek/llseek03.c: add SEEK_CUR,
 SEEK_END flag test
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

On 02/18/2014 03:01 PM, Xiaoguang Wang wrote:
> create a new case to test SEEK_CUR, SEEK_END flag for llseek(2)
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/ltplite                             |   1 +
>  runtest/stress.part3                        |   1 +
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/.gitignore        |   1 +
>  testcases/kernel/syscalls/llseek/llseek03.c | 187 ++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/llseek/llseek03.c

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
