Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WBlin-0001GK-Sq
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 13:43:58 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WBlim-0007bO-Ko
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 13:43:57 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s17DhoQG029993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:51 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s17Dhn8p008026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:50 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s17DhnkW025774
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 13:43:49 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  7 Feb 2014 17:43:53 +0400
Message-Id: <1391780634-23420-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/4] lib/tst_res.c: pull common code out to tst_res.h
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
 lib/tst_res.c |   82 +++++--------------------------------
 lib/tst_res.h |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 71 deletions(-)
 create mode 100644 lib/tst_res.h

diff --git a/lib/tst_res.c b/lib/tst_res.c
index d4c82fd..e8110c2 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -91,16 +91,7 @@
  *
  *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 
-#include <assert.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <string.h>
-#include <unistd.h>
-#include "test.h"
-#include "usctest.h"
-#include "ltp_priv.h"
+#include "tst_res.h"
 
 long TEST_RETURN;
 int TEST_ERRNO;
@@ -111,31 +102,6 @@ struct usc_errno_t TEST_VALID_ENO[USC_MAX_ERRNO];
 pid_t spawned_program_pid;
 #endif
 
-#define VERBOSE      1		/* flag values for the T_mode variable */
-#define NOPASS       3
-#define DISCARD      4
-
-#define MAXMESG      80		/* max length of internal messages */
-#define USERMESG     2048	/* max length of user message */
-#define TRUE         1
-#define FALSE        0
-
-/*
- * EXPAND_VAR_ARGS - Expand the variable portion (arg_fmt) of a result
- *                   message into the specified string.
- *
- * NOTE (garrcoop):  arg_fmt _must_ be the last element in each function
- *		     argument list that employs this.
- */
-#define EXPAND_VAR_ARGS(buf, arg_fmt, buf_len) do {\
-	va_list ap;				\
-	assert(arg_fmt != NULL);		\
-	va_start(ap, arg_fmt);			\
-	vsnprintf(buf, buf_len, arg_fmt, ap);	\
-	va_end(ap);				\
-	assert(strlen(buf) > 0);		\
-} while (0)
-
 /*
  * Define local function prototypes.
  */
@@ -147,23 +113,23 @@ static void cat_file(char *filename);
 /*
  * Define some static/global variables.
  */
-static FILE *T_out = NULL;	/* tst_res() output file descriptor */
-static char *File;		/* file whose contents is part of result */
-static int T_exitval = 0;	/* exit value used by tst_exit() */
-static int T_mode = VERBOSE;	/* flag indicating print mode: VERBOSE, */
+FILE *T_out = NULL;	/* tst_res() output file descriptor */
+char *File;		/* file whose contents is part of result */
+int T_exitval = 0;	/* exit value used by tst_exit() */
+int T_mode = VERBOSE;	/* flag indicating print mode: VERBOSE, */
 			      /* NOPASS, DISCARD */
 
-static char Warn_mesg[MAXMESG];	/* holds warning messages */
+char Warn_mesg[MAXMESG];	/* holds warning messages */
 
 /*
  * These are used for condensing output when NOT in verbose mode.
  */
-static int Buffered = FALSE;	/* TRUE if condensed output is currently */
+int Buffered = FALSE;	/* TRUE if condensed output is currently */
 			      /* buffered (i.e. not yet printed) */
-static char *Last_tcid;		/* previous test case id */
-static int Last_num;		/* previous test case number */
-static int Last_type;		/* previous test result type */
-static char *Last_mesg;		/* previous test result message */
+char *Last_tcid;		/* previous test case id */
+int Last_num;		/* previous test case number */
+int Last_type;		/* previous test result type */
+char *Last_mesg;		/* previous test result message */
 
 /*
  * These globals may be externed by the test.
@@ -172,27 +138,6 @@ int tst_count = 0;		/* current count of test cases executed; NOTE: */
 			/* tst_count may be externed by other programs */
 
 /*
- * These globals must be defined in the test.
- */
-extern char *TCID;		/* Test case identifier from the test source */
-extern int TST_TOTAL;		/* Total number of test cases from the test */
-
-
-struct pair {
-	const char *name;
-	int val;
-};
-
-#define PAIR(def) [def] = {.name = #def, .val = def},
-
-#define PAIR_LOOKUP(pair_arr, idx) do {               \
-	if (idx < 0 || idx >= ARRAY_SIZE(pair_arr) || \
-	    pair_arr[idx].name == NULL)               \
-		return "???";                         \
-	return pair_arr[idx].name;                    \
-} while (0)
-
-/*
  * strttype() - convert a type result to the human readable string
  */
 const char *strttype(int ttype)
@@ -211,11 +156,6 @@ const char *strttype(int ttype)
 }
 
 /*
- * Include table of errnos and strerrnodef() function.
- */
-#include "errnos.h"
-
-/*
  * tst_res() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
  *             tst_condense() or tst_print() to actually print results.
diff --git a/lib/tst_res.h b/lib/tst_res.h
new file mode 100644
index 0000000..408591e
--- /dev/null
+++ b/lib/tst_res.h
@@ -0,0 +1,127 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2009-2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#ifndef __LTP_TST_RES_H__
+#define __LTP_TST_RES_H__
+
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+#include "ltp_priv.h"
+
+extern long TEST_RETURN;
+extern int TEST_ERRNO;
+extern struct usc_errno_t TEST_VALID_ENO[USC_MAX_ERRNO];
+
+/* Break bad habits. */
+#ifdef GARRETT_IS_A_PEDANTIC_BASTARD
+extern pid_t spawned_program_pid;
+#endif
+
+#define VERBOSE      1		/* flag values for the T_mode variable */
+#define NOPASS       3
+#define DISCARD      4
+
+#define MAXMESG      80		/* max length of internal messages */
+#define USERMESG     2048	/* max length of user message */
+#define TRUE         1
+#define FALSE        0
+
+/*
+ * EXPAND_VAR_ARGS - Expand the variable portion (arg_fmt) of a result
+ *                   message into the specified string.
+ *
+ * NOTE (garrcoop):  arg_fmt _must_ be the last element in each function
+ *		     argument list that employs this.
+ */
+#define EXPAND_VAR_ARGS(buf, arg_fmt, buf_len) do {\
+	va_list ap;				\
+	assert(arg_fmt != NULL);		\
+	va_start(ap, arg_fmt);			\
+	vsnprintf(buf, buf_len, arg_fmt, ap);	\
+	va_end(ap);				\
+	assert(strlen(buf) > 0);		\
+} while (0)
+
+/*
+ * Define some static/global variables.
+ */
+extern FILE *T_out;	/* tst_res() output file descriptor */
+extern char *File;		/* file whose contents is part of result */
+extern  int T_exitval;	/* exit value used by tst_exit() */
+extern int T_mode;	/* flag indicating print mode: VERBOSE, */
+			      /* NOPASS, DISCARD */
+
+extern char Warn_mesg[MAXMESG];	/* holds warning messages */
+
+/*
+ * These are used for condensing output when NOT in verbose mode.
+ */
+extern int Buffered;	/* TRUE if condensed output is currently */
+			      /* buffered (i.e. not yet printed) */
+extern char *Last_tcid;		/* previous test case id */
+extern int Last_num;		/* previous test case number */
+extern int Last_type;		/* previous test result type */
+extern char *Last_mesg;		/* previous test result message */
+
+/*
+ * These globals may be externed by the test.
+ */
+extern int tst_count;		/* current count of test cases executed; NOTE: */
+			/* tst_count may be externed by other programs */
+
+/*
+ * These globals must be defined in the test.
+ */
+extern char *TCID;		/* Test case identifier from the test source */
+extern int TST_TOTAL;		/* Total number of test cases from the test */
+
+struct pair {
+	const char *name;
+	int val;
+};
+
+#define PAIR(def) [def] = {.name = #def, .val = def},
+
+#define PAIR_LOOKUP(pair_arr, idx) do {               \
+	if (idx < 0 || idx >= ARRAY_SIZE(pair_arr) || \
+	    pair_arr[idx].name == NULL)               \
+		return "???";                         \
+	return pair_arr[idx].name;                    \
+} while (0)
+
+/*
+ * Include table of errnos and strerrnodef() function.
+ */
+#include "errnos.h"
+
+#endif /* __LTP_TST_RES_H__ */
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
