From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 11:28:04 +0200
Subject: [LTP] [RFC PATCH 3/8] controllers: Fix linking with -fno-common
In-Reply-To: <20200415092809.20240-1-pvorel@suse.cz>
References: <20200415092809.20240-1-pvorel@suse.cz>
Message-ID: <20200415092809.20240-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by moving definitions to libcontrollers.c and adding extern declarations
to libcontrollers.h.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../controllers/cpuctl/cpuctl_def_task01.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task02.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task03.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task04.c    |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test01.c |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test02.c |  1 -
 .../kernel/controllers/cpuctl/cpuctl_test03.c |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test04.c |  2 --
 .../libcontrollers/libcontrollers.c           | 11 ++++++++
 .../libcontrollers/libcontrollers.h           | 28 +++++++------------
 10 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 90119e4ad..578c60c89 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -81,8 +81,6 @@ extern void cleanup(void)
 	/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index dc1546e88..658c6fd3f 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -76,8 +76,6 @@ extern void cleanup(void)
 	/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index 92b451793..a700ca515 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -76,8 +76,6 @@ extern void cleanup(void)
 	/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 108e576e1..1726f810d 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -76,8 +76,6 @@ extern void cleanup(void)
 	/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index d7be1c80c..8f6d11de0 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -79,8 +79,6 @@ extern void cleanup(void)
 	tst_exit();		/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index 2a5cd4a11..52ad8aa2f 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -78,7 +78,6 @@ extern void cleanup(void)
 }
 
 int migrate_task();
-volatile int timer_expired = 0;
 
 int main(void)
 {
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index 8a80d6932..0e0a26dc3 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -76,8 +76,6 @@ extern void cleanup(void)
 	tst_exit();		/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index 791a58dd2..dae0d4c05 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -77,8 +77,6 @@ extern void cleanup(void)
 	tst_exit();		/* Report exit status */
 }
 
-volatile int timer_expired = 0;
-
 int main(int argc, char *argv[])
 {
 
diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
index 75766fc19..e9917271c 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
@@ -35,6 +35,17 @@
 
 #include "libcontrollers.h"
 
+char fullpath[PATH_MAX];
+int FLAG;
+volatile int timer_expired = 0;
+int retval;
+unsigned int num_line;
+unsigned int current_shares;
+unsigned int total_shares;
+unsigned int *shares_pointer;
+char target[LINE_MAX];
+struct dirent *dir_pointer;
+
 /*
  * Function: scan_shares_file()
  * This function scans all the shares files under the mountpoint
diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
index f999f705e..7d7b8324b 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
@@ -42,24 +42,16 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-char fullpath[PATH_MAX];
-
-int FLAG;
-volatile int timer_expired;
-
-int retval;
-
-unsigned int num_line;//??
-
-unsigned int current_shares;
-
-unsigned int total_shares;
-
-unsigned int *shares_pointer;//??
-
-char target[LINE_MAX];
-
-struct dirent 	*dir_pointer;
+extern char fullpath[PATH_MAX];
+extern int FLAG;
+extern volatile int timer_expired;
+extern int retval;
+extern unsigned int num_line;
+extern unsigned int current_shares;
+extern unsigned int total_shares;
+extern unsigned int *shares_pointer;
+extern char target[LINE_MAX];
+extern struct dirent *dir_pointer;
 
 enum{
 	GET_SHARES	=1,
-- 
2.26.0

