Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WiMNx-0006QM-11
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 11:21:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiMNu-0001qT-9f
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 11:21:08 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s48BKwL8022933
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 19:20:58 +0800
Message-ID: <1399548014.2102.21.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 8 May 2014 19:20:14 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] setpriority/setpriority01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0563967389611598639=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

--===============0563967389611598639==
Content-Type: multipart/alternative; boundary="=-mxmwTEXy56babLRamt6f"

--=-mxmwTEXy56babLRamt6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

* Delete some useless commtents.
* Move the test body from main() to setpriority_verify().
* Expand tests([-20,19]).
* Add tst_require_root for lowering priorities testes.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/setpriority/setpriority01.c    | 166 +++++++--------------
 1 file changed, 52 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index c0cbe15..d94d9d8 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -1,58 +1,25 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	03/2001 - Written by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setpriority01.c
- *
  * DESCRIPTION
  *	setpriority01 - set the priority for the test process lower.
- *
- * CALLS
- *	setpriority()
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	read back the priority with getpriority()
- *	check the errno value
- *	  if errno == 0 and the new priority == the set priority
- *	  then issue a PASS message
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setpriority01 [-c n] [-f] [-i n] [-I x] [-p x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
 #include "test.h"
@@ -62,73 +29,29 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 
-void cleanup(void);
-void setup(void);
+static void cleanup(void);
+static void setpriority01(const int);
+static void setup(void);
 
 char *TCID = "setpriority01";
-int TST_TOTAL = 1;
+int TST_TOTAL = 40;
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	int priority;
-	int new_val = 2;	/* lower our priority from 0 to new_val */
+	int new_val;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
-
-		/*
-		 * Lower the priority of this process from a default of 0
-		 * to a new value of 2.  Then read the value using getpriority()
-		 * to verify the change.
-		 */
-
-		/*
-		 * We need to be careful here. We could possibly set our
-		 * priority lower using PRIO_USER and then have no way
-		 * to set it back.  So, let's use PRIO_PROCESS and make
-		 * sure we affect this test only.
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, 0, new_val));
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "call failed - errno = %d - "
-				 "%s", TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		if (STD_FUNCTIONAL_TEST) {
-			/* get the priority that we just set */
-			priority = getpriority(PRIO_PROCESS, 0);
-
-			if (errno == -1) {
-				tst_brkm(TBROK, cleanup, "getpriority call "
-					 "failed - errno = %d - %s", errno,
-					 strerror(errno));
-			}
-
-			if (priority == new_val) {
-				tst_resm(TPASS, "functionality is correct");
-			} else {
-				tst_resm(TFAIL, "current priority (%d) and new "
-					 "priority (%d) do not match",
-					 priority, new_val);
-			}
-		} else {
-			tst_resm(TPASS, "call succeeded");
-		}
+		for (new_val = -20; new_val < 20; new_val++)
+			setpriority01(new_val);
 	}
 
 	cleanup();
@@ -136,27 +59,42 @@ int main(int ac, char **av)
 
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
+static void setpriority01(const int new_prio)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
+	int priority;
+	TEST(setpriority(PRIO_PROCESS, 0, new_prio));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "setpriority(%d) failed", new_prio);
+		return;
+	}
 
+	priority = getpriority(PRIO_PROCESS, 0);
+	if (errno == -1) {
+		tst_brkm(TBROK, cleanup,
+			 "getpriority call failed - errno = %d - %s", errno,
+			 strerror(errno));
+	}
+
+	if (priority == new_prio) {
+		tst_resm(TPASS, "setpriority(%d) succeeded", new_prio);
+	} else {
+		tst_resm(TFAIL,
+			 "current priority-%d and new priority-%d do not match",
+			 priority, new_prio);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
 }
-- 
1.8.4.2



--=-mxmwTEXy56babLRamt6f
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/4.6.6">
</HEAD>
<BODY>
<PRE>
* Delete some useless commtents.
* Move the test body from main() to setpriority_verify().
* Expand tests([-20,19]).
* Add tst_require_root for lowering priorities testes.
* Some cleanup.

Signed-off-by: Zeng Linggang &lt;<A HREF="mailto:zenglg.jy@cn.fujitsu.com">zenglg.jy@cn.fujitsu.com</A>&gt;
---
 .../kernel/syscalls/setpriority/setpriority01.c&nbsp;&nbsp;&nbsp; | 166 +++++++--------------
 1 file changed, 52 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index c0cbe15..d94d9d8 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -1,58 +1,25 @@
 /*
+ * Copyright (c) International Business Machines&nbsp; Corp., 2001
+ *	03/2001 - Written by Wayne Boyer
&nbsp; *
- *&nbsp;&nbsp; Copyright (c) International Business Machines&nbsp; Corp., 2001
- *
- *&nbsp;&nbsp; This program is free software;&nbsp; you can redistribute it and/or modify
- *&nbsp;&nbsp; it under the terms of the GNU General Public License as published by
- *&nbsp;&nbsp; the Free Software Foundation; either version 2 of the License, or
- *&nbsp;&nbsp; (at your option) any later version.
+ * This program is free software;&nbsp; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
&nbsp; *
- *&nbsp;&nbsp; This program is distributed in the hope that it will be useful,
- *&nbsp;&nbsp; but WITHOUT ANY WARRANTY;&nbsp; without even the implied warranty of
- *&nbsp;&nbsp; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See
- *&nbsp;&nbsp; the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;&nbsp; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See
+ * the GNU General Public License for more details.
&nbsp; *
- *&nbsp;&nbsp; You should have received a copy of the GNU General Public License
- *&nbsp;&nbsp; along with this program;&nbsp; if not, write to the Free Software
- *&nbsp;&nbsp; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;&nbsp; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
&nbsp; */
 
 /*
- * NAME
- *	setpriority01.c
- *
&nbsp; * DESCRIPTION
&nbsp; *	setpriority01 - set the priority for the test process lower.
- *
- * CALLS
- *	setpriority()
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	read back the priority with getpriority()
- *	check the errno value
- *	&nbsp; if errno == 0 and the new priority == the set priority
- *	&nbsp; then issue a PASS message
- *	otherwise, the tests fails
- *	&nbsp; issue a FAIL message
- *	&nbsp; break any remaining tests
- *	&nbsp; call cleanup
- *
- * USAGE:&nbsp; &lt;for command-line&gt;
- *&nbsp; setpriority01 [-c n] [-f] [-i n] [-I x] [-p x] [-t]
- *&nbsp;&nbsp;&nbsp;&nbsp; where,&nbsp; -c n : Run n copies concurrently.
- *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -f&nbsp;&nbsp; : Turn off functionality Testing.
- *	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -i n : Execute test n times.
- *	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -I x : Execute test for x seconds.
- *	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -P x : Pause for x seconds between iterations.
- *	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -t&nbsp;&nbsp; : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
&nbsp; */
 
 #include &quot;test.h&quot;
@@ -62,73 +29,29 @@
 #include &lt;sys/time.h&gt;
 #include &lt;sys/resource.h&gt;
 
-void cleanup(void);
-void setup(void);
+static void cleanup(void);
+static void setpriority01(const int);
+static void setup(void);
 
 char *TCID = &quot;setpriority01&quot;;
-int TST_TOTAL = 1;
+int TST_TOTAL = 40;
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	int priority;
-	int new_val = 2;	/* lower our priority from 0 to new_val */
+	int new_val;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, &quot;OPTION PARSING ERROR - %s&quot;, msg);
-	}
 
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
-
-		/*
-		 * Lower the priority of this process from a default of 0
-		 * to a new value of 2.&nbsp; Then read the value using getpriority()
-		 * to verify the change.
-		 */
-
-		/*
-		 * We need to be careful here. We could possibly set our
-		 * priority lower using PRIO_USER and then have no way
-		 * to set it back.&nbsp; So, let's use PRIO_PROCESS and make
-		 * sure we affect this test only.
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, 0, new_val));
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, &quot;call failed - errno = %d - &quot;
-				 &quot;%s&quot;, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		if (STD_FUNCTIONAL_TEST) {
-			/* get the priority that we just set */
-			priority = getpriority(PRIO_PROCESS, 0);
-
-			if (errno == -1) {
-				tst_brkm(TBROK, cleanup, &quot;getpriority call &quot;
-					 &quot;failed - errno = %d - %s&quot;, errno,
-					 strerror(errno));
-			}
-
-			if (priority == new_val) {
-				tst_resm(TPASS, &quot;functionality is correct&quot;);
-			} else {
-				tst_resm(TFAIL, &quot;current priority (%d) and new &quot;
-					 &quot;priority (%d) do not match&quot;,
-					 priority, new_val);
-			}
-		} else {
-			tst_resm(TPASS, &quot;call succeeded&quot;);
-		}
+		for (new_val = -20; new_val &lt; 20; new_val++)
+			setpriority01(new_val);
 	}
 
 	cleanup();
@@ -136,27 +59,42 @@ int main(int ac, char **av)
 
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or premature exit.
- */
-void cleanup(void)
+static void setpriority01(const int new_prio)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
+	int priority;
+	TEST(setpriority(PRIO_PROCESS, 0, new_prio));
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, &quot;setpriority(%d) failed&quot;, new_prio);
+		return;
+	}
 
+	priority = getpriority(PRIO_PROCESS, 0);
+	if (errno == -1) {
+		tst_brkm(TBROK, cleanup,
+			 &quot;getpriority call failed - errno = %d - %s&quot;, errno,
+			 strerror(errno));
+	}
+
+	if (priority == new_prio) {
+		tst_resm(TPASS, &quot;setpriority(%d) succeeded&quot;, new_prio);
+	} else {
+		tst_resm(TFAIL,
+			 &quot;current priority-%d and new priority-%d do not match&quot;,
+			 priority, new_prio);
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
 }
-- 
1.8.4.2


</PRE>
</BODY>
</HTML>

--=-mxmwTEXy56babLRamt6f--


--===============0563967389611598639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--===============0563967389611598639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0563967389611598639==--

