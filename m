Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z4qV2-0007ve-AQ
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:56 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z4qUz-0003pS-EB
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:56 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 16 Jun 2015 20:24:34 +0800
Message-ID: <1434457479-20493-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <5572ED1E.1020203@oracle.com>
	<1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/7] lib6/runcc.c: Cleanup
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

* Change 'aliascheck', 'funccheck', 'structcheck' and 'valuecheck' to
  non-return because of the ignore return value.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/runcc.c | 106 +++++++++++++++++------------------------
 testcases/network/lib6/runcc.h |  33 ++++++++-----
 2 files changed, 64 insertions(+), 75 deletions(-)

diff --git a/testcases/network/lib6/runcc.c b/testcases/network/lib6/runcc.c
index 91a0b16..0057cc5 100644
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
@@ -37,17 +27,17 @@
 
 #include "test.h"
 
-char fieldref[1024];
-char program[8192];
+static char fieldref[1024];
+static char program[8192];
 
-char *filetmpl = "/tmp/%.*s_XXXXXX";
+static const char *filetmpl = "/tmp/%.*s_XXXXXX";
 
-char cmd[1024];
+static char cmd[1024];
 
 /*
  * like strspn, with ASCII, numbers and underscore only
  */
-int strfpn(char *name)
+static int strfpn(char *name)
 {
 	int i;
 
@@ -57,7 +47,7 @@ int strfpn(char *name)
 	return i;
 }
 
-int runcc(char *tname, char *filename0, char *program)
+static int runcc(char *tname, char *filename0, char *program)
 {
 	static char filename[1024];
 	int fd, es, saved_errno;
@@ -133,21 +123,20 @@ int runcc(char *tname, char *filename0, char *program)
 	return 0;
 }
 
-char *field_fmt = "\n\texit((offsetof(struct %s, %s) != %s) || "
-    "sizeof(tst.%s) != (%s));\n";
+static const char *field_fmt = "\n\texit((offsetof(struct %s, %s) != %s) || "
+			       "sizeof(tst.%s) != (%s));\n";
 /* no offset check */
-char *field_fmt2 = "\n\texit(sizeof(tst.%s) != (%s));\n";
+static const char *field_fmt2 = "\n\texit(sizeof(tst.%s) != (%s));\n";
 
-const char *stmpl =
-    "%s\n#ifndef offsetof\n"
-    "#define offsetof(dtype, dfield) ((int)&((dtype *)0)->dfield)\n"
-    "#endif\n\nstruct %s tst;\n\nmain(int argc, char *argv[])\n{\n\t%s\n}\n";
+static const char *stmpl = "%s\n#ifndef offsetof\n"
+			   "#define offsetof(dtype, dfield) "
+			   "((int)&((dtype *)0)->dfield)\n"
+			   "#endif\n\nstruct %s tst;\n\n"
+			   "main(int argc, char *argv[])\n{\n\t%s\n}\n";
 
-int
-structcheck(char *tname, char *incl, char *structure, char *field,
-	    char *offset, char *size)
+void structcheck(char *tname, char *incl, char *structure, char *field,
+		 char *offset, char *size)
 {
-	int rv;
 	static char filename[1024];
 
 	if (offset)
@@ -158,52 +147,45 @@ structcheck(char *tname, char *incl, char *structure, char *field,
 	sprintf(program, stmpl, incl, structure, fieldref);
 	snprintf(filename, sizeof(filename), filetmpl, strfpn(structure),
 		 structure);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
 
-char *aliasfmt =
-    "exit(&tst.%s != &tst.%s || sizeof(tst.%s) != sizeof(tst.%s));";
+static const char *aliasfmt = "exit(&tst.%s != &tst.%s || "
+			      "sizeof(tst.%s) != sizeof(tst.%s));";
 
-int
-aliascheck(char *tname, char *incl, char *structure, char *field, char *dname)
+void aliascheck(char *tname, char *incl, char *structure, char *field,
+		char *dname)
 {
-	int rv;
 	static char filename[1024];
 
 	sprintf(fieldref, aliasfmt, field, dname, field, dname);
 	sprintf(program, stmpl, incl, structure, fieldref);
 	snprintf(filename, sizeof(filename), filetmpl, strfpn(structure),
 		 structure);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
 
-const char *dtmpl =
-    "%s\n\nmain(int argc, char *argv[])\n{\n\texit((%s) != (%s));\n}\n";
+static const char *dtmpl = "%s\n\nmain(int argc, char *argv[])\n"
+			   "{\n\texit((%s) != (%s));\n}\n";
 
-int valuecheck(char *tname, char *incl, char *dname, char *dval)
+void valuecheck(char *tname, char *incl, char *dname, char *dval)
 {
-	int rv;
 	static char filename[1024];
 
 	sprintf(program, dtmpl, incl, dname, dval);
 	snprintf(filename, sizeof(filename), filetmpl, strfpn(dname), dname);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
 
-const char *ftmpl =
-    "%s\n\nmain(int argc, char *argv[])\n{\n#ifdef %s\n\texit(0);\n#else\n"
-    "\tsyntax error;\n#endif\n}\n";
+static const char *ftmpl = "%s\n\nmain(int argc, char *argv[])\n"
+			   "{\n#ifdef %s\n\texit(0);\n#else\n"
+			   "\tsyntax error;\n#endif\n}\n";
 
-int funccheck(char *tname, char *incl, char *fname)
+void funccheck(char *tname, char *incl, char *fname)
 {
-	int rv;
 	static char filename[1024];
 
 	sprintf(program, ftmpl, incl, fname);
 	snprintf(filename, sizeof(filename), filetmpl, strfpn(fname), fname);
-	rv = runcc(tname, filename, program);
-	return rv;
+	runcc(tname, filename, program);
 }
diff --git a/testcases/network/lib6/runcc.h b/testcases/network/lib6/runcc.h
index 4e2a0d5..0e9228b 100644
--- a/testcases/network/lib6/runcc.h
+++ b/testcases/network/lib6/runcc.h
@@ -1,5 +1,4 @@
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
  *
  *   This program is free software;  you can redistribute it and/or modify
@@ -13,18 +12,26 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-int aliascheck(char *tname, char *incl, char *structure, char *field,
-	char *dname);
-int funccheck(char *tname, char *incl, char *fname);
-int structcheck(char *tname, char *incl, char *structure, char *field,
-	char *offset, char *size);
-int valuecheck(char *tname, char *incl, char *dname, char *dval);
+#ifndef __RUNCC_H__
+#define __RUNCC_H__
+
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
 
-#define IP6_H "#include <netinet/ip6.h>\n"
-#define IN_H "#include <netinet/in.h>\n"
-#define ICMP6_H "#include <netinet/icmp6.h>\n"
-#define SOCKET_H "#include <sys/types.h>\n#include <sys/socket.h>\n"
+#endif  /* __RUNCC_H__ */
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
