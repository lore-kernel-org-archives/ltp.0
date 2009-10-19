Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MzhWw-0003G4-Fm
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 01:59:26 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MzhWp-0007SZ-E6
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 01:59:25 +0000
Received: by pzk26 with SMTP id 26so2917440pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 18:59:13 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 18 Oct 2009 18:36:38 -0700
Message-ID: <364299f40910181836s3a7272d5v2d13f81a7b0cde02@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] check_cpufreq_sysfs_files.sh : infinite block when cat'ing
	cpuinfo_min_freq sysfs file
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

Hi Poornima,
    I'm currently cleaning up the runpwtests.sh script and all other
directly associated bourne shell scripts and I've run into some odd
behavior with check_cpufreq_sysfs_files.sh. As part of the test it
tries to read .../cpuinfo_min_freq, but for whatever reason this is
blocking with cat(1), such that when I try and kill cat, it's not
responding to the signals I'm sending (I sent 1 - 30 just to be safe).

26178 pts/0    D      0:00 cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
26350 pts/0    D      0:00 cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
26515 pts/0    D      0:00 cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
26679 pts/0    D      0:00 cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
26858 pts/0    D      0:00 cat
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

Linux orangebox 2.6.30-gentoo-r4 #1 SMP PREEMPT Sat Aug 8 19:31:26 PDT
2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz GenuineIntel
GNU/Linux

    My kernel version is listed above; I'll gladly provide more
details as necessary.
Thanks!
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
