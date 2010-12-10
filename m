Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PR5DT-0002DS-El
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 15:49:03 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 1967889994
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Dec 2010 16:48:54 +0100 (CET)
Date: Fri, 10 Dec 2010 17:02:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101210160243.GB19747@saboteur.suse.cz>
References: <20101206194946.GA12546@saboteur.suse.cz>
	<20101206195315.GA13847@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20101206195315.GA13847@saboteur.suse.cz>
Content-Transfer-Encoding: 7bit
Subject: [LTP] [PATCH] open posix testsuite fork 7-1.c
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
To: ltp-list@lists.sourceforge.net


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Here comes patch that removes messcat_src.txt. Instead of trying to find
it the test now creates it on the fly. Also the code is cleaned up a
little.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--Dxnq1zWXvFF0Q93v
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename="fork_7_1.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7=
-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index c98e37b..50a23a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -21,7 +21,7 @@
=20
=20
 * The steps are:
-* -> Create a message catalog file from the "messcat_src.txt" file
+* -> Create a message catalog file from the file
 * -> Open this catalog
 * -> fork
 * -> Check that the child can read from the message catalog.=20
@@ -34,186 +34,132 @@
 /* We are testing conformance to IEEE Std 1003.1, 2003 Edition */
 #define _POSIX_C_SOURCE 200112L
=20
-/***********************************************************************=
*********************/
-/****************************** standard includes **********************=
*******************/
-/***********************************************************************=
*********************/
 #include <pthread.h>
- #include <stdarg.h>
- #include <stdio.h>
- #include <stdlib.h>
- #include <string.h>
- #include <unistd.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
=20
 #include <sys/wait.h>
- #include <errno.h>
+#include <errno.h>
=20
 #include <nl_types.h>
=20
-/***********************************************************************=
*********************/
-/******************************   Test framework   *********************=
********************/
-/***********************************************************************=
*********************/
 #include "testfrmw.h"
- #include "testfrmw.c"=20
-/* This header is responsible for defining the following macros:
- * UNRESOLVED(ret, descr); =20
- *    where descr is a description of the error and ret is an int (error=
 code for example)
- * FAILED(descr);
- *    where descr is a short text saying why the test has failed.
- * PASSED();
- *    No parameter.
- *=20
- * Both three macros shall terminate the calling process.
- * The testcase shall not terminate in any other maneer.
- *=20
- * The other file defines the functions
- * void output_init()
- * void output(char * string, ...)
- *=20
- * Those may be used to output information.
- */
-
-/***********************************************************************=
*********************/
-/********************************** Configuration **********************=
********************/
-/***********************************************************************=
*********************/
+#include "testfrmw.c"=20
+
 #ifndef VERBOSE
 #define VERBOSE 1
 #endif
=20
-#define PATH_OFFSET "conformance/interfaces/fork/"
-
-/***********************************************************************=
*********************/
-/***********************************    Test case   ********************=
*********************/
-/***********************************************************************=
*********************/
+#define MESSCAT_IN  "messcat.txt"
+#define MESSCAT_OUT "messcat.cat"
=20
-void read_catalog(nl_catd cat, char * who)
+void read_catalog(nl_catd cat, char *who)
 {
-	char * msg =3D NULL;
+	char *msg =3D NULL;
 	int i, j;
 	errno =3D 0;
=20
 #if VERBOSE > 0
-
 	output("Reading the message catalog from %s...\n", who);
 #endif
=20
-	for (i =3D 1; i <=3D 2; i++)
-	{
-		for (j =3D 1; j <=3D 2; j++)
-		{
+	for (i =3D 1; i <=3D 2; i++) {
+		for (j =3D 1; j <=3D 2; j++) {
+
 			msg =3D catgets(cat, i, j, "not found");
=20
 			if (errno !=3D 0)
-			{
 				UNRESOLVED(errno, "catgets returned an error");
-			}
-
 #if VERBOSE > 1
 			output("set %i msg %i: %s\n", i, j, msg);
-
 #endif
-
 		}
 	}
=20
 #if VERBOSE > 0
 	output("Message catalog read successfully in %s\n", who);
-
 #endif
 }
=20
-/* The main test function. */
+static char *messcat_in =3D=20
+"$set 1\n1 First sentence\n2 Second sentence\n"
+"$set 2\n1 First translated sentence\n2 Second translated sentence\n";
+
+static int create_catalog(void)
+{
+	FILE *f =3D fopen(MESSCAT_IN, "w");
+
+	if (f =3D=3D NULL)
+		return 1;
+
+	if (fputs(messcat_in, f) <=3D 0)
+		return 1;
+
+	if (fclose(f))
+		return 1;
+
+	return 0;
+}
+
 int main(int argc, char * argv[])
 {
 	int ret, status;
 	pid_t child, ctl;
-
 	nl_catd messcat;
=20
-	/* Initialize output */
 	output_init();
=20
-
 	/* Generate the message catalog file from the text sourcefile */
+	if (system(NULL)) {
+	=09
+		if (create_catalog() !=3D 0) {
+			UNRESOLVED(errno, "Can't create "MESSCAT_IN);
+		}
=20
-	if (system(NULL))
-	{
-		ret =3D system("gencat mess.cat " PATH_OFFSET "messcat_src.txt");
+		ret =3D system("gencat "MESSCAT_OUT" "MESSCAT_IN);
=20
 		if (ret !=3D 0)
-		{
-			output("Unable to find messcat_src.txt in standard directory %s\n", P=
ATH_OFFSET);
-			output("Trying local dir\n");
-			ret =3D system("gencat mess.cat messcat_src.txt");
-
-			if (ret !=3D 0)
-			{
-				output("Could not find the source file for message catalog.\n" \
-				        "You may need to execute gencat yourself.\n");
-			}
-		}
+			output("Could not find the source file for message catalog.\n" \
+			        "You may need to execute gencat yourself.\n");
 	}
=20
-	/* Try opening the message catalog file */
-	messcat =3D catopen("./mess.cat", 0);
+	messcat =3D catopen("./"MESSCAT_OUT, 0);
=20
 	if (messcat =3D=3D (nl_catd) -1)
-	{
-		UNRESOLVED(errno, "Could not open ./mess.cat. You may need to do a gen=
cat before executing this testcase");
-	}
+		UNRESOLVED(errno, "Could not open ./"MESSCAT_OUT);
=20
-	/* Read the message catalog */
 	read_catalog(messcat, "parent");
=20
-
-	/* Create the child */
 	child =3D fork();
=20
 	if (child =3D=3D -1)
-	{
 		UNRESOLVED(errno, "Failed to fork");
-	}
=20
-	/* child */
-	if (child =3D=3D 0)
-	{
+	if (child =3D=3D 0) {
 		read_catalog(messcat, "child");
-
-		/* We're done */
 		exit(PTS_PASS);
 	}
=20
-	/* Parent joins the child */
 	ctl =3D waitpid(child, &status, 0);
=20
 	if (ctl !=3D child)
-	{
 		UNRESOLVED(errno, "Waitpid returned the wrong PID");
-	}
=20
 	if ((!WIFEXITED(status)) || (WEXITSTATUS(status) !=3D PTS_PASS))
-	{
 		FAILED("Child exited abnormally");
-	}
=20
-	/* We can now clean up the message catalog file */
 	ret =3D catclose(messcat);
=20
 	if (ret !=3D 0)
-	{
 		UNRESOLVED(errno, "Failed to close the message catalog");
-	}
=20
-	/* Try removing the message catalog file */
-	system("rm -f mess.cat");
+	system("rm -f "MESSCAT_IN" "MESSCAT_OUT);
=20
-	/* Test passed */
 #if VERBOSE > 0
-
 	output("Test passed\n");
-
 #endif
-
 	PASSED;
 }
-
-
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/m=
esscat_src.txt b/testcases/open_posix_testsuite/conformance/interfaces/fo=
rk/messcat_src.txt
deleted file mode 100644
index e0067d9..0000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/messcat_=
src.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-$ Copyright (c) 2004, Bull S.A..  All rights reserved.
-$ Created by: Sebastien Decugis
-$ =20
-$ This program is free software; you can redistribute it and/or modify i=
t
-$ under the terms of version 2 of the GNU General Public License as
-$ published by the Free Software Foundation.
-$=20
-$ This program is distributed in the hope that it would be useful, but
-$ WITHOUT ANY WARRANTY; without even the implied warranty of
-$ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-$=20
-$ You should have received a copy of the GNU General Public License alon=
g
-$ with this program; if not, write the Free Software Foundation, Inc., 5=
9
-$ Temple Place - Suite 330, Boston MA 02111-1307, USA.
-$=20
-$=20
-$ This file is part of the 7-1.c test case for the fork() routine.
-
-$set 1 Message set for OPTS fork test case, English language
-1 This is the first message
-2 And this is the second
-
-$set 2 Message set for OPTS fork test case, French language
-1 Voici le premier message
-2 Et voil=C4=82=C2=A0 le second
-

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Dxnq1zWXvFF0Q93v--

