Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TOf4K-0003uZ-Cl
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:38:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOf4J-0001VI-8D
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:38:40 +0000
Message-ID: <507F5D2B.5030402@cn.fujitsu.com>
Date: Thu, 18 Oct 2012 09:36:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <507D6CAD.1040209@mips.com>
	<20121017173819.11624.74780.stgit@localhost6.localdomain6>
In-Reply-To: <20121017173819.11624.74780.stgit@localhost6.localdomain6>
Subject: Re: [LTP] [PATCH] pipe01 should only check the data actually
 received from the	pipe
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
To: Chris Dearman <chris@mips.com>
Cc: ltp-list@lists.sourceforge.net

On 10/18/2012 01:38 AM, Chris Dearman wrote:
> The pipe write does not include the string terminator. The way the
> test is written it's valid for the writer to send less than the
> requested data and for the reader to read less than the number of
> written bytes, so just compare the actual bytes received.
> 
> Signed-off-by: Chris Dearman <chris@mips.com>

Pushed with Cyril's Ack, thank you.

Wanlong Gao

> ---
>  testcases/kernel/syscalls/pipe/pipe01.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
