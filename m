Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1N34yt-0007SG-TI
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 09:38:15 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N34yn-0003pw-Th
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 09:38:15 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9S9W2C8007757
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Oct 2009 03:32:02 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9S9c0db165556
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Oct 2009 03:38:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9S9bxEX024184
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Oct 2009 03:37:59 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2009 15:07:57 +0530
Message-Id: <20091028093757.19484.89637.sendpatchset@localhost.localdomain>
In-Reply-To: <20091028093749.19484.92103.sendpatchset@localhost.localdomain>
References: <20091028093749.19484.92103.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 2/2] to delete hardcoded cpu freq governers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Patch to remove hard coded cpu governers

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp/testcases/kernel/power_management/pwkm_load_unload.sh ltp_fixed/testcases/kernel/power_management/pwkm_load_unload.sh
--- ltp/testcases/kernel/power_management/pwkm_load_unload.sh	2009-03-25 02:19:22.000000000 -0400
+++ ltp_fixed/testcases/kernel/power_management/pwkm_load_unload.sh	2009-10-28 00:54:39.000000000 -0400
@@ -3,7 +3,7 @@
 #Loading modules
 RC=0
 loaded_governor=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
-for module in cpufreq_conservative cpufreq_powersave cpufreq_userspace
+for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
 do
 	#echo -n "Loading $module ... "
     if [ $module != "cpufreq_$loaded_governor" ];
@@ -15,7 +15,7 @@ do
 		fi
 	fi
 done
-for module in cpufreq_conservative cpufreq_powersave cpufreq_userspace
+for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
 do
 	#echo -n "Unloading $module ... "
     if [ $module != "cpufreq_$loaded_governor" ];

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
