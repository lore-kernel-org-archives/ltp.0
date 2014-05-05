Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WhCAu-0002PW-5O
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 06:14:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WhCAs-0005Mp-KG
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 06:14:52 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s456Eesa026597
	for <ltp-list@lists.sourceforge.net>; Mon, 5 May 2014 14:14:40 +0800
Message-ID: <53672C05.9020301@cn.fujitsu.com>
Date: Mon, 5 May 2014 14:13:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] kernel/mem/lib/mem.c: fix compilation warnings
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

On 04/28/2014 04:47 PM, Xiaoguang Wang wrote:
> Functions declared in testcases/kernel/mem/include/_private.h is not
> implemented and used, so delete it.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/include/_private.h | 22 ----------------------
>  testcases/kernel/mem/include/mem.h      |  2 +-
>  testcases/kernel/mem/lib/mem.c          | 25 +++++++++++++++----------
>  3 files changed, 16 insertions(+), 33 deletions(-)
>  delete mode 100644 testcases/kernel/mem/include/_private.h

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
