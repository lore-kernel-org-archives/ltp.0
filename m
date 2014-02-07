Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WBliq-0008H4-VW
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 13:44:01 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WBliq-0007bP-2l
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 13:44:00 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s17DhrDQ014517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:54 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s17DhqMf025860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:53 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s17DhqwK025848
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  7 Feb 2014 17:43:54 +0400
Message-Id: <1391780634-23420-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1391780634-23420-1-git-send-email-alexey.kodanev@oracle.com>
References: <1391780634-23420-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/4] lib/test.h: create macro to declare init/cleanup
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/test.h |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/test.h b/include/test.h
index 29824d3..1195dac 100644
--- a/include/test.h
+++ b/include/test.h
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2009-2013 Cyril Hrubis chrubis@suse.cz
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -114,6 +115,36 @@
 extern int Forker_pids[];
 extern int Forker_npids;
 
+/*
+ * Macro to use for making functions called only once in
+ * multi-threaded tests such as init or cleanup function.
+ * The first call to @name_fn function by any thread shall
+ * call the @exec_fn. Subsequent calls shall not call @exec_fn.
+ * *_fn functions must not take any arguments.
+ */
+#define DECLARE_ONCE_FN(name_fn, exec_fn)			\
+	static pthread_once_t executed = PTHREAD_ONCE_INIT;	\
+	static void name_fn(void)				\
+	{							\
+		pthread_once(&executed, exec_fn);		\
+	}
+
+/*
+ * Will be defined if test is compiled with -pthread.
+ * Then we can use thread-safe versions.
+ */
+#ifdef _REENTRANT
+
+#define tst_resm	tst_resm_r
+#define tst_resm_hexd	tst_resm_hexd
+#define tst_brk		tst_brk_r
+#define tst_brkm	tst_brkm_r
+#define tst_flush	tst_flush_r
+#define tst_exit	tst_exit_r
+#define tst_environ	tst_environ_r
+
+#endif /* _REENTRANT */
+
 /* lib/tst_res.c */
 const char *strttype(int ttype);
 void tst_res(int ttype, char *fname, char *arg_fmt, ...)
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
