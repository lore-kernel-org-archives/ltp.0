Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TWMVb-0002Q3-VI
	for ltp-list@lists.sourceforge.net; Thu, 08 Nov 2012 07:26:40 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TWMVa-0005DT-TH
	for ltp-list@lists.sourceforge.net; Thu, 08 Nov 2012 07:26:39 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qA87QWpX019704
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 7 Nov 2012 23:26:32 -0800 (PST)
From: <jin.li@windriver.com>
Date: Thu, 8 Nov 2012 15:26:21 +0800
Message-ID: <1352359582-7832-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] clean up cpuhotplug test cases
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

Hi all,

I want to clean up the cpuhotplug test in LTP.

In this commit, I just split the test cases and change scenario group file and
test case name. The fix for each test case will come up later.

Regards,

Jin

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
