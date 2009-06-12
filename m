Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davidel@xmailserver.org>) id 1MExDE-00059c-Tt
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 03:13:52 +0000
Received: from x35.xmailserver.org ([64.71.152.41])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MExD8-00062q-Fn
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 03:13:47 +0000
Date: Thu, 11 Jun 2009 19:50:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <1244775243.4982.5.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.DEB.1.10.0906111950180.4604@makko.or.mcafeemobile.com>
References: <1244775243.4982.5.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [005][RFC] [TESTING linux-2.6.30] eventfd: improve
 support for semaphore-like behavior
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Michael Kerrisk <mtk.manpages@gmail.com>, Ulrich Drepper <drepper@redhat.com>

On Fri, 12 Jun 2009, Subrata Modak wrote:

> Hi Davide,
> 
> Your had introduced an improvement to support for semaphore-like
> behavior in eventfd for linux-2.6.30. And also have a small test program
> envisaged through:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bcd0b235bf3808dec5115c381cd55568f63b85f0,
> http://www.xmailserver.org/eventfd-sem.c,
> 
> Would you be willing to share this test program for inclusion in Linux
> Test Project (http://ltp.sourceforge.net/) under GPLv2 ? If affirmative,
> can you confirm by replying to this mail with your consent/Sign-off.

Sure, it's all yours ;)



- Davide



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
