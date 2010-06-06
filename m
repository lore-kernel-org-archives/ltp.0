Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OLGmZ-000148-7t
	for ltp-list@lists.sourceforge.net; Sun, 06 Jun 2010 14:24:59 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OLGmX-0005tA-Si
	for ltp-list@lists.sourceforge.net; Sun, 06 Jun 2010 14:24:59 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o56EKcJX006372
	for <ltp-list@lists.sourceforge.net>; Sun, 6 Jun 2010 08:20:38 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o56EOq2S148826
	for <ltp-list@lists.sourceforge.net>; Sun, 6 Jun 2010 08:24:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o56EOqNf002471
	for <ltp-list@lists.sourceforge.net>; Sun, 6 Jun 2010 08:24:52 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
Date: Sun, 06 Jun 2010 19:54:48 +0530
Message-Id: <1275834288.7037.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [linux-2.6.36] TOMOYO Linux update
Reply-To: subrata@linux.vnet.ibm.com
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ltp-list@lists.sourceforge.net

Hello Tetsuo Handa,

On Sun, 2010-06-06 at 17:13 +0900, Tetsuo Handa wrote:
> Hello.
> 
> 
> 
> I updated TOMOYO testcases for Linux 2.6.36.
> http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&root=tomoyo
> 4425 lines, 141,420 bytes.
> MD5: aeb0af73a8f140d50d4ab7435b10de16

Thanks for intimating us the updates about the TOMYO test cases. Would
you mind sending us a patch against the LTP git
repo(git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev) so that i can
push your path against the latest tree.


> 
> 
> By the way, any reason not to update the
> 
>   "Download Now! ltp-full-20100228.tgz (8.8 MB)"
> 
> icon at http://sourceforge.net/projects/ltp/files/ to point to ltp-full-20100430.tgz ?

Ok. I will fix that soon. Thanks for pointing out the anomaly.

Regards--
Subrata

> 
> 
> 
> Regards.
> 
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
