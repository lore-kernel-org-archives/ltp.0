From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 13:26:37 +0100
Subject: [LTP] [PATCH 2/4] lib: Redirect to tst_brk_() early
In-Reply-To: <20170214122639.442-1-chrubis@suse.cz>
References: <20170214122639.442-1-chrubis@suse.cz>
Message-ID: <20170214122639.442-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is first patch of a patchset that would allow us to use SAFE_MACROS() in
newlib testcases. After the patch we redirect to tst_brk_() in case of newlib
tests directly in the test library code.

This is needed since the tst_brkm_() from the old library is marked as
attribute ((noreturn)) and because of that the return address is not
saved on stack and hence we cannot return from the function. Removing
the atrribute is not an option either since that generates ~1000
"control reaches end of non-void function" warnings.

This commit redefines tst_brkm in test.h for the test library code so that we
branch depending on if we are running oldlib/newlib testcase and call
corresponding tst_brk_() or tst_brkm_() function directly instead of branching
in the tst_brkm_() code.

We also had to add a few returns to various places in the test library so that
we exit corresponding function in a case that tst_brkm() actually returned.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/safe_macros.h    | 12 ++++++------
 include/old/test.h           | 17 ++++++++++++++---
 lib/Makefile                 |  2 +-
 lib/safe_file_ops.c          | 34 ++++++++++++++++++++++++++++------
 lib/safe_macros.c            |  9 +++++++++
 lib/safe_net.c               |  2 ++
 lib/self_exec.c              | 12 ++++++++++--
 lib/tst_checkpoint.c         |  2 ++
 lib/tst_device.c             |  9 +++++++--
 lib/tst_fs_has_free.c        |  1 +
 lib/tst_fs_link_count.c      | 12 ++++++++++--
 lib/tst_fs_type.c            |  1 +
 lib/tst_kernel.c             |  4 +++-
 lib/tst_mkfs.c               |  4 ++++
 lib/tst_module.c             |  3 +++
 lib/tst_net.c                | 17 +++++++++++++----
 lib/tst_path_has_mnt_flags.c |  2 ++
 lib/tst_resource.c           |  5 ++++-
 lib/tst_run_cmd.c            |  8 +++++++-
 lib/tst_timer.c              |  1 +
 lib/tst_tmpdir.c             | 25 +++++++++++++++++++------
 lib/tst_virt.c               |  2 ++
 22 files changed, 149 insertions(+), 35 deletions(-)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index 25001e8..e778d30 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -329,12 +329,12 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 	safe_readdir(__FILE__, __LINE__, (cleanup_fn), (dirp))
 
 
-#define SAFE_IOCTL(cleanup_fn, fd, request, ...)             \
-	({int ret = ioctl(fd, request, __VA_ARGS__);         \
-	  ret < 0 ?                                          \
-	   tst_brkm(TBROK | TERRNO, cleanup_fn,              \
-	            "ioctl(%i,%s,...) failed", fd, #request) \
-	 : ret;})
+#define SAFE_IOCTL(cleanup_fn, fd, request, ...)                   \
+	({int ret = ioctl(fd, request, __VA_ARGS__);               \
+	  if (ret < 0)                                             \
+		tst_brkm(TBROK | TERRNO, cleanup_fn,               \
+		         "ioctl(%i,%s,...) failed", fd, #request); \
+	  ret;})
 
 #endif /* __SAFE_MACROS_H__ */
 #endif /* __TEST_H__ */
diff --git a/include/old/test.h b/include/old/test.h
index 2cb7b98..b36764d 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -157,9 +157,20 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 void tst_brkm_(const char *file, const int lineno, int ttype,
 	void (*func)(void), const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
-#define tst_brkm(ttype, func, arg_fmt, ...) \
-	tst_brkm_(__FILE__, __LINE__, (ttype), (func), \
-		  (arg_fmt), ##__VA_ARGS__)
+
+#ifdef LTPLIB
+# include "ltp_priv.h"
+# define tst_brkm(flags, cleanup, fmt, ...) do { \
+	if (tst_test) \
+		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
+	else \
+		tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+	} while (0)
+#else
+# define tst_brkm(flags, cleanup, fmt, ...) do { \
+		tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
+	} while (0)
+#endif
 
 void tst_require_root(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
diff --git a/lib/Makefile b/lib/Makefile
index de45bef..bfbdf25 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			+= -I.
+CFLAGS			+= -I. -DLTPLIB
 
 ifneq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= android_libpthread android_librt
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 01f64ed..b576cb9 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -142,6 +142,7 @@ void safe_file_scanf(const char *file, const int lineno,
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "Failed to open FILE '%s' for reading at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 
 	exp_convs = count_scanf_conversions(fmt);
@@ -154,18 +155,21 @@ void safe_file_scanf(const char *file, const int lineno,
 		tst_brkm(TBROK, cleanup_fn,
 			 "The FILE '%s' ended prematurely at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 
 	if (ret != exp_convs) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "Expected %i conversions got %i FILE '%s' at %s:%d",
 			 exp_convs, ret, path, file, lineno);
+		return;
 	}
 
 	if (fclose(f)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "Failed to close FILE '%s' at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 }
 
@@ -188,6 +192,7 @@ int file_lines_scanf(const char *file, const int lineno,
 	if (!fmt) {
 		tst_brkm(TBROK, cleanup_fn, "pattern is NULL, %s:%d",
 			file, lineno);
+		return 1;
 	}
 
 	fp = fopen(path, "r");
@@ -195,6 +200,7 @@ int file_lines_scanf(const char *file, const int lineno,
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			"Failed to open FILE '%s' for reading at %s:%d",
 			path, file, lineno);
+		return 1;
 	}
 
 	arg_count = count_scanf_conversions(fmt);
@@ -209,9 +215,11 @@ int file_lines_scanf(const char *file, const int lineno,
 	}
 	fclose(fp);
 
-	if (strict && ret != arg_count)
+	if (strict && ret != arg_count) {
 		tst_brkm(TBROK, cleanup_fn, "Expected %i conversions got %i"
 			" at %s:%d", arg_count, ret, file, lineno);
+		return 1;
+	}
 
 	return !(ret == arg_count);
 }
@@ -273,6 +281,7 @@ void safe_file_printf(const char *file, const int lineno,
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "Failed to open FILE '%s' for writing at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 
 	va_start(va, fmt);
@@ -281,6 +290,7 @@ void safe_file_printf(const char *file, const int lineno,
 		tst_brkm(TBROK, cleanup_fn,
 			 "Failed to print to FILE '%s' at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 
 	va_end(va);
@@ -289,6 +299,7 @@ void safe_file_printf(const char *file, const int lineno,
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "Failed to close FILE '%s' at %s:%d",
 			 path, file, lineno);
+		return;
 	}
 }
 
@@ -342,23 +353,29 @@ void safe_touch(const char *file, const int lineno,
 	defmode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
 
 	ret = open(pathname, O_CREAT | O_WRONLY, defmode);
-	if (ret == -1)
+	if (ret == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			"Failed to open file '%s' at %s:%d",
 			pathname, file, lineno);
+		return;
+	}
 
 	ret = close(ret);
-	if (ret == -1)
+	if (ret == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			"Failed to close file '%s' at %s:%d",
 			pathname, file, lineno);
+		return;
+	}
 
 	if (mode != 0) {
 		ret = chmod(pathname, mode);
-		if (ret == -1)
+		if (ret == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
 				"Failed to chmod file '%s' at %s:%d",
 				pathname, file, lineno);
+			return;
+		}
 	}
 
 
@@ -372,16 +389,21 @@ void safe_touch(const char *file, const int lineno,
 		struct timeval cotimes[2];
 
 		ret = stat(pathname, &sb);
-		if (ret == -1)
+		if (ret == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
 				"Failed to stat file '%s' at %s:%d",
 				pathname, file, lineno);
+			return;
+		}
 
 		ret = gettimeofday(cotimes, NULL);
-		if (ret == -1)
+		if (ret == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
 				"Failed to gettimeofday()@%s:%d",
 				file, lineno);
+			return;
+		}
+
 		cotimes[1] = cotimes[0];
 
 		set_time(cotimes, times,
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d696a0b..42e7d98 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -461,17 +461,20 @@ long safe_strtol(const char *file, const int lineno,
 	    || (errno != 0 && rval == 0)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: strtol(%s) failed", file, lineno, str);
+		return rval;
 	}
 
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: strtol(%s): Invalid value", file, lineno, str);
+		return 0;
 	}
 
 	if (rval > max || rval < min) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: strtol(%s): %ld is out of range %ld - %ld",
 			 file, lineno, str, rval, min, max);
+		return 0;
 	}
 
 	return rval;
@@ -491,17 +494,20 @@ unsigned long safe_strtoul(const char *file, const int lineno,
 	    || (errno != 0 && rval == 0)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: strtoul(%s) failed", file, lineno, str);
+		return rval;
 	}
 
 	if (rval > max || rval < min) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: strtoul(%s): %lu is out of range %lu - %lu",
 			 file, lineno, str, rval, min, max);
+		return 0;
 	}
 
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "Invalid value: '%s'@%s:%d", str, file, lineno);
+		return 0;
 	}
 
 	return rval;
@@ -797,6 +803,7 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
+			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
@@ -818,6 +825,7 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
+			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lsetxattr() failed",
@@ -839,6 +847,7 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 			tst_brkm(TCONF, NULL,
 				 "%s:%d: no xattr support in fs or mounted "
 				 "without user_xattr option", file, lineno);
+			return rval;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fsetxattr() failed",
diff --git a/lib/safe_net.c b/lib/safe_net.c
index cae77b5..2c929ad 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -114,6 +114,7 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 				 socket, tst_sock_addr(address, address_len,
 						       buf, sizeof(buf)),
 				 address_len);
+			return -1;
 		}
 
 		if ((i + 1) % 10 == 0) {
@@ -129,6 +130,7 @@ int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
 		 lineno, socket,
 		 tst_sock_addr(address, address_len, buf, sizeof(buf)),
 		 address_len);
+	return -1;
 }
 
 int safe_listen(const char *file, const int lineno, void (cleanup_fn)(void),
diff --git a/lib/self_exec.c b/lib/self_exec.c
index 94f85b6..c287ce9 100644
--- a/lib/self_exec.c
+++ b/lib/self_exec.c
@@ -87,6 +87,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 		if (strlen(child_dir) == 0) {
 			tst_brkm(TBROK, NULL,
 				 "Could not get directory from -C option");
+			return;
 		}
 
 		va_start(ap, fmt);
@@ -96,6 +97,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 			if (!tok || strlen(tok) == 0) {
 				tst_brkm(TBROK, NULL,
 					 "Invalid argument to -C option");
+				return;
 			}
 
 			switch (*p) {
@@ -105,6 +107,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 				if (*endptr != '\0') {
 					tst_brkm(TBROK, NULL,
 						 "Invalid argument to -C option");
+					return;
 				}
 				*iptr = i;
 				break;
@@ -114,6 +117,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 				if (*endptr != '\0') {
 					tst_brkm(TBROK, NULL,
 						 "Invalid argument to -C option");
+					return;
 				}
 				if (j != i) {
 					va_end(ap);
@@ -126,6 +130,7 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 				if (!strncpy(s, tok, strlen(tok) + 1)) {
 					tst_brkm(TBROK, NULL,
 						 "Could not strncpy for -C option");
+					return;
 				}
 				break;
 			case 'S':
@@ -134,21 +139,24 @@ void maybe_run_child(void (*child) (), const char *fmt, ...)
 				if (!*sptr) {
 					tst_brkm(TBROK, NULL,
 						 "Could not strdup for -C option");
+					return;
 				}
 				break;
 			default:
 				tst_brkm(TBROK, NULL,
 					 "Format string option %c not implemented",
 					 *p);
-				break;
+				return;
 			}
 		}
 
 		va_end(ap);
 		free(args);
-		if (chdir(child_dir) < 0)
+		if (chdir(child_dir) < 0) {
 			tst_brkm(TBROK, NULL,
 				 "Could not change to %s for child", child_dir);
+			return;
+		}
 
 		(*child) ();
 		tst_resm(TWARN, "Child function returned unexpectedly");
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index a23bd02..e8e35ae 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -46,6 +46,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 		tst_brkm(TBROK, cleanup_fn,
 		         "%s: %d checkopoints allready initialized",
 		         file, lineno);
+		return;
 	}
 
 	/*
@@ -63,6 +64,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
 		tst_brkm(TBROK, cleanup_fn,
 		         "%s:%d You have to create test temporary directory "
 		         "first (call tst_tmpdir())", file, lineno);
+		return;
 	}
 
 	page_size = getpagesize();
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 4cefd60..5c91a54 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -278,18 +278,23 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 {
 	const char *device;
 
-	if (device_acquired)
+	if (device_acquired) {
 		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
+		return NULL;
+	}
 
 	if (!tst_tmpdir_created()) {
 		tst_brkm(TBROK, cleanup_fn,
 		         "Cannot acquire device without tmpdir() created");
+		return NULL;
 	}
 
 	device = tst_acquire_device__(size);
 
-	if (!device)
+	if (!device) {
 		tst_brkm(TBROK, cleanup_fn, "Failed to acquire device");
+		return NULL;
+	}
 
 	return device;
 }
diff --git a/lib/tst_fs_has_free.c b/lib/tst_fs_has_free.c
index 5c10376..e82dfa8 100644
--- a/lib/tst_fs_has_free.c
+++ b/lib/tst_fs_has_free.c
@@ -34,6 +34,7 @@ int tst_fs_has_free_(void (*cleanup)(void), const char *path,
 	if (statfs(path, &sf)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "tst_fs_has_free: failed to statfs(%s)", path);
+		return 0;
 	}
 
 	if ((uint64_t)sf.f_bavail * sf.f_bsize >= (uint64_t)size * mult)
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index ca0c77e..860510d 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -50,8 +50,10 @@ int tst_fs_fill_hardlinks_(void (*cleanup) (void), const char *dir)
 		SAFE_MKDIR(cleanup, dir, 0744);
 
 	SAFE_STAT(cleanup, dir, &s);
-	if (!S_ISDIR(s.st_mode))
+	if (!S_ISDIR(s.st_mode)) {
 		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
+		return 0;
+	}
 
 	sprintf(base_filename, "%s/testfile0", dir);
 	SAFE_TOUCH(cleanup, base_filename, 0644, NULL);
@@ -70,6 +72,7 @@ int tst_fs_fill_hardlinks_(void (*cleanup) (void), const char *dir)
 					 "hard links for %s have %i, should be"
 					 " %d", base_filename,
 					 (int)s.st_nlink, i);
+				return 0;
 			} else {
 				tst_resm(TINFO, "the maximum number of hard "
 					 "links to %s is hit: %d",
@@ -85,6 +88,7 @@ int tst_fs_fill_hardlinks_(void (*cleanup) (void), const char *dir)
 			tst_brkm(TBROK, cleanup, "link(%s, %s) failed "
 				 "unexpectedly: %s", base_filename,
 				 link_filename, strerror(errno));
+			return 0;
 		}
 	}
 
@@ -110,8 +114,10 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
 		SAFE_MKDIR(cleanup, dir, 0744);
 
 	SAFE_STAT(cleanup, dir, &s);
-	if (!S_ISDIR(s.st_mode))
+	if (!S_ISDIR(s.st_mode)) {
 		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
+		return 0;
+	}
 
 	/* for current kernel, subdir limit is not availiable for all fs */
 	fs_type = tst_fs_type(cleanup, dir);
@@ -144,6 +150,7 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
 				tst_brkm(TBROK, cleanup, "%s link counts have"
 					 "%d, should be %d", dir,
 					 (int)s.st_nlink, i + 2);
+				return 0;
 			} else {
 				tst_resm(TINFO, "the maximum subdirectories in "
 				 "%s is hit: %d", dir, (int)s.st_nlink);
@@ -158,6 +165,7 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
 			tst_brkm(TBROK, cleanup, "mkdir(%s, 0755) failed "
 				 "unexpectedly: %s", dirname,
 				 strerror(errno));
+			return 0;
 		}
 
 	}
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index c6c61ec..5fbf0f4 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -37,6 +37,7 @@ long tst_fs_type_(void (*cleanup)(void), const char *path)
 	if (statfs(path, &sbuf)) {
 		tst_brkm(TBROK | TERRNO, cleanup,
 		         "tst_fs_type: Failed to statfs(%s)", path);
+		return 0;
 	}
 
 	return sbuf.f_type;
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 7a53002..71303fc 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -24,8 +24,10 @@ int tst_kernel_bits(void)
 	struct utsname buf;
 	int kernel_bits;
 
-	if (uname(&buf))
+	if (uname(&buf)) {
 		tst_brkm(TBROK | TERRNO, NULL, "uname()");
+		return -1;
+	}
 
 	kernel_bits = strstr(buf.machine, "64") ? 64 : 32;
 
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 7810654..f2e40ec 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -33,11 +33,13 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (!dev) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: No device specified", file, lineno);
+		return;
 	}
 
 	if (!fs_type) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: No fs_type specified", file, lineno);
+		return;
 	}
 
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
@@ -50,6 +52,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 				tst_brkm(TBROK, cleanup_fn,
 				         "%s:%d: Too much mkfs options",
 					 file, lineno);
+				return;
 			}
 
 			if (i)
@@ -66,6 +69,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		if (pos + 1 > OPTS_MAX) {
 			tst_brkm(TBROK, cleanup_fn,
 			         "%s:%d: Too much mkfs options", file, lineno);
+			return;
 		}
 	}
 
diff --git a/lib/tst_module.c b/lib/tst_module.c
index fd4f019..ed39952 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -47,6 +47,7 @@ void tst_module_exists(void (cleanup_fn)(void),
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
 				"asprintf failed at %s:%d",
 				__FILE__, __LINE__);
+			return;
 		}
 		err = access(buf, F_OK);
 	}
@@ -58,6 +59,7 @@ void tst_module_exists(void (cleanup_fn)(void),
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
 				"asprintf failed at %s:%d",
 				__FILE__, __LINE__);
+			return;
 		}
 		err = access(buf, F_OK);
 	}
@@ -66,6 +68,7 @@ void tst_module_exists(void (cleanup_fn)(void),
 		free(buf);
 		tst_brkm(TCONF, cleanup_fn, "Failed to find module '%s'",
 			mod_name);
+		return;
 	}
 
 	if (mod_path != NULL)
diff --git a/lib/tst_net.c b/lib/tst_net.c
index f55e107..f842e94 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -54,20 +54,29 @@ unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 	default:
 		tst_brkm(TBROK, cleanup_fn,
 			"tst_get_unused_port unknown family");
+		return -1;
 	}
 
 	sock = socket(addr->sa_family, type, 0);
-	if (sock < 0)
+	if (sock < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "socket failed");
+		return -1;
+	}
 
-	if (bind(sock, addr, slen) < 0)
+	if (bind(sock, addr, slen) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "bind failed");
+		return -1;
+	}
 
-	if (getsockname(sock, addr, &slen) == -1)
+	if (getsockname(sock, addr, &slen) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "getsockname failed");
+		return -1;
+	}
 
-	if (close(sock) == -1)
+	if (close(sock) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "close failed");
+		return -1;
+	}
 
 	switch (family) {
 	case AF_INET:
diff --git a/lib/tst_path_has_mnt_flags.c b/lib/tst_path_has_mnt_flags.c
index ba66105..ea910ea 100644
--- a/lib/tst_path_has_mnt_flags.c
+++ b/lib/tst_path_has_mnt_flags.c
@@ -44,12 +44,14 @@ int tst_path_has_mnt_flags(void (cleanup_fn)(void),
 	if (access(path, F_OK) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			"tst_path_has_mnt_flags: path %s doesn't exist", path);
+		return -1;
 	}
 
 	f = setmntent("/proc/mounts", "r");
 	if (f == NULL) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			"tst_path_has_mnt_flags: failed to open /proc/mounts");
+		return -1;
 	}
 
 	while ((mnt = getmntent(f))) {
diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index e283f86..78450df 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -54,9 +54,11 @@ static void tst_dataroot_init(void)
 	} else {
 		startdir = tst_get_startwd();
 		if (startdir[0] == 0) {
-			if (getcwd(curdir, PATH_MAX) == NULL)
+			if (getcwd(curdir, PATH_MAX) == NULL) {
 				tst_brkm(TBROK | TERRNO, NULL,
 					"tst_dataroot getcwd");
+				return;
+			}
 			startdir = curdir;
 		}
 		ret = snprintf(dataroot, PATH_MAX, "%s/datafiles", startdir);
@@ -103,6 +105,7 @@ void tst_resource_copy(const char *file, const int lineno,
 		tst_brkm(TBROK, cleanup_fn,
 		         "Temporary directory doesn't exist at %s:%d",
 		         file, lineno);
+		return;
 	}
 
 	if (dest == NULL)
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 6fae573..8e4bf6b 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -42,6 +42,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
 			"argument list is empty at %s:%d", __FILE__, __LINE__);
+		return -1;
 	}
 
 	/*
@@ -58,6 +59,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	if (pid == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
 			__FILE__, __LINE__);
+		return -1;
 	}
 	if (!pid) {
 		/* redirecting stdout and stderr if needed */
@@ -82,6 +84,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	if (waitpid(pid, &ret, 0) != pid) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "waitpid failed at %s:%d",
 			__FILE__, __LINE__);
+		return -1;
 	}
 
 	signal(SIGCHLD, old_handler);
@@ -89,14 +92,17 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	if (!WIFEXITED(ret)) {
 		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
 			argv[0], __FILE__, __LINE__);
+		return -1;
 	}
 
 	rc = WEXITSTATUS(ret);
 
-	if ((!pass_exit_val) && rc)
+	if ((!pass_exit_val) && rc) {
 		tst_brkm(TBROK, cleanup_fn,
 			 "'%s' exited with a non-zero code %d@%s:%d",
 			 argv[0], rc, __FILE__, __LINE__);
+		return -1;
+	}
 
 	return rc;
 }
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index 5f0cfc4..bd3f277 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -61,6 +61,7 @@ void tst_timer_check(clockid_t clk_id)
 			tst_brkm(TCONF, NULL,
 			         "Clock id %s(%u) not supported by kernel",
 				 clock_name(clk_id), clk_id);
+			return;
 		}
 
 		tst_brkm(TBROK | TERRNO, NULL, "clock_gettime() failed");
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 405d377..824cade 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -105,9 +105,11 @@ int tst_tmpdir_created(void)
 
 char *tst_get_tmpdir(void)
 {
-	/* Smack the user for calling things out of order. */
-	if (TESTDIR == NULL)
+	if (TESTDIR == NULL) {
 		tst_brkm(TBROK, NULL, "you must call tst_tmpdir() first");
+		return NULL;
+	}
+
 	return strdup(TESTDIR);
 }
 
@@ -248,6 +250,7 @@ void tst_tmpdir(void)
 		if (c != env_tmpdir) {
 			tst_brkm(TBROK, NULL, "You must specify an absolute "
 				 "pathname for environment variable TMPDIR");
+			return;
 		}
 		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
 	} else {
@@ -255,19 +258,29 @@ void tst_tmpdir(void)
 	}
 
 	/* Make the temporary directory in one shot using mkdtemp. */
-	if (mkdtemp(template) == NULL)
+	if (mkdtemp(template) == NULL) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "%s: mkdtemp(%s) failed", __func__, template);
-	if ((TESTDIR = strdup(template)) == NULL)
+		return;
+	}
+
+	if ((TESTDIR = strdup(template)) == NULL) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "%s: strdup(%s) failed", __func__, template);
+		return;
+	}
 
-	if (chown(TESTDIR, -1, getgid()) == -1)
+	if (chown(TESTDIR, -1, getgid()) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "chown(%s, -1, %d) failed", TESTDIR, getgid());
-	if (chmod(TESTDIR, DIR_MODE) == -1)
+		return;
+	}
+
+	if (chmod(TESTDIR, DIR_MODE) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
+		return;
+	}
 
 	if (getcwd(test_start_work_dir, sizeof(test_start_work_dir)) == NULL) {
 		tst_resm(TINFO, "Failed to record test working dir");
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index d40ba39..e95cf5e 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -115,5 +115,7 @@ int tst_is_virt(int virt_type)
 	case VIRT_KVM:
 		return is_kvm();
 	}
+
 	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
+	return -1;
 }
-- 
2.10.2

