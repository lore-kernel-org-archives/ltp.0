Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TOf3g-0003rj-FV
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:38:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOf3f-00040O-M6
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:38:00 +0000
Message-ID: <507F5D03.5010109@cn.fujitsu.com>
Date: Thu, 18 Oct 2012 09:36:03 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <507D6C63.5040704@mips.com>
	<20121017173535.11574.18883.stgit@localhost6.localdomain6>
In-Reply-To: <20121017173535.11574.18883.stgit@localhost6.localdomain6>
Subject: Re: [LTP] [PATCH] Avoid compiler optimisation of malloc calls
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

On 10/18/2012 01:35 AM, Chris Dearman wrote:
> clang understands the malloc library call and can optimise calls to
> it. In particular it will avoid calling malloc completely if it
> detects that the result is not used.
> 
> Signed-off-by: Chris Dearman <chris@mips.com>

Pushed with Cyril's Ack, thank you.

Wanlong Gao

> ---
>  .../conformance/interfaces/pthread_cond_init/4-1.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
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
