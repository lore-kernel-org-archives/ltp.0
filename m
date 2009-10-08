Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MvxUz-00088Z-DT
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 18:13:57 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvxUu-0007WB-JO
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 18:13:57 +0000
Received: by pzk37 with SMTP id 37so5939517pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Oct 2009 11:13:46 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Oct 2009 11:13:46 -0700
Message-ID: <364299f40910081113v310c536bh3b08d25ff6e1f8cf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Issue 5 - hard hang and kernel crash when fork12 killed on F10
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
    I noticed that there was a hard hang when running fork12 (it had
been stuck for ~72 minutes), and when I killed the process it caused a
kernel crash. Some other datapoints are that one of the tests
generated a syslog issue (I had gotten all the way to stress or
syscall in the runtest list) before crashing, kswapd usage was 44%
(shouldn't have been), and there was 256MB of free memory left.
    I'll try to reproduce this again, but I was just wondering if
anyone has seen this issue before; I haven't seen this before, but my
target test system isn't my Fedora 10 VM -- it's my Gentoo desktop.
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
