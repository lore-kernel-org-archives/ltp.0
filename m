Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WTALg-0006jH-Bb
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:28:00 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTALe-0006gT-J0
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:28:00 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDRpus013580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:27:52 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDRoeU023079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:27:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s2RDRoQO018971
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:27:50 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 27 Mar 2014 17:28:18 +0400
Message-Id: <1395926898-11327-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] doc: test-writing-guidelines
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

Add thread-safety paragraph
Add example of how to use TST_DECLARE_ONCE_FN

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 doc/test-writing-guidelines.txt |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 337a6a8..a7250b7 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -14,7 +14,7 @@ guide and it's not, by any means, a substitute for common sense.
 
 For all it's worth keep the testcases simple or better as simple as possible.
 The kernel and libc are tricky beasts and the complexity imposed by their
-interfaces is is quite high. Concentrate on the interface you want to test and
+interfaces is quite high. Concentrate on the interface you want to test and
 follow the UNIX philosophy. It's a good idea to make the test as
 self-contained as possible too (it should not depend on tools or libraries
 that are not widely available).
@@ -671,6 +671,40 @@ bellow:
 	}
 -------------------------------------------------------------------------------
 
+2.2.12 Thread-safety in the LTP library
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+It is safe to use library 'tst_' functions in multi-threaded tests.
+Synchronization mechanism enabled only if the test is linked with pthread
+library, otherwise no-op stubs (defined in libc) are used.
+
+Also, LTP has a help "TST_DECLARE_ONCE_FN" macro to declare a function which
+must be run only once (e.g. init or cleanup function), but might be called
+by multiple threads in the same time. See example below:
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+...
+
+void do_cleanup(void)
+{
+	/* cleanup code */
+	...
+}
+TST_DECLARE_ONCE_FN(cleanup, do_cleanup);
+
+...
+
+void test01(void)
+{
+	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sfd == -1)
+		tst_brkm(TBROK, cleanup, "Failed to create a socket");
+}
+-------------------------------------------------------------------------------
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
