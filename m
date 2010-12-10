Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PR7dq-000227-Oq
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:24:26 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PR7dp-00015r-NG
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:24:26 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBAIOKIL013111
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Dec 2010 13:24:20 -0500
Date: Fri, 10 Dec 2010 13:24:20 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <5150122.761061292005460192.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <501902646.761041292005457418.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_45028_1062817524.1292005460191"
Subject: [LTP] [PATCH 5/5] mm/runtest: add oom tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_45028_1062817524.1292005460191
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 82c5a0c..caa674f 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,8 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+oom01 oom01
+oom02 oom02
+oom03 oom03
+oom04 oom04
-- 
1.7.3.2
------=_Part_45028_1062817524.1292005460191
Content-Type: text/x-patch; name=0005-mm-runtest-add-oom-tests.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0005-mm-runtest-add-oom-tests.patch

From: CAI Qian <caiqian@redhat.com>
Date: Sat, 11 Dec 2010 02:11:17 +0800
Subject: [PATCH 5/5] mm/runtest: add oom tests

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 82c5a0c..caa674f 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,8 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+oom01 oom01
+oom02 oom02
+oom03 oom03
+oom04 oom04
-- 
1.7.3.2


------=_Part_45028_1062817524.1292005460191
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_45028_1062817524.1292005460191
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_45028_1062817524.1292005460191--

