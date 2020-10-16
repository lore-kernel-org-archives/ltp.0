From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Oct 2020 13:24:41 +0200
Subject: [LTP] [PATCH 1/1] fanotify16: Introduce SAFE_FANOTIFY_MARK() macro
Message-ID: <20201016112441.4838-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fanotify_mark() checks for unsupported filesystem were missing
least for exfat on fanotify16. But because unsupported filesystem can be
set via LTP_DEV_FS_TYPE environment variable on tests which don't tests
all filesystems, introduce universal check and use it in all suitable
places.

Checks for masks and flags uses tst_ret() instead of usual tst_brk(),
therefore caller needs to check the return value.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Amir,

to be honest, I'd prefer to be more strict and use tst_brk()
it could be used on more places (fanotify07.c) and return could be avoided.

But some checks:
fanotify13.c:161: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs

... would be stopped on the first error:
fanotify13.c:141: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
fanotify.h:82: TCONF: fanotify13.c:119: fanotify_mark(): flag not supported on ntfs filesystem

Also on some places it lost some info, for this reason not used in fanotify15.c and only once in fanotify01.c.

Kind regards,
Petr


 testcases/kernel/syscalls/fanotify/fanotify.h | 43 ++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify01.c     | 16 ++----
 .../kernel/syscalls/fanotify/fanotify02.c     | 24 +++------
 .../kernel/syscalls/fanotify/fanotify03.c     | 45 ++++-------------
 .../kernel/syscalls/fanotify/fanotify04.c     |  9 +---
 .../kernel/syscalls/fanotify/fanotify05.c     | 10 ++--
 .../kernel/syscalls/fanotify/fanotify06.c     | 23 +++------
 .../kernel/syscalls/fanotify/fanotify09.c     | 29 +++++------
 .../kernel/syscalls/fanotify/fanotify10.c     | 39 +++------------
 .../kernel/syscalls/fanotify/fanotify11.c     |  4 +-
 .../kernel/syscalls/fanotify/fanotify12.c     | 50 +++----------------
 .../kernel/syscalls/fanotify/fanotify13.c     | 23 +--------
 .../kernel/syscalls/fanotify/fanotify15.c     | 16 ++----
 .../kernel/syscalls/fanotify/fanotify16.c     | 21 +++-----
 14 files changed, 113 insertions(+), 239 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 0afbc02aa..952bd8031 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -60,9 +60,13 @@ int safe_fanotify_init(const char *file, const int lineno,
 
 	return rval;
 }
+
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
 	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
 
+#define SAFE_FANOTIFY_MARK(fd, flags, mask, dfd, pathname)  \
+	safe_fanotify_mark(__FILE__, __LINE__, (fd), (flags), (mask), (dfd), (pathname))
+
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
@@ -242,4 +246,43 @@ static inline void fanotify_save_fid(const char *path,
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
+#define FANOTIFY_CHECK(flag, flags) \
+	({ \
+		if (errno == EINVAL && (flags & flag) == flag) { \
+			tst_res(TCONF, "%s:%d: "#flag" not supported by kernel?", \
+				file, lineno); \
+			return -1; \
+		} \
+	})
+
+static inline long safe_fanotify_mark(const char *file, const int lineno,
+			int fd, unsigned int flags, uint64_t mask,
+			int dfd, const char *pathname)
+{
+	long rval;
+
+	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
+
+	if (rval < 0) {
+		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
+			tst_brk(TCONF,
+				"%s:%d: fanotify_mark(): flag not supported on %s filesystem",
+				file, lineno, tst_device->fs_type);
+
+		FANOTIFY_CHECK(FAN_OPEN_EXEC_PERM, mask);
+		FANOTIFY_CHECK(FAN_OPEN_EXEC, mask);
+		FANOTIFY_CHECK(FAN_MARK_FILESYSTEM, flags);
+
+		if (errno == EINVAL)
+				tst_brk(TCONF | TERRNO,
+					"CONFIG_FANOTIFY_ACCESS_PERMISSIONS "
+					"not configured in kernel?");
+
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: fanotify_mark() failed", file, lineno);
+	}
+
+	return rval;
+}
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 03e453f41..c195a5093 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -101,19 +101,9 @@ static void test_fanotify(unsigned int n)
 			"failed", tc->init_flags);
 	}
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
-			  AT_FDCWD, fname) < 0) {
-		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
-			tst_res(TCONF,
-				"FAN_MARK_FILESYSTEM not supported in kernel?");
-			return;
-		}
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
-			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			"failed", fd_notify, mark->name, fname);
-	}
+	if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname))
+		return;
 
 	/*
 	 * generate sequence of events
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index c578e0ae8..bd7528c79 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -46,16 +46,10 @@ void test01(void)
 
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
+	if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
+			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD |
+			  FAN_ONDIR, AT_FDCWD, "."))
+		return;
 
 	/*
 	 * generate sequence of events
@@ -102,13 +96,9 @@ void test01(void)
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
+	if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE,
+			  FAN_EVENT_ON_CHILD, AT_FDCWD, "."))
+		return;
 
 	/*
 	 * Do something to verify events didn't get generated
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 1ef1c206b..4dc7da882 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -215,41 +215,16 @@ static int setup_mark(unsigned int n)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-				  tc->mask, AT_FDCWD, files[i]) < 0) {
-			if (errno == EINVAL &&
-				(tc->mask & FAN_OPEN_EXEC_PERM &&
-				 !support_exec_events)) {
-				tst_res(TCONF,
-					"FAN_OPEN_EXEC_PERM not supported in "
-					"kernel?");
-				return -1;
-			} else if (errno == EINVAL &&
-					mark->flag == FAN_MARK_FILESYSTEM) {
-				tst_res(TCONF,
-					"FAN_MARK_FILESYSTEM not supported in "
-					"kernel?");
-				return -1;
-			} else if (errno == EINVAL) {
-				tst_brk(TCONF | TERRNO,
-					"CONFIG_FANOTIFY_ACCESS_PERMISSIONS "
-					"not configured in kernel?");
-			} else {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-					"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
-					"AT_FDCWD, %s) failed.",
-					fd_notify, mark->name, fname);
-			}
-		} else {
-			/*
-			 * To distinguish between perm not supported, exec
-			 * events not supported and filesystem mark not
-			 * supported.
-			 */
-			if (tc->mask & FAN_OPEN_EXEC_PERM)
-				support_exec_events = 1;
-		}
+		if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+				  tc->mask, AT_FDCWD, files[i]) < 0)
+			return -1;
+		/*
+		 * To distinguish between perm not supported, exec
+		 * events not supported and filesystem mark not
+		 * supported.
+		 */
+		if (tc->mask & FAN_OPEN_EXEC_PERM)
+			support_exec_events = 1;
 	}
 
 	return 0;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 722ad5d41..c0dbcce0b 100644
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
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index e53cc333a..fad00efb6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -107,13 +107,9 @@ static void setup(void)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
 			O_RDONLY);
 
-	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
-			  AT_FDCWD, MOUNT_PATH) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
-			"FAN_OPEN, AT_FDCWD, \".\") failed",
-			fd_notify);
-	}
+	if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
+			  AT_FDCWD, MOUNT_PATH))
+		return;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 99e312a4f..7aad99846 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -87,32 +87,23 @@ static void create_fanotify_groups(void)
 							     O_RDONLY);
 
 			/* Add mount mark for each group */
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
 					    AT_FDCWD, fname);
-			if (ret < 0) {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | "
-					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-					" %s) failed", fd_notify[p][i], fname);
-			}
+			if (ret < 0)
+				continue;
+
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = SAFE_FANOTIFY_MARK(fd_notify[p][i],
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
+			if (ret < 0)
+				continue;
 		}
 	}
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 83210bc1c..dc3ee1082 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -95,7 +95,7 @@ static struct tcase {
 	},
 };
 
-static void create_fanotify_groups(struct tcase *tc)
+static int create_fanotify_groups(struct tcase *tc)
 {
 	struct fanotify_mark_type *mark = &tc->mark;
 	unsigned int i, onchild, ondir = tc->ondir;
@@ -111,17 +111,13 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * but only the first group requests events on dir.
 		 */
 		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
-		ret = fanotify_mark(fd_notify[i],
+		ret = SAFE_FANOTIFY_MARK(fd_notify[i],
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
+		if (ret < 0)
+			return -1;
+
 		/*
 		 * Add inode mark on parent for each group with MODIFY event,
 		 * but only the first group requests events on child.
@@ -129,16 +125,14 @@ static void create_fanotify_groups(struct tcase *tc)
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
 		 */
-		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
+		ret = SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
 				    FAN_MODIFY | ondir | onchild,
 				    AT_FDCWD, ".");
-		if (ret < 0) {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD, "
-				"%x, AT_FDCWD, '.') failed",
-				fd_notify[i], FAN_MODIFY | ondir | onchild);
-		}
+		if (ret < 0)
+			return -1;
 	}
+
+	return 0;
 }
 
 static void cleanup_fanotify_groups(void)
@@ -192,7 +186,8 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	create_fanotify_groups(tc);
+	if (create_fanotify_groups(tc))
+		return;
 
 	/*
 	 * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 90cf5cb5f..003a4aa0d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -316,32 +316,14 @@ static int create_fanotify_groups(unsigned int n)
 			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
 			 * or inode mark on non-directory.
 			 */
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = SAFE_FANOTIFY_MARK(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
 					    tc->expected_mask_without_ignore |
 					    FAN_EVENT_ON_CHILD,
 					    AT_FDCWD, tc->mark_path);
-			if (ret < 0) {
-				if (errno == EINVAL &&
-				    tc->expected_mask_without_ignore &
-				    FAN_OPEN_EXEC) {
-					tst_res(TCONF,
-						"FAN_OPEN_EXEC not supported "
-						"by kernel?");
-					return -1;
-				} else if (errno == EINVAL &&
-					tc->mark_type == FANOTIFY_FILESYSTEM) {
-					tst_res(TCONF,
-						"FAN_MARK_FILESYSTEM not "
-						"supported in kernel?");
-					return -1;
-				}
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s,"
-					"FAN_OPEN, AT_FDCWD, %s) failed",
-					fd_notify[p][i], mark->name,
-					tc->mark_path);
-			}
+			if (ret < 0)
+				return -1;
+
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
@@ -350,18 +332,11 @@ static int create_fanotify_groups(unsigned int n)
 			mark_ignored = FAN_MARK_IGNORED_MASK |
 					FAN_MARK_IGNORED_SURV_MODIFY;
 add_mark:
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = SAFE_FANOTIFY_MARK(fd_notify[p][i],
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
+			if (ret < 0)
+				return -1;
 
 			/*
 			 * If ignored mask is on a parent watching children,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index 9e8606c72..fd41fa39a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -76,10 +76,10 @@ void test01(unsigned int i)
 				tcases[i]);
 	}
 
-	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
+	ret = SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
 			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
 	if (ret != 0)
-		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d", ret);
+		return;
 
 	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index fcb7ec0d3..5e7667a17 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -139,55 +139,17 @@ static int setup_mark(unsigned int n)
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		/* Setup normal mark on object */
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
-					tc->mask, AT_FDCWD, files[i]) < 0) {
-			if (errno == EINVAL && tc->mask & FAN_OPEN_EXEC) {
-				tst_res(TCONF,
-					"FAN_OPEN_EXEC not supported in "
-					"kernel?");
-				return -1;
-			} else if (errno == EINVAL) {
-				tst_brk(TCONF | TERRNO,
-					"CONFIG_FANOTIFY_ACCESS_PERMISSIONS "
-					"not configured in kernel?");
-			}else {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-					"%llx, AT_FDCWD, %s) failed",
-					fd_notify,
-					mark->name,
-					tc->mask,
-					files[i]);
-			}
-		}
+		if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+					tc->mask, AT_FDCWD, files[i]) < 0)
+			return -1;
 
 		/* Setup ignore mark on object */
 		if (tc->ignore_mask) {
-			if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag
+			if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag
 						| FAN_MARK_IGNORED_MASK,
 						tc->ignore_mask, AT_FDCWD,
-						files[i]) < 0) {
-				if (errno == EINVAL &&
-					tc->ignore_mask & FAN_OPEN_EXEC) {
-					tst_res(TCONF,
-						"FAN_OPEN_EXEC not supported "
-						"in kernel?");
-					return -1;
-				} else if (errno == EINVAL) {
-					tst_brk(TCONF | TERRNO,
-						"CONFIG_FANOTIFY_ACCESS_"
-						"PERMISSIONS not configured in "
-						"kernel?");
-				} else {
-					tst_brk(TBROK | TERRNO,
-						"fanotify_mark (%d, "
-						"FAN_MARK_ADD | %s "
-						"| FAN_MARK_IGNORED_MASK, "
-						"%llx, AT_FDCWD, %s) failed",
-						fd_notify, mark->name,
-						tc->ignore_mask, files[i]);
-				}
-			}
+						files[i]) < 0)
+			return -1;
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index c2a21bb66..6d5bd621d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -116,28 +116,9 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 	struct fanotify_mark_type *mark = &tc->mark;
 
 	for (i = 0; i < ARRAY_SIZE(objects); i++) {
-		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
-					AT_FDCWD, objects[i].path) == -1) {
-			if (errno == EINVAL &&
-				mark->flag & FAN_MARK_FILESYSTEM) {
-				tst_res(TCONF,
-					"FAN_MARK_FILESYSTEM not supported by "
-					"kernel");
+		if (SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
+					AT_FDCWD, objects[i].path))
 				return 1;
-			} else if (errno == ENODEV &&
-				   !objects[i].fid.fsid.val[0] &&
-				   !objects[i].fid.fsid.val[1]) {
-				tst_res(TCONF,
-					"FAN_REPORT_FID not supported on "
-					"filesystem type %s",
-					tst_device->fs_type);
-				return 1;
-			}
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
-				"AT_FDCWD, %s) failed",
-				fanotify_fd, objects[i].path);
-		}
 
 		/* Setup the expected mask for each generated event */
 		event_set[i].expected_mask = tc->mask;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index d787a08e3..f9b7773b1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -85,21 +85,11 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
-	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
+	if (SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
 				FAN_MODIFY | FAN_ONDIR,
-				AT_FDCWD, TEST_DIR) == -1) {
-		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
-			tst_brk(TCONF,
-				"FAN_REPORT_FID not supported on %s "
-				"filesystem", tst_device->fs_type);
-		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
-			"FAN_MODIFY | FAN_ONDIR | 0x%lx, "
-			"AT_FDCWD, %s) failed",
-			fanotify_fd, mark->name, tc->mask, TEST_DIR);
-	}
+				AT_FDCWD, TEST_DIR) == -1)
+		return;
 
 	/* Save the test root dir fid */
 	fanotify_save_fid(TEST_DIR, &root_fid);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 7995a1688..61634e971 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -174,13 +174,9 @@ static void do_test(unsigned int number)
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
+	if (SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
+			   AT_FDCWD, MOUNT_PATH))
+		return;
 
 	/* Save the mount root fid */
 	fanotify_save_fid(MOUNT_PATH, &root_fid);
@@ -195,14 +191,9 @@ static void do_test(unsigned int number)
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
+	if (tc->sub_mask && SAFE_FANOTIFY_MARK(fd_notify,
+		FAN_MARK_ADD | sub_mark->flag, tc->sub_mask, AT_FDCWD, dname1))
+		return;
 
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
-- 
2.28.0

