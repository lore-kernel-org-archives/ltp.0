Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1a97r8-00055i-7w
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2015 08:54:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a97r5-0008Nd-V3
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2015 08:54:42 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NZG01KQN0QIYFC0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 16 Dec 2015 17:54:18 +0900 (KST)
Date: Wed, 16 Dec 2015 08:53:55 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1046379286.777961450256035403.JavaMail.weblogic@epmlwas06c>
Subject: [LTP] [Query] Regarding broken_ip4_version testcase
Reply-To: manjeet.p@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, "pankaj.m@samsung.com" <pankaj.m@samsung.com>

HI,

I am running broken_ip testcases. I am using below env setting

export NETWORK_DELAY=30
export LTP_RSH="ssh -q  -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa -l root"

Testcase:- "broken_ip4_version"
Logs: here (xxx.xxx.xxx.xxx is rhost address)
++ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\'''
<testcase stuck here>

I am not able to proceed after this command. I checked my remote machine, its network is already down when this command executed, but the testcase stuck at this moment and not returning anything.
Am I missing anything?
I checked with all my env settings, they are working for rest of the other testcases but not for this category "broken_ip_*).

Thanks
Manjeet 
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
