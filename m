Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vkklo-0003KH-QT
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 01:15:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vkkln-0006w6-VM
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 01:15:24 +0000
Message-ID: <52929A66.90704@cn.fujitsu.com>
Date: Mon, 25 Nov 2013 08:31:34 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1385290561-24404-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<201311241215.47426.vapier@gentoo.org>
In-Reply-To: <201311241215.47426.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] runltp: suppress the out message when creating
 loop device
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 11/25/2013 01:15 AM, Mike Frysinger wrote:
> On Sunday 24 November 2013 05:56:01 Wanlong Gao wrote:
>> +    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480 &>/dev/null
> 
> that's a bashism.  you have to use:
> 	... >/dev/null 2>&1

Oops, thank you.

Wanlong Gao

> -mike
> 


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
