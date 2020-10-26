From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:42 +0100
Subject: [LTP] [PATCH 05/19] Unify error handling in lib/safe_macros.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-6-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/safe_macros.c | 602 +++++++++++++++++++++++++++++-----------------
 1 file changed, 384 insertions(+), 218 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 4f48d7529..f5e80fc48 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -30,10 +30,10 @@ char *safe_basename(const char *file, const int lineno,
 	char *rval;
 
 	rval = basename(path);
+
 	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: basename(%s) failed",
-			 file, lineno, path);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"basename(%s) failed", path);
 	}
 
 	return rval;
@@ -46,10 +46,13 @@ safe_chdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = chdir(path);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: chdir(%s) failed",
-			 file, lineno, path);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"chdir(%s) failed", path);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid chdir(%s) return value %d", path, rval);
 	}
 
 	return rval;
@@ -62,10 +65,13 @@ safe_close(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = close(fildes);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: close(%d) failed",
-			 file, lineno, fildes);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"close(%d) failed", fildes);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid close(%d) return value %d", fildes, rval);
 	}
 
 	return rval;
@@ -78,10 +84,14 @@ safe_creat(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = creat(pathname, mode);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: creat(%s,0%o) failed",
-			 file, lineno, pathname, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"creat(%s,%04o) failed", pathname, mode);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid creat(%s,%04o) return value %d", pathname,
+			mode, rval);
 	}
 
 	return rval;
@@ -93,10 +103,10 @@ char *safe_dirname(const char *file, const int lineno,
 	char *rval;
 
 	rval = dirname(path);
+
 	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: dirname(%s) failed",
-			 file, lineno, path);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"dirname(%s) failed", path);
 	}
 
 	return rval;
@@ -108,10 +118,10 @@ char *safe_getcwd(const char *file, const int lineno, void (*cleanup_fn) (void),
 	char *rval;
 
 	rval = getcwd(buf, size);
+
 	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getcwd(%p,%zu) failed",
-			 file, lineno, buf, size);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getcwd(%p,%zu) failed", buf, size);
 	}
 
 	return rval;
@@ -123,10 +133,10 @@ struct passwd *safe_getpwnam(const char *file, const int lineno,
 	struct passwd *rval;
 
 	rval = getpwnam(name);
+
 	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getpwnam(%s) failed",
-			 file, lineno, name);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getpwnam(%s) failed", name);
 	}
 
 	return rval;
@@ -139,10 +149,14 @@ safe_getrusage(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = getrusage(who, usage);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getrusage(%d,%p) failed",
-			 file, lineno, who, usage);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getrusage(%d,%p) failed", who, usage);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid getrusage(%d,%p) return value %d", who,
+			usage, rval);
 	}
 
 	return rval;
@@ -154,10 +168,10 @@ void *safe_malloc(const char *file, const int lineno, void (*cleanup_fn) (void),
 	void *rval;
 
 	rval = malloc(size);
+
 	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: malloc(%zu) failed",
-			 file, lineno, size);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"malloc(%zu) failed", size);
 	}
 
 	return rval;
@@ -169,10 +183,14 @@ int safe_mkdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = mkdir(pathname, mode);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: mkdir(%s,0%o) failed",
-			 file, lineno, pathname, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"mkdir(%s, %04o) failed", pathname, mode);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid mkdir(%s, %04o) return value %d", pathname,
+			mode, rval);
 	}
 
 	return (rval);
@@ -184,10 +202,13 @@ int safe_rmdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = rmdir(pathname);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: rmdir(%s) failed",
-			 file, lineno, pathname);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"rmdir(%s) failed", pathname);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid rmdir(%s) return value %d", pathname, rval);
 	}
 
 	return (rval);
@@ -199,10 +220,14 @@ int safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = munmap(addr, length);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: munmap(%p,%zu) failed",
-			 file, lineno, addr, length);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"munmap(%p,%zu) failed", addr, length);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid munmap(%p,%zu) return value %d", addr,
+			length, rval);
 	}
 
 	return rval;
@@ -225,10 +250,14 @@ int safe_open(const char *file, const int lineno, void (*cleanup_fn) (void),
 	va_end(ap);
 
 	rval = open(pathname, oflags, mode);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: open(%s,%d,0%o) failed",
-			 file, lineno, pathname, oflags, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"open(%s,%d,%04o) failed", pathname, oflags, mode);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid open(%s,%d,%04o) return value %d", pathname,
+			oflags, mode, rval);
 	}
 
 	return rval;
@@ -240,10 +269,14 @@ int safe_pipe(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = pipe(fildes);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: pipe({%d,%d}) failed",
-			 file, lineno, fildes[0], fildes[1]);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"pipe({%d,%d}) failed", fildes[0], fildes[1]);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid pipe({%d,%d}) return value %d", fildes[0],
+			fildes[1], rval);
 	}
 
 	return rval;
@@ -255,10 +288,16 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 	ssize_t rval;
 
 	rval = read(fildes, buf, nbyte);
+
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: read(%d,%p,%zu) failed, returned %zd",
-			 file, lineno, fildes, buf, nbyte, rval);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
+			nbyte, rval);
+	}
+	if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid read(%d,%p,%zu) return value %zd", fildes,
+			buf, nbyte, rval);
 	}
 
 	return rval;
@@ -270,10 +309,14 @@ int safe_setegid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = setegid(egid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: setegid(%u) failed",
-			 file, lineno, (unsigned) egid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"setegid(%u) failed", (unsigned int)egid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid setegid(%u) return value %d",
+			(unsigned int)egid, rval);
 	}
 
 	return rval;
@@ -285,10 +328,14 @@ int safe_seteuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = seteuid(euid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: seteuid(%u) failed",
-			 file, lineno, (unsigned) euid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"seteuid(%u) failed", (unsigned int)euid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid seteuid(%u) return value %d",
+			(unsigned int)euid, rval);
 	}
 
 	return rval;
@@ -300,10 +347,14 @@ int safe_setgid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = setgid(gid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: setgid(%u) failed",
-			 file, lineno, (unsigned) gid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"setgid(%u) failed", (unsigned int)gid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid setgid(%u) return value %d",
+			(unsigned int)gid, rval);
 	}
 
 	return rval;
@@ -315,10 +366,14 @@ int safe_setuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = setuid(uid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: setuid(%u) failed",
-			 file, lineno, (unsigned) uid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"setuid(%u) failed", (unsigned int)uid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid setuid(%u) return value %d",
+			(unsigned int)uid, rval);
 	}
 
 	return rval;
@@ -330,10 +385,14 @@ int safe_getresuid(const char *file, const int lineno, void (*cleanup_fn)(void),
 	int rval;
 
 	rval = getresuid(ruid, euid, suid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getresuid(%p, %p, %p) failed",
-			 file, lineno, ruid, euid, suid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getresuid(%p, %p, %p) failed", ruid, euid, suid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid getresuid(%p, %p, %p) return value %d", ruid,
+			euid, suid, rval);
 	}
 
 	return rval;
@@ -345,10 +404,14 @@ int safe_getresgid(const char *file, const int lineno, void (*cleanup_fn)(void),
 	int rval;
 
 	rval = getresgid(rgid, egid, sgid);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: getresgid(%p, %p, %p) failed",
-			 file, lineno, rgid, egid, sgid);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"getresgid(%p, %p, %p) failed", rgid, egid, sgid);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid getresgid(%p, %p, %p) return value %d", rgid,
+			egid, sgid, rval);
 	}
 
 	return rval;
@@ -360,10 +423,13 @@ int safe_unlink(const char *file, const int lineno, void (*cleanup_fn) (void),
 	int rval;
 
 	rval = unlink(pathname);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: unlink(%s) failed",
-			 file, lineno, pathname);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"unlink(%s) failed", pathname);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid unlink(%s) return value %d", pathname, rval);
 	}
 
 	return rval;
@@ -379,9 +445,12 @@ int safe_link(const char *file, const int lineno,
 	rval = link(oldpath, newpath);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: link(%s,%s) failed",
-			 file, lineno, oldpath, newpath);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+		        "link(%s,%s) failed", oldpath, newpath);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+		        "Invalid link(%s,%s) return value %d", oldpath,
+			newpath, rval);
 	}
 
 	return rval;
@@ -396,10 +465,13 @@ int safe_linkat(const char *file, const int lineno,
 	rval = linkat(olddirfd, oldpath, newdirfd, newpath, flags);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: linkat(%d,%s,%d,%s,%d) failed",
-			 file, lineno, olddirfd, oldpath, newdirfd,
-			 newpath, flags);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"linkat(%d,%s,%d,%s,%d) failed", olddirfd, oldpath,
+			newdirfd, newpath, flags);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid linkat(%d,%s,%d,%s,%d) return value %d",
+			olddirfd, oldpath, newdirfd, newpath, flags, rval);
 	}
 
 	return rval;
@@ -414,9 +486,12 @@ ssize_t safe_readlink(const char *file, const int lineno,
 	rval = readlink(path, buf, bufsize);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: readlink(%s,%p,%zu) failed",
-			 file, lineno, path, buf, bufsize);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"readlink(%s,%p,%zu) failed", path, buf, bufsize);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid readlink(%s,%p,%zu) return value %zd", path,
+			buf, bufsize, rval);
 	} else {
 		/* readlink does not append a NUL byte to the buffer.
 		 * Add it now. */
@@ -438,9 +513,12 @@ int safe_symlink(const char *file, const int lineno,
 	rval = symlink(oldpath, newpath);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: symlink(%s,%s) failed",
-			 file, lineno, oldpath, newpath);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"symlink(%s,%s) failed", oldpath, newpath);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid symlink(%s,%s) return value %d", oldpath,
+			newpath, rval);
 	}
 
 	return rval;
@@ -452,10 +530,14 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 	ssize_t rval;
 
 	rval = write(fildes, buf, nbyte);
+
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: write(%d,%p,%zu) failed",
-		         file, lineno, fildes, buf, rval);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"write(%d,%p,%zu) failed", fildes, buf, nbyte);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid write(%d,%p,%zu) return value %zd", fildes,
+			buf, nbyte, rval);
 	}
 
 	return rval;
@@ -472,21 +554,21 @@ long safe_strtol(const char *file, const int lineno,
 
 	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
 	    || (errno != 0 && rval == 0)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: strtol(%s) failed", file, lineno, str);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"strtol(%s) failed", str);
 		return rval;
 	}
 
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: strtol(%s): Invalid value", file, lineno, str);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"strtol(%s): Invalid value", str);
 		return 0;
 	}
 
 	if (rval > max || rval < min) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: strtol(%s): %ld is out of range %ld - %ld",
-			 file, lineno, str, rval, min, max);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"strtol(%s): %ld is out of range %ld - %ld",
+			str, rval, min, max);
 		return 0;
 	}
 
@@ -505,21 +587,21 @@ unsigned long safe_strtoul(const char *file, const int lineno,
 
 	if ((errno == ERANGE && rval == ULONG_MAX)
 	    || (errno != 0 && rval == 0)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: strtoul(%s) failed", file, lineno, str);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"strtoul(%s) failed", str);
 		return rval;
 	}
 
 	if (rval > max || rval < min) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: strtoul(%s): %lu is out of range %lu - %lu",
-			 file, lineno, str, rval, min, max);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"strtoul(%s): %lu is out of range %lu - %lu",
+			str, rval, min, max);
 		return 0;
 	}
 
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "Invalid value: '%s' at %s:%d", str, file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"Invalid value: '%s'", str);
 		return 0;
 	}
 
@@ -530,20 +612,19 @@ long safe_sysconf(const char *file, const int lineno,
 		  void (cleanup_fn) (void), int name)
 {
 	long rval;
-	errno = 0;
 
+	errno = 0;
 	rval = sysconf(name);
 
 	if (rval == -1) {
 		if (errno) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "%s:%d: sysconf(%d) failed",
-				 file, lineno, name);
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"sysconf(%d) failed", name);
 		} else {
-			tst_resm(TINFO, "%s:%d: sysconf(%d): "
-				 "queried option is not available"
-				 " or there is no definite limit",
-				 file, lineno, name);
+			tst_resm_(file, lineno, TINFO, "sysconf(%d): "
+				"queried option is not available"
+				" or there is no definite limit",
+				name);
 		}
 	}
 
@@ -558,9 +639,12 @@ int safe_chmod(const char *file, const int lineno,
 	rval = chmod(path, mode);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: chmod(%s,0%o) failed",
-			 file, lineno, path, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"chmod(%s,%04o) failed", path, mode);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid chmod(%s,%04o) return value %d", path, mode,
+			rval);
 	}
 
 	return rval;
@@ -574,9 +658,12 @@ int safe_fchmod(const char *file, const int lineno,
 	rval = fchmod(fd, mode);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: fchmod(%d,0%o) failed",
-			 file, lineno, fd, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"fchmod(%d,0%o) failed", fd, mode);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid fchmod(%d,0%o) return value %d", fd, mode,
+			rval);
 	}
 
 	return rval;
@@ -590,9 +677,12 @@ int safe_chown(const char *file, const int lineno, void (cleanup_fn)(void),
 	rval = chown(path, owner, group);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"%s:%d: chown(%s,%d,%d) failed",
-			file, lineno, path, owner, group);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"chown(%s,%d,%d) failed", path, owner, group);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid chown(%s,%d,%d) return value %d", path,
+			owner, group, rval);
 	}
 
 	return rval;
@@ -606,9 +696,12 @@ int safe_fchown(const char *file, const int lineno, void (cleanup_fn)(void),
 	rval = fchown(fd, owner, group);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: fchown(%d,%d,%d) failed",
-			 file, lineno, fd, owner, group);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"fchown(%d,%d,%d) failed", fd, owner, group);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid fchown(%d,%d,%d) return value %d", fd,
+			owner, group, rval);
 	}
 
 	return rval;
@@ -620,10 +713,13 @@ pid_t safe_wait(const char *file, const int lineno, void (cleanup_fn)(void),
 	pid_t rval;
 
 	rval = wait(status);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: wait(%p) failed",
-			 file, lineno, status);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"wait(%p) failed", status);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid wait(%p) return value %d", status, rval);
 	}
 
 	return rval;
@@ -635,10 +731,14 @@ pid_t safe_waitpid(const char *file, const int lineno, void (cleanup_fn)(void),
 	pid_t rval;
 
 	rval = waitpid(pid, status, opts);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: waitpid(%d,%p,%d) failed",
-			 file, lineno, pid, status, opts);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"waitpid(%d,%p,%d) failed", pid, status, opts);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid waitpid(%d,%p,%d) return value %d", pid,
+			status, opts, rval);
 	}
 
 	return rval;
@@ -650,9 +750,11 @@ void *safe_memalign(const char *file, const int lineno,
 	void *rval;
 
 	rval = memalign(alignment, size);
-	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "memalign failed@%s:%d",
-			 file, lineno);
+
+	if (rval == NULL) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"memalign() failed");
+	}
 
 	return rval;
 }
@@ -665,9 +767,12 @@ int safe_kill(const char *file, const int lineno, void (cleanup_fn)(void),
 	rval = kill(pid, sig);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: kill(%d,%s) failed",
-			 file, lineno, pid, tst_strsig(sig));
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"kill(%d,%s) failed", pid, tst_strsig(sig));
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid kill(%d,%s) return value %d", pid,
+			tst_strsig(sig), rval);
 	}
 
 	return rval;
@@ -681,9 +786,12 @@ int safe_mkfifo(const char *file, const int lineno,
 	rval = mkfifo(pathname, mode);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: mkfifo(%s, 0%o) failed",
-			 file, lineno, pathname, mode);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"mkfifo(%s, %04o) failed", pathname, mode);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid mkfifo(%s, %04o) return value %d", pathname,
+			mode, rval);
 	}
 
 	return rval;
@@ -697,9 +805,12 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 	rval = rename(oldpath, newpath);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: rename(%s, %s) failed",
-			 file, lineno, oldpath, newpath);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"rename(%s, %s) failed", oldpath, newpath);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid rename(%s, %s) return value %d", oldpath,
+			newpath, rval);
 	}
 
 	return rval;
@@ -730,7 +841,7 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *filesystemtype, unsigned long mountflags,
 	       const void *data)
 {
-	int rval;
+	int rval = -1;
 
 	/*
 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
@@ -752,25 +863,29 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	if (possibly_fuse(filesystemtype)) {
 		char buf[1024];
 
-		tst_resm(TINFO, "Trying FUSE...");
+		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
 		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
-			 filesystemtype, source, target);
+			filesystemtype, source, target);
 
 		rval = tst_system(buf);
 		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
 			return 0;
 
-		tst_brkm(TBROK, cleanup_fn, "mount.%s failed with %i",
-			 filesystemtype, rval);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"mount.%s failed with %i", filesystemtype, rval);
 		return -1;
+	} else if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"mount(%s, %s, %s, %lu, %p) failed", source, target,
+			filesystemtype, mountflags, data);
 	} else {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: mount(%s, %s, %s, %lu, %p) failed",
-			 file, lineno, source, target, filesystemtype,
-			 mountflags, data);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid mount(%s, %s, %s, %lu, %p) return value %d",
+			source, target, filesystemtype, mountflags, data,
+			rval);
 	}
 
-	return -1;
+	return rval;
 }
 
 int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
@@ -781,9 +896,11 @@ int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	rval = tst_umount(target);
 
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: umount(%s) failed",
-			 file, lineno, target);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"umount(%s) failed", target);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Invalid umount(%s) return value %d", target, rval);
 	}
 
 	return rval;
@@ -797,8 +914,8 @@ DIR* safe_opendir(const char *file, const int lineno, void (cleanup_fn)(void),
 	rval = opendir(name);
 
 	if (!rval) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: opendir(%s) failed", file, lineno, name);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"opendir(%s) failed", name);
 	}
 
 	return rval;
@@ -812,8 +929,8 @@ int safe_closedir(const char *file, const int lineno, void (cleanup_fn)(void),
 	rval = closedir(dirp);
 
 	if (rval) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: closedir(%p) failed", file, lineno, dirp);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"closedir(%p) failed", dirp);
 	}
 
 	return rval;
@@ -829,8 +946,8 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 	rval = readdir(dirp);
 
 	if (!rval && errno) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "%s:%d: readdir(%p) failed", file, lineno, dirp);
+		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"readdir(%p) failed", dirp);
 	}
 
 	errno = err;
@@ -843,10 +960,14 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 
 	errno = 0;
 	rval = getpriority(which, who);
-	if (errno) {
-		tst_brkm(TBROK | TERRNO, NULL,
-		         "%s:%d getpriority(%i, %i) failed",
-			 file, lineno, which, who);
+
+	if (rval == -1 && errno) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"getpriority(%i, %i) failed", which, who);
+	} else if (errno) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"getpriority(%i, %i) failed with return value %d",
+			which, who, rval);
 	}
 
 	errno = err;
@@ -862,14 +983,18 @@ ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
 
 	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				 "%s:%d: no xattr support in fs or mounted "
-				 "without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: getxattr(%s, %s, %p, %zu) failed",
-			 file, lineno, path, name, value, size);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"getxattr(%s, %s, %p, %zu) failed",
+			path, name, value, size);
+	} else if (rval < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid getxattr(%s, %s, %p, %zu) return value %zd",
+			path, name, value, size, rval);
 	}
 
 	return rval;
@@ -882,16 +1007,20 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 
 	rval = setxattr(path, name, value, size, flags);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				 "%s:%d: no xattr support in fs or mounted "
-				 "without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: setxattr(%s, %s, %p, %zu) failed",
-			 file, lineno, path, name, value, size);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"setxattr(%s, %s, %p, %zu) failed",
+			path, name, value, size);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid setxattr(%s, %s, %p, %zu) return value %d",
+			path, name, value, size, rval);
 	}
 
 	return rval;
@@ -904,16 +1033,20 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 
 	rval = lsetxattr(path, name, value, size, flags);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				 "%s:%d: no xattr support in fs or mounted "
-				 "without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: lsetxattr(%s, %s, %p, %zu, %i) failed",
-			 file, lineno, path, name, value, size, flags);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"lsetxattr(%s, %s, %p, %zu, %i) failed",
+			path, name, value, size, flags);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid lsetxattr(%s, %s, %p, %zu, %i) return "
+			"value %d", path, name, value, size, flags, rval);
 	}
 
 	return rval;
@@ -926,16 +1059,20 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 
 	rval = fsetxattr(fd, name, value, size, flags);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				 "%s:%d: no xattr support in fs or mounted "
-				 "without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: fsetxattr(%i, %s, %p, %zu, %i) failed",
-			 file, lineno, fd, name, value, size, flags);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"fsetxattr(%i, %s, %p, %zu, %i) failed",
+			fd, name, value, size, flags);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid fsetxattr(%i, %s, %p, %zu, %i) return "
+			"value %d", fd, name, value, size, flags, rval);
 	}
 
 	return rval;
@@ -948,16 +1085,19 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 
 	rval = removexattr(path, name);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				"%s:%d: no xattr support in fs or mounted "
-				"without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: removexattr(%s, %s) failed",
-			 file, lineno, path, name);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"removexattr(%s, %s) failed", path, name);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid removexattr(%s, %s) return value %d", path,
+			name, rval);
 	}
 
 	return rval;
@@ -970,16 +1110,19 @@ int safe_lremovexattr(const char *file, const int lineno, const char *path,
 
 	rval = lremovexattr(path, name);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				"%s:%d: no xattr support in fs or mounted "
-				"without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: lremovexattr(%s, %s) failed",
-			 file, lineno, path, name);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"lremovexattr(%s, %s) failed", path, name);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid lremovexattr(%s, %s) return value %d", path,
+			name, rval);
 	}
 
 	return rval;
@@ -992,16 +1135,19 @@ int safe_fremovexattr(const char *file, const int lineno, int fd,
 
 	rval = fremovexattr(fd, name);
 
-	if (rval) {
+	if (rval == -1) {
 		if (errno == ENOTSUP) {
-			tst_brkm(TCONF, NULL,
-				"%s:%d: no xattr support in fs or mounted "
-				"without user_xattr option", file, lineno);
+			tst_brkm_(file, lineno, TCONF, NULL,
+				"no xattr support in fs or mounted "
+				"without user_xattr option");
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: fremovexattr(%i, %s) failed",
-			 file, lineno, fd, name);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"fremovexattr(%i, %s) failed", fd, name);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid fremovexattr(%i, %s) return value %d", fd,
+			name, rval);
 	}
 
 	return rval;
@@ -1013,9 +1159,12 @@ int safe_fsync(const char *file, const int lineno, int fd)
 
 	rval = fsync(fd);
 
-	if (rval) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			"%s:%d: fsync(%i) failed", file, lineno, fd);
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"fsync(%i) failed", fd);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid fsync(%i) return value %d", fd, rval);
 	}
 
 	return rval;
@@ -1026,9 +1175,10 @@ pid_t safe_setsid(const char *file, const int lineno)
 	pid_t rval;
 
 	rval = setsid();
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: setsid() failed", file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"setsid() failed");
 	}
 
 	return rval;
@@ -1040,9 +1190,13 @@ int safe_mknod(const char *file, const int lineno, const char *pathname,
 	int rval;
 
 	rval = mknod(pathname, mode, dev);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: mknod() failed", file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"mknod() failed");
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid mknod() return value %d", rval);
 	}
 
 	return rval;
@@ -1054,9 +1208,13 @@ int safe_mlock(const char *file, const int lineno, const void *addr,
 	int rval;
 
 	rval = mlock(addr, len);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: mlock() failed", file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"mlock() failed");
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid mlock() return value %d", rval);
 	}
 
 	return rval;
@@ -1068,9 +1226,13 @@ int safe_munlock(const char *file, const int lineno, const void *addr,
 	int rval;
 
 	rval = munlock(addr, len);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: munlock() failed", file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"munlock() failed");
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid munlock() return value %d", rval);
 	}
 
 	return rval;
@@ -1082,9 +1244,13 @@ int safe_mincore(const char *file, const int lineno, void *start,
 	int rval;
 
 	rval = mincore(start, length, vec);
+
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "%s:%d: mincore() failed", file, lineno);
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"mincore() failed");
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid mincore() return value %d", rval);
 	}
 
 	return rval;
-- 
2.28.0

