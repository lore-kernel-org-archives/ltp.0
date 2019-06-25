From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Jun 2019 11:02:39 +0200
Subject: [LTP] [PATCH] lib: make save_restore '?' prefix ignore also errors
 from open/read
Message-ID: <64e3837429239829860f1df5d8145c12078a799f.1561451809.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Prefix '?' was meant to silently ignore non-existing paths.
However there are some /proc files which exist, but trigger
error only after open/read:
  # ls -la /proc/sys/vm/nr_hugepages
  -rw-r--r--. 1 root root 0 Jun 25 04:17 /proc/sys/vm/nr_hugepages
  # cat /proc/sys/vm/nr_hugepages
  cat: /proc/sys/vm/nr_hugepages: Operation not supported

This leads to unavoidable TBROK. Extend '?' flag to cover also open/read.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 doc/test-writing-guidelines.txt | 9 +++++----
 lib/tst_sys_conf.c              | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c6d4e001d72b..d0b7417f2cc8 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1515,10 +1515,11 @@ and restored at the end of the test. Only first line of a specified
 file is saved and restored.
 
 Pathnames can be optionally prefixed to specify how strictly (during
-'store') are handled files that don't exist:
-  (no prefix) - test ends with TCONF
-  '?'         - test prints info message and continues
-  '!'         - test ends with TBROK
+'store') are handled errors:
+  (no prefix) - test ends with TCONF, if file doesn't exist
+  '?'         - test prints info message and continues,
+                if file doesn't exist or open/read fails
+  '!'         - test ends with TBROK, if file doesn't exist
 
 'restore' is always strict and will TWARN if it encounters any error.
 
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index e767856ec148..bbe469936c99 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -66,6 +66,9 @@ int tst_sys_conf_save(const char *path)
 
 	fp = fopen(path, "r");
 	if (fp == NULL) {
+		if (flag == '?')
+			return 1;
+
 		tst_brk(TBROK | TERRNO, "Failed to open FILE '%s' for reading",
 			path);
 		return 1;
@@ -75,6 +78,9 @@ int tst_sys_conf_save(const char *path)
 	fclose(fp);
 
 	if (ret == NULL) {
+		if (flag == '?')
+			return 1;
+
 		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
 			path);
 	}
-- 
1.8.3.1

