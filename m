Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSO6t-0000cJ-Um
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:34:51 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSO6p-0008G2-3J
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:34:51 +0000
Received: by pzk8 with SMTP id 8so1336805pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 21:34:46 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 18 Jul 2009 21:34:46 -0700
Message-ID: <364299f40907182134o1ce0633apf1a2e0ab76271de6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Where's DMLOG_PRINT defined?
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

    I ran into a new compile error today when it couldn't find a file
where this macro was defined. Would anyone know where it's located?
    The testcase that was broken was testcases/kernel/fs/dmapi .
Thanks,
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
