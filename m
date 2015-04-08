Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YftrH-00070n-QX
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:47 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YftrG-00064P-M1
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:47 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t38HXeIB032122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXekU027220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:40 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXexu010806
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:40 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  8 Apr 2015 20:33:25 +0300
Message-Id: <1428514408-8763-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] cpuhotplug fixes
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
Cc: vasily.isaenko@oracle.com

Hi!

The current version of cpuhotplug04.sh fails with our sparc64 kernel:

Name:   cpuhotplug04
Date:   Mon Apr  6 14:30:45 EDT 2015
Desc:   Does it prevent us from offlining the last CPU?

cat: /sys/devices/system/cpu/cpu3/online: No such file or directory
/opt/ltp/testcases/bin/cpuhotplug_hotplug.sh: line 210: [: =: unary operator expected
cpuhotplug04 1 TBROK : cpu3 cannot be onlined

because the kernel doesn't support hotpluggable cpus.

This series is an attempt to fix cpuhotplug04 plus some other 'improvements'.

Tested in our sparc64 environment and in a x86_64 virtual box vm (both with and without
cpu0_hotplug kernel cmdline), but additional testing is welcome :)

Thanks.

PS: should not be a blocker for the upcoming LTP release


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
