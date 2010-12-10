Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PR7Ve-0005eP-F5
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:15:58 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PR7Vd-00087l-4S
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:15:58 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBAIFoku008476
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Dec 2010 13:15:50 -0500
Date: Fri, 10 Dec 2010 13:15:50 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1407168634.759561292004950881.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1466293016.759541292004944147.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44958_915450706.1292004950880"
Subject: [LTP] [PATCH] runtest/mm: fix a typo
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

------=_Part_44958_915450706.1292004950880
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

mmap10 tests have been executed already.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 8be3025..82c5a0c 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -54,7 +54,7 @@ mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
-mmap10 mmap10
+mmap11 mmap11
 
 mlock03 mlock03 -i 20
 
-- 
1.7.3.2
------=_Part_44958_915450706.1292004950880
Content-Type: text/x-patch; name=0001-runtest-mm-fix-a-typo.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-runtest-mm-fix-a-typo.patch

From: CAI Qian <caiqian@redhat.com>
Date: Sat, 11 Dec 2010 02:03:44 +0800
Subject: [PATCH] runtest/mm: fix a typo

mmap10 tests have been executed already.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 8be3025..82c5a0c 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -54,7 +54,7 @@ mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
-mmap10 mmap10
+mmap11 mmap11
 
 mlock03 mlock03 -i 20
 
-- 
1.7.3.2


------=_Part_44958_915450706.1292004950880
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_44958_915450706.1292004950880
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_44958_915450706.1292004950880--

