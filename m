Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSaS8-0000Yj-0B
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 17:45:36 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSaS3-0007nZ-6o
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 17:45:35 +0000
Received: by pxi28 with SMTP id 28so1544935pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 19 Jul 2009 10:45:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 19 Jul 2009 10:45:30 -0700
Message-ID: <364299f40907191045i63baf0efuff5ff32114fec496@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Splitting patches off for Makefile changes...
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
To: LTP list <ltp-list@lists.sourceforge.net>

Hi all,
    I've noticed that the number of required changes for the Makefile
changes to work is large, so in an effort to get everything working
all at once I'm going to split off my changes vs HEAD, so folks can
test and commit, and the July '09 snapshot can get out the door
without issues (my current estimate on completion is ~Aug 15th).
    So, if you want to join in the party, it'll take place on the
makefile_infra_rework branch. As always, you'll need CVS access for
commit, but at least you can look at the work that I'm doing before
attempting to fix anything in HEAD to verify whether or not the same
issue still applies.
    I'll create a file TODO in the root of the project which lists who
owns what so there won't be any unnecessary duplication of work.
Cheers,
-Garrett

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
