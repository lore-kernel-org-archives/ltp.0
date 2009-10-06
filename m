Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MvIqg-00030C-L8
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 22:49:38 +0000
Received: from mail-qy0-f173.google.com ([209.85.221.173])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvIqY-0000N0-SC
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 22:49:38 +0000
Received: by qyk3 with SMTP id 3so3876626qyk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Oct 2009 15:49:25 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 6 Oct 2009 15:49:24 -0700
Message-ID: <364299f40910061549k4684906eu8731521a226021c9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [Issue 4] sched_mc_powersavings missing results in TPASS
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

Hi,
    I've noticed that if /sys/devices/system/cpu/sched_mc_powersavings
is missing, the result is TPASS (even though it shouldn't be):

sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8704  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=52
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8705  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=53
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8706  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=54
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8707  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=55
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8708  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=56
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
Power_Management 8709  TPASS  :  sched domain test for sched_mc=67 &
sched_smt=57
sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory

    It should be TCONF and only one check should be required at the
script doing the call / loop.
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
