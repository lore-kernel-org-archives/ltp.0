Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1V4LkK-0003mM-NU
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 02:02:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V4LkI-0002Jp-OY
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 02:02:36 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r6V22REo018870
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Jul 2013 10:02:27 +0800
Message-ID: <51F87045.6010008@cn.fujitsu.com>
Date: Wed, 31 Jul 2013 10:02:45 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <51F86DD4.7050105@cn.fujitsu.com>
In-Reply-To: <51F86DD4.7050105@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mount/mount06.c: fix a compile error
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

On 07/31/2013 09:52 AM, DAN LI wrote:
> The definitions of MS_PRIVATE and MS_MOVE were only added to glibc headers
> in version 2.12.
> 
> If there are no definitions of these two flags, make it.
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
