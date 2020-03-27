From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:19 +0100
Subject: [LTP] [PATCH 1/6] lib: Implement .needs_cmds
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <20200327213924.18816-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit.

 doc/test-writing-guidelines.txt | 15 +++++++++++++++
 include/tst_test.h              |  3 +++
 lib/tst_test.c                  | 11 +++++++++++
 3 files changed, 29 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 32c9e87df..f7206f1bf 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2023,6 +2023,21 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.35 Checking for required binaries
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Required binaries can be checked with '.needs_cmds', which points to a 'NULL'
+terminated array of strings such as:
+
+[source,c]
+-------------------------------------------------------------------------------
+.needs_cmds = (const char *const []) {
+	"useradd",
+	"userdel",
+	NULL
+},
+-------------------------------------------------------------------------------
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_test.h b/include/tst_test.h
index 84b6a940f..592097084 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -239,6 +239,9 @@ struct tst_test {
 	 * {NULL, NULL} terminated array of tags.
 	 */
 	const struct tst_tag *tags;
+
+	/* NULL terminated array of required binaries */
+	const char *const *needs_cmds;
 };
 
 /*
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 220d7fdfc..dae3fa1b5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
  */
 
+#include <limits.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <unistd.h>
@@ -880,6 +881,16 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->needs_cmds) {
+		const char *cmd;
+		char path[PATH_MAX];
+		int i;
+
+		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
+			if (tst_get_path(cmd, path, sizeof(path)))
+				tst_brk(TCONF, "Couldn't find '%s' in $PATH", cmd);
+	}
+
 	if (tst_test->needs_drivers) {
 		const char *name;
 		int i;
-- 
2.25.1

