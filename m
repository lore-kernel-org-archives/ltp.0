Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WFlLc-00041l-0o
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:08:32 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WFlLa-0007bQ-7N
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:08:31 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1IE8NpJ008911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 14:08:24 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s1IE8Mrm000458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 14:08:23 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1IE8MdU004087
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 14:08:22 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Feb 2014 18:08:30 +0400
Message-Id: <1392732510-25892-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] lib/test.h: add macro to declare init/cleanup
	functions
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Macro to use for making functions called only once in multi-threaded
tests such as init or cleanup function.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/test.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/test.h b/include/test.h
index d46fdbf..78f13c2 100644
--- a/include/test.h
+++ b/include/test.h
@@ -111,6 +111,21 @@ pid_t tst_vfork(void);
 #endif
 
 /*
+ * Macro to use for making functions called only once in
+ * multi-threaded tests such as init or cleanup function.
+ * The first call to @name_fn function by any thread shall
+ * call the @exec_fn. Subsequent calls shall not call @exec_fn.
+ * *_fn functions must not take any arguments.
+ */
+#define DECLARE_ONCE_FN(name_fn, exec_fn)				\
+	void name_fn(void)						\
+	{								\
+		static pthread_once_t name_fn##_ex = PTHREAD_ONCE_INIT;	\
+		pthread_once(&name_fn##_ex, exec_fn);			\
+	}
+
+
+/*
  * lib/forker.c
  */
 extern int Forker_pids[];
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
