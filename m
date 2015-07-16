Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFbkV-0004oi-Ig
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:23 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFbkS-0000oj-KZ
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:23 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 13:30:38 +0800
Message-ID: <1437024647-2066-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 02/11] lib6/runcc.c: Cleanup
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
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

* Add 'static' before some functions and global variables.

* Not use 'mkstemp', use 'tst_tmpdir and tst_rmdir' in actual test.

* Use 'SAFE_FILE_PRINTF' instead of 'open-write-close'.

* Change 'runcc', 'aliascheck', 'funccheck', 'structcheck' and
  'valuecheck' to non-return because of the ignore return value.

* Use 'MACRO' instead of 'const char *'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/runcc.c | 177 ++++++++++++++++-------------------------
 testcases/network/lib6/runcc.h |  52 +++++++-----
 2 files changed, 100 insertions(+), 129 deletions(-)

diff --git a/testcases/network/lib6/runcc.c b/testcases/network/lib6/runcc.c
index 91a0b16..cfc283c 100644
--- a/testcases/network/lib6/runcc.c
+++ b/testcases/network/lib6/runcc.c
@@ -1,31 +1,21 @@
 /*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * runcc.a - common functions for lib6 testing
- *
- * HISTORY
- *	05/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
+ * Author: David L Stevens
  */
 
 #include <stdio.h>
@@ -34,20 +24,23 @@
 #include <ctype.h>
 
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "test.h"
 
-char fieldref[1024];
-char program[8192];
+static char fieldref[1024];
+static char program[8192];
 
-char *filetmpl = "/tmp/%.*s_XXXXXX";
+#define FILETMPL	"./%.*s"
 
-char cmd[1024];
+static char cmd[1024];
 
 /*
  * like strspn, with ASCII, numbers and underscore only
  */
-int strfpn(char *name)
+static int strfpn(char *name)
 {
 	int i;
 
@@ -57,31 +50,17 @@ int strfpn(char *name)
 	return i;
 }
 
-int runcc(char *tname, char *filename0, char *program)
+static void runcc(char *tname, char *filename0, char *program)
 {
 	static char filename[1024];
-	int fd, es, saved_errno;
+	int es;
 	char *cflags = "";
 
-	fd = mkstemp(filename0);
-	if (fd < 0) {
-		perror("mkstemp");
-		return -1;
-	}
 	strncpy(filename, filename0, sizeof(filename) - 1);
 	filename[sizeof(filename) - 1] = '\0';
 	strncat(filename, ".c", sizeof(filename) - strlen(filename) - 1);
-	if (rename(filename0, filename) < 0) {
-		perror("rename");
-		unlink(filename0);
-		return -1;
-	}
-	if (write(fd, program, strlen(program)) < 0) {
-		perror("write");
-		unlink(filename);
-		return -1;
-	}
-	(void)close(fd);
+
+	SAFE_FILE_PRINTF(NULL, filename, "%s", program);
 
 	cflags = getenv("CFLAGS");
 	if (cflags == NULL) {
@@ -89,19 +68,13 @@ int runcc(char *tname, char *filename0, char *program)
 		cflags = "";
 	}
 
-	snprintf(cmd, sizeof(cmd), "%s %s -o %s %s > /tmp/test 2>&1", "cc",
+	snprintf(cmd, sizeof(cmd), "%s %s -o %s %s > test 2>&1", "cc",
 		 cflags, filename0, filename);
 	es = system(cmd);
 	if (WEXITSTATUS(es) == 127) {
-		tst_resm(TBROK, "can't run C compiler: \"%s\"", cmd);
-		if (unlink(filename) < 0)
-			tst_resm(TWARN, "%s; unlink \"%s\" failed: %s", tname,
-				 filename, strerror(errno));
-		return -1;
+		tst_brkm(TBROK | TERRNO, NULL, "can't run C compiler: \"%s\"",
+			 cmd);
 	}
-	if (unlink(filename) < 0)
-		tst_resm(TWARN, "%s: unlink \"%s\" failed: %s", tname,
-			 filename, strerror(errno));
 
 	if (WIFSIGNALED(es) &&
 	    (WTERMSIG(es) == SIGINT || WTERMSIG(es) == SIGQUIT))
@@ -109,101 +82,91 @@ int runcc(char *tname, char *filename0, char *program)
 
 	if (WEXITSTATUS(es)) {
 		tst_resm(TFAIL, "%s: not present", tname);
-		return -1;
+		return;
 	}
 	/* run the test */
 
 	es = system(filename0);
-	saved_errno = errno;
-	if (unlink(filename0) < 0)
-		tst_resm(TWARN, "%s: unlink \"%s\" failed: %s", tname,
-			 filename0, strerror(errno));
 
 	if (WIFSIGNALED(es) &&
 	    (WTERMSIG(es) == SIGINT || WTERMSIG(es) == SIGQUIT))
 		exit(1);
 
 	if (WEXITSTATUS(es) == 127)
-		tst_resm(TBROK, "%s: can't run \"%s\": %s", tname, filename0,
-			 strerror(saved_errno));
+		tst_resm(TBROK | TERRNO, "%s: can't run \"%s\"", tname,
+			 filename0);
 	if (WEXITSTATUS(es))
 		tst_resm(TFAIL, "%s: present, but incorrect", tname);
 	else
 		tst_resm(TPASS, "%s present and correct", tname);
-	return 0;
 }
 
-char *field_fmt = "\n\texit((offsetof(struct %s, %s) != %s) || "
-    "sizeof(tst.%s) != (%s));\n";
+#define FIELD_FMT	"\n\texit((offsetof(struct %s, %s) != %s) || " \
+			"sizeof(tst.%s) != (%s));\n"
 /* no offset check */
-char *field_fmt2 = "\n\texit(sizeof(tst.%s) != (%s));\n";
+#define FIELD_FMT2	"\n\texit(sizeof(tst.%s) != (%s));\n"
 
-const char *stmpl =
-    "%s\n#ifndef offsetof\n"
-    "#define offsetof(dtype, dfield) ((int)&((dtype *)0)->dfield)\n"
-    "#endif\n\nstruct %s tst;\n\nmain(int argc, char *argv[])\n{\n\t%s\n}\n";
+#define STMPL	"%s#include <stdlib.h>\n\n\n" \
+		"#ifndef offsetof\n" \
+		"#define offsetof(dtype, dfield) " \
+		"((int)&((dtype *)0)->dfield)\n" \
+		"#endif\n\nstruct %s tst;\n\n" \
+		"int main(int argc, char *argv[])\n{\n\t%s\n}\n"
 
-int
-structcheck(char *tname, char *incl, char *structure, char *field,
-	    char *offset, char *size)
+void structcheck(char *tname, char *incl, char *structure, char *field,
+		 char *offset, char *size)
 {
-	int rv;
 	static char filename[1024];
 
 	if (offset)
-		sprintf(fieldref, field_fmt, structure, field, offset, field,
+		sprintf(fieldref, FIELD_FMT, structure, field, offset, field,
 			size);
 	else
-		sprintf(fieldref, field_fmt2, field, size);
-	sprintf(program, stmpl, incl, structure, fieldref);
-	snprintf(filename, sizeof(filename), filetmpl, strfpn(structure),
+		sprintf(fieldref, FIELD_FMT2, field, size);
+	sprintf(program, STMPL, incl, structure, fieldref);
+	snprintf(filename, sizeof(filename), FILETMPL, strfpn(structure),
 		 structure);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
 
-char *aliasfmt =
-    "exit(&tst.%s != &tst.%s || sizeof(tst.%s) != sizeof(tst.%s));";
+#define ALIASFMT	"exit(&tst.%s != &tst.%s || " \
+			"sizeof(tst.%s) != sizeof(tst.%s));"
 
-int
-aliascheck(char *tname, char *incl, char *structure, char *field, char *dname)
+void aliascheck(char *tname, char *incl, char *structure, char *field,
+		char *dname)
 {
-	int rv;
 	static char filename[1024];
 
-	sprintf(fieldref, aliasfmt, field, dname, field, dname);
-	sprintf(program, stmpl, incl, structure, fieldref);
-	snprintf(filename, sizeof(filename), filetmpl, strfpn(structure),
+	sprintf(fieldref, ALIASFMT, field, dname, field, dname);
+	sprintf(program, STMPL, incl, structure, fieldref);
+	snprintf(filename, sizeof(filename), FILETMPL, strfpn(structure),
 		 structure);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
 
-const char *dtmpl =
-    "%s\n\nmain(int argc, char *argv[])\n{\n\texit((%s) != (%s));\n}\n";
+#define DTMPL	"%s#include <stdlib.h>\n\n\n" \
+		"int main(int argc, char *argv[])\n" \
+		"{\n\texit((%s) != (%s));\n}\n"
 
-int valuecheck(char *tname, char *incl, char *dname, char *dval)
+void valuecheck(char *tname, char *incl, char *dname, char *dval)
 {
-	int rv;
 	static char filename[1024];
 
-	sprintf(program, dtmpl, incl, dname, dval);
-	snprintf(filename, sizeof(filename), filetmpl, strfpn(dname), dname);
-	rv = runcc(tname, filename, program);
-	return rv;
+	sprintf(program, DTMPL, incl, dname, dval);
+	snprintf(filename, sizeof(filename), FILETMPL, strfpn(dname), dname);
+	runcc(tname, filename, program);
 }
 
-const char *ftmpl =
-    "%s\n\nmain(int argc, char *argv[])\n{\n#ifdef %s\n\texit(0);\n#else\n"
-    "\tsyntax error;\n#endif\n}\n";
+#define FTMPL	"%s#include <stdlib.h>\n\n\n" \
+		"int main(int argc, char *argv[])\n" \
+		"{\n#ifdef %s\n\texit(0);\n#else\n" \
+		"\tsyntax error;\n#endif\n}\n"
 
-int funccheck(char *tname, char *incl, char *fname)
+void funccheck(char *tname, char *incl, char *fname)
 {
-	int rv;
 	static char filename[1024];
 
-	sprintf(program, ftmpl, incl, fname);
-	snprintf(filename, sizeof(filename), filetmpl, strfpn(fname), fname);
-	rv = runcc(tname, filename, program);
-	return rv;
+	sprintf(program, FTMPL, incl, fname);
+	snprintf(filename, sizeof(filename), FILETMPL, strfpn(fname), fname);
+	runcc(tname, filename, program);
 }
diff --git a/testcases/network/lib6/runcc.h b/testcases/network/lib6/runcc.h
index 4e2a0d5..a66addb 100644
--- a/testcases/network/lib6/runcc.h
+++ b/testcases/network/lib6/runcc.h
@@ -1,30 +1,38 @@
 /*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-int aliascheck(char *tname, char *incl, char *structure, char *field,
-	char *dname);
-int funccheck(char *tname, char *incl, char *fname);
-int structcheck(char *tname, char *incl, char *structure, char *field,
-	char *offset, char *size);
-int valuecheck(char *tname, char *incl, char *dname, char *dval);
+#ifndef __RUNCC_H__
+#define __RUNCC_H__
 
-#define IP6_H "#include <netinet/ip6.h>\n"
-#define IN_H "#include <netinet/in.h>\n"
-#define ICMP6_H "#include <netinet/icmp6.h>\n"
-#define SOCKET_H "#include <sys/types.h>\n#include <sys/socket.h>\n"
+void aliascheck(char *tname, char *incl, char *structure, char *field,
+		char *dname);
+
+void funccheck(char *tname, char *incl, char *fname);
+
+void structcheck(char *tname, char *incl, char *structure, char *field,
+		 char *offset, char *size);
+
+void valuecheck(char *tname, char *incl, char *dname, char *dval);
+
+#define IP6_H		"#include <netinet/ip6.h>\n"
+#define IN_H		"#include <netinet/in.h>\n"
+#define ICMP6_H		"#include <netinet/icmp6.h>\n"
+#define SOCKET_H	"#include <sys/types.h>\n#include <sys/socket.h>\n"
+
+#endif  /* __RUNCC_H__ */
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
