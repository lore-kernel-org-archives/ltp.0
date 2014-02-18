Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WFgej-0000nw-Qh
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:07:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFgej-0003ty-0W
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 09:07:57 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1I97ijn026898
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 17:07:44 +0800
Message-ID: <5303225F.3070405@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 17:05:35 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <20140203142910.GA3996@rei>
	<1392197965-26132-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392197965-26132-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] fcntl/fcntl29.c: add F_DUPFD_CLOEXEC test for
 fcntl(2)
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

On 02/12/2014 05:39 PM, Xiaoguang Wang wrote:
> create a new case to test F_DUPFD_CLOEXEC for fcntl(2)
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  include/lapi/fcntl.h                      |   4 ++
>  runtest/ltplite                           |   1 +
>  runtest/stress.part3                      |   1 +
>  runtest/syscalls                          |   2 +
>  testcases/kernel/syscalls/.gitignore      |   2 +
>  testcases/kernel/syscalls/fcntl/fcntl29.c | 114 ++++++++++++++++++++++++++++++
>  6 files changed, 124 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fcntl/fcntl29.c

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
