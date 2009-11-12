Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N8XiT-0007nO-7k
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:19:53 +0000
Received: from mail-px0-f183.google.com ([209.85.216.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8XiK-000879-5I
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:19:53 +0000
Received: by pxi13 with SMTP id 13so1476498pxi.24
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Nov 2009 03:19:37 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 12 Nov 2009 03:19:37 -0800
Message-ID: <364299f40911120319w1701c177o90a18bf56b99a0ca@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [RFC] proc01 : add flag to read /proc/irq ; skip by default
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
    To provide some background, my group is working on several
evaluation boards and one of the boards we have unfortunately has
issues with its usb driver, where the proc01 testcase gets stuck
trying to poll the /proc/irq file with the corresponding device.
    I was wondering whether or not this could be removed by default,
and /proc/irq reading could be enabled by a -i option (say, in the
crashme test suite) to ensure that systems with faulty hardware /
drivers don't hang indefinitely and this testcase can still be run on
those platforms.
Thanks!
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
