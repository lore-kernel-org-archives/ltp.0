Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QkAoC-0005se-WB
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QkAoA-0004YO-Om
	for ltp-list@lists.sourceforge.net; Fri, 22 Jul 2011 08:10:08 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6M8A1Eb018553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:01 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p6M8A0im017362
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Jul 2011 04:10:00 -0400
Message-ID: <4E293057.8020908@redhat.com>
Date: Fri, 22 Jul 2011 10:09:59 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/6 v3] cgroups/cgroup_regression_test fixes
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
To: ltp-list@lists.sourceforge.net


The following patches fix sporadic failures and typos in
cgroups/cgroup_regression_test and related scripts.

Jan Stancek (6):
   cgroups/cgroup_regression_test: clear dmesg before test
   cgroups/cgroup_regression_test: fix test_5 mount typo
   cgroups/cgroup_regression_test: fix test_6 cleanup
   cgroups/cgroup_regression_test: fix test_7_2 failed mount message
   cgroups/cgroup_regression_test: fix test_10 cleanup
   cgroups/cgroup_regression_test: fix test_*.sh trap in loop

  .../controllers/cgroup/cgroup_regression_test.sh   |   14 +++++++++-----
  testcases/kernel/controllers/cgroup/test_10_1.sh   |    3 +--
  testcases/kernel/controllers/cgroup/test_10_2.sh   |    3 +--
  testcases/kernel/controllers/cgroup/test_3_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_3_2.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_6_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_9_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_9_2.sh    |    3 +--
  8 files changed, 16 insertions(+), 19 deletions(-)


------------------------------------------------------------------------------
10 Tips for Better Web Security
Learn 10 ways to better secure your business today. Topics covered include:
Web security, SSL, hacker attacks & Denial of Service (DoS), private keys,
security Microsoft Exchange, secure Instant Messaging, and much more.
http://www.accelacomm.com/jaw/sfnl/114/51426210/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
