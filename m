Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OLYN6-0007y9-4J
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 09:11:52 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OLYN1-0007lm-U0
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 09:11:52 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o57956C2001497
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jun 2010 03:05:06 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o579BfmA237032
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jun 2010 03:11:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o579BfdN026956
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jun 2010 03:11:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <201006070651.o576p4S0093912@www262.sakura.ne.jp>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<1275834288.7037.3.camel@subratamodak.linux.ibm.com>
	<201006070651.o576p4S0093912@www262.sakura.ne.jp>
Date: Mon, 07 Jun 2010 14:41:38 +0530
Message-Id: <1275901898.4851.2.camel@subratamodak.linux.ibm.com>
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
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2010-06-07 at 15:51 +0900, Tetsuo Handa wrote:
> Hello.
> 
> Subrata Modak wrote:
> > > I updated TOMOYO testcases for Linux 2.6.36.
> > > http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&root=tomoyo
> > > 4425 lines, 141,420 bytes.
> > > MD5: aeb0af73a8f140d50d4ab7435b10de16
> > 
> > Thanks for intimating us the updates about the TOMYO test cases. Would
> > you mind sending us a patch against the LTP git
> > repo(git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev) so that i can
> > push your path against the latest tree.
> > 
> Above one applies against http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz
> 
> I didn't know ltp moved repository from cvs to git.
> I downloaded files from cvs. Adding some notes on
> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.2
> might help preventing users from downloading old files.

The patch will apply fine with the git tree as well, as, no changes has
gone into the TOMYO tree recently. And git is just a migration from cvs
without harming the code. So, all patches will apply to git as well.
However, this patch did not apply as it was not created properly:

patching file testcases/kernel/security/tomoyo/README
patching file testcases/kernel/security/tomoyo/include.h
patching file testcases/kernel/security/tomoyo/newns.c
patching file testcases/kernel/security/tomoyo/testall.sh
patching file testcases/kernel/security/tomoyo/tomoyo_accept_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_file_test.c
patching file testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
patch: **** malformed patch at line 2088: 

Please create it properly and send me.

Meanwhile i am having trouble logging to the sf.net site. I will change
the documentation accordingly when i get a proper access.

Regards--
Subrata

> 
> Regards.


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
