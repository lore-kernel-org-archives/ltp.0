From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun,  7 Jul 2019 21:00:14 +0200
Subject: [LTP] [PATCH 3/5] setdomainname01: Convert to new API
In-Reply-To: <20190707190016.27296-1-petr.vorel@gmail.com>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
Message-ID: <20190707190016.27296-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Functional changes: verify result of setdomainname() with
getdomainname().

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../syscalls/setdomainname/setdomainname.h    |  58 +++++++
 .../syscalls/setdomainname/setdomainname01.c  | 162 +++---------------
 2 files changed, 82 insertions(+), 138 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setdomainname/setdomainname.h

diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname.h b/testcases/kernel/syscalls/setdomainname/setdomainname.h
new file mode 100644
index 000000000..76a72df22
--- /dev/null
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+ */
+
+#ifndef SETDOMAINNAME_H__
+#define SETDOMAINNAME_H__
+
+#include <string.h>
+#include "lapi/utsname.h"
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#define TST_VALID_DOMAIN_NAME "test_dom"
+
+static char backup[_UTSNAME_DOMAIN_LENGTH];
+
+#define TEST_VARIANTS 2
+
+static void setdomainname_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing libc setdomainname()");
+		break;
+	case 1:
+		tst_res(TINFO, "Testing __NR_setdomainname syscall");
+		break;
+	}
+}
+
+static int do_setdomainname(char *new, size_t len)
+{
+	switch (tst_variant) {
+	case 0:
+		return setdomainname(new, len);
+	break;
+	case 1:
+		return tst_syscall(__NR_setdomainname, new, len);
+	}
+
+	return -1;
+}
+
+static void setup(void)
+{
+	setdomainname_info();
+	if ((getdomainname(backup, sizeof(backup))) < 0)
+		tst_brk(TBROK | TERRNO, "getdomainname() failed");
+}
+
+static void cleanup(void)
+{
+	if ((setdomainname(backup, strlen(backup))) < 0)
+		tst_res(TWARN | TERRNO, "setdomainname() failed ('%s')", backup);
+}
+
+#endif /* SETDOMAINNAME_H__ */
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 7288fca5c..57d58ab42 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -1,149 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright (c) Wipro Technologies Ltd, 2002. All Rights Reserved.
+ * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+ * Author: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: setdomainname01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for setdomainame(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the setdomainname(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  Save the current domainname.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- *	  Restore old domain name.
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  setdomainname01  [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
- ****************************************************************/
 
-#include <errno.h>
-#include <string.h>
-#include <sys/utsname.h>
-#include "test.h"
+#include "setdomainname.h"
 
-#define MAX_NAME_LEN _UTSNAME_DOMAIN_LENGTH
-
-static void setup();
-static void cleanup();
-
-char *TCID = "setdomainname01";
-int TST_TOTAL = 1;
-
-static char *test_domain_name = "test_dom";
-static char old_domain_name[MAX_NAME_LEN];
-
-int main(int ac, char **av)
+static void do_test(void)
 {
+	char *new = TST_VALID_DOMAIN_NAME;
+	static char tmp[_UTSNAME_DOMAIN_LENGTH];
 
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TEST(do_setdomainname(new, sizeof(new)));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	if (TST_RET != 0)
+		tst_brk(TFAIL | TTERRNO, "setdomainname() failed: %d", TST_ERR);
 
-		tst_count = 0;
-
-		/*
-		 * Call setdomainname(2)
-		 */
-		TEST(setdomainname(test_domain_name, sizeof(test_domain_name)));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "setdomainname() Failed, errno = %d :"
-				 " %s", TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "setdomainname() returned %ld, "
-				 "Domain name set to \"%s\"", TEST_RETURN,
-				 test_domain_name);
-		}
-
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
+	if (getdomainname(tmp, sizeof(tmp)) != 0)
+		tst_brk(TFAIL | TERRNO, "getdomainname() failed");
 
+	if (strcmp(tmp, new))
+		tst_res(TFAIL, "getdomainname() returned wrong domainname: '%s'", tmp);
+	else
+		tst_res(TPASS, "setdomainname() succeed");
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Save current domain name */
-	if ((getdomainname(old_domain_name, sizeof(old_domain_name))) < 0) {
-		tst_brkm(TBROK, NULL, "getdomainname() failed while"
-			 " getting current domain name");
-	}
-
-	TEST_PAUSE;
-
-}
-
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/* Restore domain name */
-	if ((setdomainname(old_domain_name, strlen(old_domain_name))) < 0) {
-		tst_resm(TWARN, "setdomainname() failed while restoring"
-			 " domainname to \"%s\"", old_domain_name);
-	}
-
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+	.test_variants = TEST_VARIANTS,
+};
-- 
2.20.1

