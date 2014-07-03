Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1X2bOA-0003aj-J6
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 07:25:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X2bO7-0005bU-PG
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 07:25:01 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s637OrMd023030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 07:24:54 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s637OqRG008365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 07:24:53 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s637OqoM028850
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Jul 2014 07:24:52 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  3 Jul 2014 11:24:42 +0400
Message-Id: <1404372282-21896-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140702132544.GA4424@rei.scz.novell.com>
References: <20140702132544.GA4424@rei.scz.novell.com>
Subject: [LTP] [PATCH] test-writing-guidelines.txt: added info about
	tst_get_unused_pid()
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 doc/test-writing-guidelines.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index af31d38..ea88126 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -871,6 +871,21 @@ newly created dir has two links allready the '.' and the link from parent
 dir). If no limit is hit or 'mkdir(2)' failed with 'ENOSPC' or 'EDQUOT', zero
 is returned previously created directories are removed.
 
+2.2.17 Getting an unused PID number
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests require a PID value, which is not used by the OS or any process
+within it. For example, kill(2) should set errno to ESRCH if it's passed such a PID.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+pid_t tst_get_unused_pid(void (*cleanup)(void));
+-------------------------------------------------------------------------------
+
+Return a PID value not used by the OS or any process within it.
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
