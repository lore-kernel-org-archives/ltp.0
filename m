Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penguin-kernel@i-love.sakura.ne.jp>)
	id 1OLWrK-0003ZL-Hc
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 07:34:58 +0000
Received: from www262.sakura.ne.jp ([202.181.97.72])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OLWrI-0002KK-99
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 07:34:58 +0000
Message-Id: <201006070651.o576p4S0093912@www262.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Date: Mon, 07 Jun 2010 15:51:04 +0900
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<1275834288.7037.3.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1275834288.7037.3.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [linux-2.6.36] TOMOYO Linux update
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Hello.

Subrata Modak wrote:
> > I updated TOMOYO testcases for Linux 2.6.36.
> > http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&root=tomoyo
> > 4425 lines, 141,420 bytes.
> > MD5: aeb0af73a8f140d50d4ab7435b10de16
> 
> Thanks for intimating us the updates about the TOMYO test cases. Would
> you mind sending us a patch against the LTP git
> repo(git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev) so that i can
> push your path against the latest tree.
> 
Above one applies against http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz

I didn't know ltp moved repository from cvs to git.
I downloaded files from cvs. Adding some notes on
http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.2
might help preventing users from downloading old files.

Regards.

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
