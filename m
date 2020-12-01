From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:11 +0100
Subject: [LTP] [PATCH v5 07/10] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and safe_fanotify_mark() function and use it in all tests which use
fanotify_mark().

Simple checking in safe_fanotify_mark() was possible due helpers added
in previous commits which are used in tests' setup functions.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* Less cleanup here, because many TCONF messages were removed earlier.

 testcases/kernel/syscalls/fanotify/fanotify.h | 23 +++++++++
 .../kernel/syscalls/fanotify/fanotify01.c     | 48 ++++---------------
 .../kernel/syscalls/fanotify/fanotify02.c     | 22 ++-------
 .../kernel/syscalls/fanotify/fanotify03.c     | 10 +---
 .../kernel/syscalls/fanotify/fanotify04.c     | 32 +++----------
 .../kernel/syscalls/fanotify/fanotify05.c     |  9 +---
 .../kernel/syscalls/fanotify/fanotify06.c     | 21 ++------
 .../kernel/syscalls/fanotify/fanotify07.c     |  9 +---
 .../kernel/syscalls/fanotify/fanotify09.c     | 19 ++------
 .../kernel/syscalls/fanotify/fanotify10.c     | 22 ++-------
 .../kernel/syscalls/fanotify/fanotify11.c     |  5 +-
 .../kernel/syscalls/fanotify/fanotify12.c     | 24 ++--------
 .../kernel/syscalls/fanotify/fanotify13.c     | 18 ++-----
 .../kernel/syscalls/fanotify/fanotify15.c     | 20 ++------
 .../kernel/syscalls/fanotify/fanotify16.c     | 20 ++------
 15 files changed, 77 insertions(+), 225 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 2275a1da3..e0504ba81 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -61,6 +61,29 @@ int safe_fanotify_init(const char *file, const int lineno,
 	return rval;
 }
 
+static inline int safe_fanotify_mark(const char *file, const int lineno,
+			int fd, unsigned int flags, uint64_t mask,
+			int dfd, const char *pathname)
+{
+	int rval;
+
+	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "fanotify_mark() failed");
+	}
+
+	if (rval < -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "invalid fanotify_mark() return %d", rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_FANOTIFY_MARK(fd, flags, mask, dfd, pathname)  \
+	safe_fanotify_mark(__FILE__, __LINE__, (fd), (flags), (mask), (dfd), (pathname))
+
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
 	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index c8ab41695..a1eafb277 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -102,14 +102,8 @@ static void test_fanotify(unsigned int n)
 
 	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags, O_RDONLY);
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
-			  AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
-			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			"failed", fd_notify, mark->name, fname);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname);
 
 	/*
 	 * generate sequence of events
@@ -157,14 +151,9 @@ static void test_fanotify(unsigned int n)
 	 */
 
 	/* Ignore access events */
-	if (fanotify_mark(fd_notify,
+	SAFE_FANOTIFY_MARK(fd_notify,
 			  FAN_MARK_ADD | mark->flag | FAN_MARK_IGNORED_MASK,
-			  FAN_ACCESS, AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
-			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, AT_FDCWD, %s) "
-			"failed", fd_notify, mark->name, fname);
-	}
+			  FAN_ACCESS, AT_FDCWD, fname);
 
 	fd = SAFE_OPEN(fname, O_RDWR);
 	event_set[tst_count] = FAN_OPEN;
@@ -207,15 +196,9 @@ static void test_fanotify(unsigned int n)
 	 * Now ignore open & close events regardless of file
 	 * modifications
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag |
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag |
 			  FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
-			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
-			"FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, "
-			"FAN_OPEN | FAN_CLOSE, AT_FDCWD, %s) failed",
-			fd_notify, mark->name, fname);
-	}
+			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname);
 
 	/* This event should be ignored */
 	fd = SAFE_OPEN(fname, O_RDWR);
@@ -236,15 +219,9 @@ static void test_fanotify(unsigned int n)
 	len += ret;
 
 	/* Now remove open and close from ignored mask */
-	if (fanotify_mark(fd_notify,
+	SAFE_FANOTIFY_MARK(fd_notify,
 			  FAN_MARK_REMOVE | mark->flag | FAN_MARK_IGNORED_MASK,
-			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE | %s | "
-			"FAN_MARK_IGNORED_MASK, FAN_OPEN | FAN_CLOSE, "
-			"AT_FDCWD, %s) failed", fd_notify,
-			mark->name, fname);
-	}
+			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname);
 
 	SAFE_CLOSE(fd);
 	event_set[tst_count] = FAN_CLOSE_WRITE;
@@ -340,14 +317,9 @@ pass:
 
 	}
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
-	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
-			  AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
-			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			"failed", fd_notify, mark->name, fname);
-	}
+			  AT_FDCWD, fname);
 
 	SAFE_CLOSE(fd_notify);
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index c578e0ae8..36c87648e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -46,16 +46,9 @@ void test01(void)
 
 	int tst_count = 0;
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
-			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
-			  FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
-			  ".") < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
-			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
-			"FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
-			"failed", fd_notify);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
+			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD |
+			  FAN_ONDIR, AT_FDCWD, ".");
 
 	/*
 	 * generate sequence of events
@@ -102,13 +95,8 @@ void test01(void)
 	/*
 	 * now remove child mark
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
-			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK REMOVE, "
-			"FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
-			fd_notify);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE,
+			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
 
 	/*
 	 * Do something to verify events didn't get generated
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 8b54e42c4..2cd90e8b0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -222,14 +222,8 @@ static int setup_mark(unsigned int n)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-				  tc->mask, AT_FDCWD, files[i]) < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-				"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
-				"AT_FDCWD, %s) failed.",
-				fd_notify, mark->name, fname);
-		}
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+				  tc->mask, AT_FDCWD, files[i]);
 	}
 
 	return 0;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 722ad5d41..a24e7f7c3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -77,13 +77,8 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 		if (test_event)
 			test_event(file);
 
-		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
-				  FAN_OPEN, AT_FDCWD, file) < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
-				"FAN_OPEN, AT_FDCWD, '%s') failed",
-				fd_notify, flagstr, file);
-		}
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | flag,
+				  FAN_OPEN, AT_FDCWD, file);
 	}
 }
 
@@ -191,29 +186,14 @@ void test01(void)
 	CHECK_MARK(sname, 0, 0, test_open_file);
 
 	/* Verify FAN_MARK_FLUSH destroys all inode marks */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-			  FAN_OPEN, AT_FDCWD, fname) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
-			"AT_FDCWD, '%s') failed", fd_notify, fname);
-	}
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-			  FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
-			"FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
-			dir);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD, fname);
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_OPEN | FAN_ONDIR,
+			   AT_FDCWD, dir);
 	open_file(fname);
 	verify_event(S_IFREG);
 	open_dir(dir);
 	verify_event(S_IFDIR);
-	if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
-			  0, AT_FDCWD, ".") < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
-			"AT_FDCWD, '.') failed", fd_notify);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_FLUSH, 0, AT_FDCWD, ".");
 
 	open_dir(dir);
 	verify_no_event();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index e53cc333a..c13b9ad7b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -107,13 +107,8 @@ static void setup(void)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
 			O_RDONLY);
 
-	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
-			  AT_FDCWD, MOUNT_PATH) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
-			"FAN_OPEN, AT_FDCWD, \".\") failed",
-			fd_notify);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
+			  AT_FDCWD, MOUNT_PATH);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 99e312a4f..ac4901f6f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -78,7 +78,6 @@ static struct tcase {
 static void create_fanotify_groups(void)
 {
 	unsigned int p, i;
-	int ret;
 
 	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
@@ -87,32 +86,20 @@ static void create_fanotify_groups(void)
 							     O_RDONLY);
 
 			/* Add mount mark for each group */
-			ret = fanotify_mark(fd_notify[p][i],
+			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
 					    AT_FDCWD, fname);
-			if (ret < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | "
-					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-					" %s) failed", fd_notify[p][i], fname);
-			}
+
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
-			ret = fanotify_mark(fd_notify[p][i],
+
+			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD |
 					    FAN_MARK_IGNORED_MASK |
 					    FAN_MARK_IGNORED_SURV_MODIFY,
 					    FAN_MODIFY, AT_FDCWD, fname);
-			if (ret < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | "
-					"FAN_MARK_IGNORED_MASK | "
-					"FAN_MARK_IGNORED_SURV_MODIFY, "
-					"FAN_MODIFY, AT_FDCWD, %s) failed",
-					fd_notify[p][i], fname);
-			}
 		}
 	}
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 8822e9c51..4bf17661a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -102,14 +102,7 @@ static int setup_instance(void)
 	int fd;
 
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
-
-	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
-			  fname) < 0) {
-		close(fd);
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, %s) failed",
-			fd, fname);
-	}
+	SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
 
 	return fd;
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 83210bc1c..9c9938619 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -99,7 +99,6 @@ static void create_fanotify_groups(struct tcase *tc)
 {
 	struct fanotify_mark_type *mark = &tc->mark;
 	unsigned int i, onchild, ondir = tc->ondir;
-	int ret;
 
 	for (i = 0; i < NUM_GROUPS; i++) {
 		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF |
@@ -111,17 +110,11 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * but only the first group requests events on dir.
 		 */
 		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
-		ret = fanotify_mark(fd_notify[i],
+		SAFE_FANOTIFY_MARK(fd_notify[i],
 				    FAN_MARK_ADD | mark->flag,
 				    FAN_CLOSE_NOWRITE | onchild,
 				    AT_FDCWD, tc->testdir);
-		if (ret < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-				"%x, AT_FDCWD, '%s') failed",
-				fd_notify[i], mark->name,
-				FAN_CLOSE_NOWRITE | ondir, tc->testdir);
-		}
+
 		/*
 		 * Add inode mark on parent for each group with MODIFY event,
 		 * but only the first group requests events on child.
@@ -129,15 +122,9 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
 		 */
-		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
+		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
 				    FAN_MODIFY | ondir | onchild,
 				    AT_FDCWD, ".");
-		if (ret < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD, "
-				"%x, AT_FDCWD, '.') failed",
-				fd_notify[i], FAN_MODIFY | ondir | onchild);
-		}
 	}
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 6d048958c..4d081a843 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -289,7 +289,6 @@ static int create_fanotify_groups(unsigned int n)
 	struct fanotify_mark_type *mark, *ignore_mark;
 	unsigned int mark_ignored, mask;
 	unsigned int p, i;
-	int ret;
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
@@ -318,18 +317,12 @@ static int create_fanotify_groups(unsigned int n)
 			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
 			 * or inode mark on non-directory.
 			 */
-			ret = fanotify_mark(fd_notify[p][i],
+			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
 					    tc->expected_mask_without_ignore |
 					    FAN_EVENT_ON_CHILD,
 					    AT_FDCWD, tc->mark_path);
-			if (ret < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s,"
-					"FAN_OPEN, AT_FDCWD, %s) failed",
-					fd_notify[p][i], mark->name,
-					tc->mark_path);
-			}
+
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
@@ -338,18 +331,9 @@ static int create_fanotify_groups(unsigned int n)
 			mark_ignored = FAN_MARK_IGNORED_MASK |
 					FAN_MARK_IGNORED_SURV_MODIFY;
 add_mark:
-			ret = fanotify_mark(fd_notify[p][i],
+			SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
 					    mask, AT_FDCWD, tc->ignore_path);
-			if (ret < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s | %s, "
-					"%x, AT_FDCWD, %s) failed",
-					fd_notify[p][i], ignore_mark->name,
-					mark_ignored ? "FAN_MARK_IGNORED_MASK | "
-					"FAN_MARK_IGNORED_SURV_MODIFY" : "",
-					mask, tc->ignore_path);
-			}
 
 			/*
 			 * If ignored mask is on a parent watching children,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index 9e8606c72..56b7153f8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -55,7 +55,6 @@ static unsigned int tcases[] = {
 
 void test01(unsigned int i)
 {
-	int ret;
 	pthread_t p_id;
 	struct fanotify_event_metadata event;
 	int fd_notify;
@@ -76,10 +75,8 @@ void test01(unsigned int i)
 				tcases[i]);
 	}
 
-	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
 			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
-	if (ret != 0)
-		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d", ret);
 
 	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 0d049fc6b..18b96c430 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -147,31 +147,15 @@ static int setup_mark(unsigned int n)
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		/* Setup normal mark on object */
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-					tc->mask, AT_FDCWD, files[i]) < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-				"%llx, AT_FDCWD, %s) failed",
-				fd_notify,
-				mark->name,
-				tc->mask,
-				files[i]);
-		}
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+					tc->mask, AT_FDCWD, files[i]);
 
 		/* Setup ignore mark on object */
 		if (tc->ignore_mask) {
-			if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag
+			SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag
 						| FAN_MARK_IGNORED_MASK,
 						tc->ignore_mask, AT_FDCWD,
-						files[i]) < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark (%d, "
-					"FAN_MARK_ADD | %s "
-					"| FAN_MARK_IGNORED_MASK, "
-					"%llx, AT_FDCWD, %s) failed",
-					fd_notify, mark->name,
-					tc->ignore_mask, files[i]);
-			}
+						files[i]);
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 33989d902..d28d1a6de 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -117,13 +117,8 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 	struct fanotify_mark_type *mark = &tc->mark;
 
 	for (i = 0; i < ARRAY_SIZE(objects); i++) {
-		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
-					AT_FDCWD, objects[i].path) == -1) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
-				"AT_FDCWD, %s) failed",
-				fanotify_fd, objects[i].path);
-		}
+		SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
+				   AT_FDCWD, objects[i].path);
 
 		/* Setup the expected mask for each generated event */
 		event_set[i].expected_mask = tc->mask;
@@ -276,13 +271,8 @@ static void do_setup(void)
 	 * uninitialized connector->fsid cache. This mark remains for all test
 	 * cases and is not expected to get any events (no writes in this test).
 	 */
-	if (fanotify_mark(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
-			  FILE_PATH_ONE) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD, FAN_CLOSE_WRITE, "
-			"AT_FDCWD, "FILE_PATH_ONE") failed",
-			nofid_fd);
-	}
+	SAFE_FANOTIFY_MARK(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
+			  FILE_PATH_ONE);
 
 	/* Get the filesystem fsid and file handle for each created object */
 	get_object_stats();
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 2e3044ad7..6dd5de699 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -85,17 +85,10 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
-	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
+	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
 				FAN_MODIFY | FAN_ONDIR,
-				AT_FDCWD, TEST_DIR) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
-			"FAN_MODIFY | FAN_ONDIR | 0x%lx, "
-			"AT_FDCWD, %s) failed",
-			fanotify_fd, mark->name, tc->mask, TEST_DIR);
-	}
+				AT_FDCWD, TEST_DIR);
 
 	/* Save the test root dir fid */
 	fanotify_save_fid(TEST_DIR, &root_fid);
@@ -187,13 +180,8 @@ static void do_test(unsigned int number)
 	/*
 	 * Cleanup the mark
 	 */
-	if (fanotify_mark(fanotify_fd, FAN_MARK_FLUSH | mark->flag, 0,
-			  AT_FDCWD, TEST_DIR) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_FLUSH | %s, 0,"
-			"AT_FDCWD, '"TEST_DIR"') failed",
-			fanotify_fd, mark->name);
-	}
+	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_FLUSH | mark->flag, 0,
+			  AT_FDCWD, TEST_DIR);
 
 	/* Process each event in buffer */
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index a379226f8..0e4afac13 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -174,13 +174,8 @@ static void do_test(unsigned int number)
 	/*
 	 * Watch dir modify events with name in filesystem/dir
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
-			  AT_FDCWD, MOUNT_PATH) < 0) {
-		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, 0x%lx, "
-		    "AT_FDCWD, '"MOUNT_PATH"') failed",
-		    fd_notify, mark->name, tc->mask);
-	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
+			   AT_FDCWD, MOUNT_PATH);
 
 	/* Save the mount root fid */
 	fanotify_save_fid(MOUNT_PATH, &root_fid);
@@ -195,14 +190,9 @@ static void do_test(unsigned int number)
 	/* Save the subdir fid */
 	fanotify_save_fid(dname1, &dir_fid);
 
-	if (tc->sub_mask &&
-	    fanotify_mark(fd_notify, FAN_MARK_ADD | sub_mark->flag, tc->sub_mask,
-			  AT_FDCWD, dname1) < 0) {
-		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, 0x%lx, "
-		    "AT_FDCWD, '%s') failed",
-		    fd_notify, sub_mark->name, tc->sub_mask, dname1);
-	}
+	if (tc->sub_mask)
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | sub_mark->flag,
+				   tc->sub_mask, AT_FDCWD, dname1);
 
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
-- 
2.29.2

