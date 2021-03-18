From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 18 Mar 2021 14:08:34 +0800
Subject: [LTP] [PATCH] kernel/syscalls: Use SAFE_OPEN() instead of calling
 system API functions
Message-ID: <20210318060834.151128-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
  testcases/kernel/syscalls/fsconfig/fsconfig02.c
  testcases/kernel/syscalls/inotify/inotify01.c
  testcases/kernel/syscalls/memfd_create/memfd_create03.c

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fsconfig/fsconfig02.c        |  4 +---
 testcases/kernel/syscalls/inotify/inotify01.c          | 10 ++--------
 .../kernel/syscalls/memfd_create/memfd_create03.c      |  4 ++--
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
index 9ff41a7d7..6ff4380ef 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
@@ -55,9 +55,7 @@ static void setup(void)
 	if (fd == -1)
 		tst_brk(TBROK | TTERRNO, "fsopen() failed");

-	temp_fd = open("testfile", O_RDWR | O_CREAT, 01444);
-	if (temp_fd == -1)
-		tst_brk(TBROK, "Can't obtain temp_fd, open() failed");
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 01444);
 }

 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 8f1547d46..2d82e5970 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -52,10 +52,7 @@ void verify_inotify(void)
 	event_set[test_cnt] = IN_ATTRIB;
 	test_cnt++;

-	if ((fd = open(fname, O_RDONLY)) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	}
+	fd = SAFE_OPEN(fname, O_RDONLY);
 	event_set[test_cnt] = IN_OPEN;
 	test_cnt++;

@@ -70,10 +67,7 @@ void verify_inotify(void)
 	event_set[test_cnt] = IN_CLOSE_NOWRITE;
 	test_cnt++;

-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brk(TBROK,
-			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	}
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 	event_set[test_cnt] = IN_OPEN;
 	test_cnt++;

diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
index ea846626a..036182f0a 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create03.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -207,7 +207,7 @@ static void setup(void)
 	SAFE_FILE_LINES_SCANF(TOTAL_HP_PATH, "%ld", &og_total_pages);
 	sprintf(buf, "%ld", og_total_pages + 1);

-	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+	fd = SAFE_OPEN(TOTAL_HP_PATH, O_RDWR | O_TRUNC);

 	if (write(fd, buf, strlen(buf)) == -1)
 		tst_brk(TCONF | TERRNO,
@@ -233,7 +233,7 @@ static void cleanup(void)

 	sprintf(buf, "%ld", og_total_pages);

-	fd = open(TOTAL_HP_PATH, O_RDWR | O_TRUNC);
+	fd = SAFE_OPEN(TOTAL_HP_PATH, O_RDWR | O_TRUNC);

 	if (write(fd, buf, strlen(buf)) == -1)
 		tst_brk(TCONF | TERRNO, "Clean-up failed: write() failed");
--
2.17.1

