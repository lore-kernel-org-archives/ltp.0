Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1SmKPM-0000Kt-C6
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 07:53:56 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SmKPG-0003VW-KI
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 07:53:56 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q647riqU024344
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 4 Jul 2012 00:53:44 -0700 (PDT)
From: Jin Li <jin.li@windriver.com>
Date: Wed, 4 Jul 2012 15:53:41 +0800
Message-ID: <1341388422-28133-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Add test path for cpuhotplug test
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

Hi,

Fail to invoke cpuhotplug test via 

./runltp -f cpuhotplug

<<<test_output>>>
incrementing stop
CPU:        1
LOOPS:      1
LHCS_PATH:  /opt/ltp/testcases/bin/cpu_hotplug
/opt/ltp/testcases/bin/cpu_hotplug/runtests.sh: line 15: functional/hotplug??.sh: No such file or directory

Add test path for runtests.sh

Regards,

Jin

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
