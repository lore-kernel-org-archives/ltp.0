Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VoQ4Z-0000MW-HN
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:57:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoQ4X-0002z6-3s
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:57:55 +0000
Message-ID: <529FF964.3070308@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 11:56:20 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1386209518-599-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1386209518-599-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] asapi_07: fix data types
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
To: Simon Xu <xu.simon@oracle.com>, ltp-list@lists.sourceforge.net

On 12/05/2013 10:11 AM, Simon Xu wrote:
> The test always fails because some data types are wrong.
> 
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testcases/network/lib6/asapi_07.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
