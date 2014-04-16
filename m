Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WaTdP-0004Ey-C3
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 17:28:31 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WaTdN-0004me-00
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 17:28:31 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Wed, 16 Apr 2014 19:27:58 +0200
Message-ID: <1397669278-848-2-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1397669278-848-1-git-send-email-mats.liljegren@enea.com>
References: <20140416091527.40612b3c@mats-desktop>
	<1397669278-848-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Make SAFE_* calls more informative when failing
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The output has been "standardized" into the following format:
<file>:<line>: <func>(<params>) <error message>

E.g.:
test.c:130: chdir(mydir) failed

This will then be followed by the usual errno stuff if applicable.

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 lib/safe_macros.c |  170 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 100 insertions(+), 70 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 6f85c11..4be4fc2 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -20,8 +20,9 @@ char *safe_basename(const char *file, const int lineno,
 
 	rval = basename(path);
 	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "basename failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: basename(%s) failed",
+			 file, lineno, path);
 
 	return (rval);
 }
@@ -34,8 +35,9 @@ safe_chdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = chdir(path);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "chdir failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: chdir(%s) failed",
+			 file, lineno, path);
 
 	return (rval);
 }
@@ -48,8 +50,9 @@ safe_close(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = close(fildes);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "close failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: close(%d) failed",
+			 file, lineno, fildes);
 
 	return (rval);
 }
@@ -62,8 +65,9 @@ safe_creat(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = creat(pathname, mode);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "creat failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: creat(%s,%d) failed",
+			 file, lineno, pathname, mode);
 
 	return (rval);
 }
@@ -75,8 +79,9 @@ char *safe_dirname(const char *file, const int lineno,
 
 	rval = dirname(path);
 	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "dirname failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: dirname(%s) failed",
+			 file, lineno, path);
 
 	return (rval);
 }
@@ -88,8 +93,9 @@ char *safe_getcwd(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = getcwd(buf, size);
 	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "getcwd failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getcwd(%p,%zu) failed",
+			 file, lineno, buf, size);
 
 	return (rval);
 }
@@ -101,8 +107,9 @@ struct passwd *safe_getpwnam(const char *file, const int lineno,
 
 	rval = getpwnam(name);
 	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "getpwnam failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: getpwnam(%s) failed",
+			 file, lineno, name);
 
 	return (rval);
 }
@@ -116,7 +123,8 @@ safe_getrusage(const char *file, const int lineno, void (*cleanup_fn) (void),
 	rval = getrusage(who, usage);
 	if (rval == -1)
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "getrusage failed at %s:%d", file, lineno);
+			 "%s:%d: getrusage(%d,%p) failed",
+			 file, lineno, who, usage);
 
 	return rval;
 }
@@ -128,8 +136,9 @@ void *safe_malloc(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = malloc(size);
 	if (rval == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "malloc failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: malloc(%zu) failed",
+			 file, lineno, size);
 
 	return (rval);
 }
@@ -142,8 +151,9 @@ safe_mkdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = mkdir(pathname, mode);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "mkdir failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: mkdir(%s,0%o) failed",
+			 file, lineno, pathname, mode);
 
 	return (rval);
 }
@@ -156,8 +166,10 @@ void *safe_mmap(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = mmap(addr, length, prot, flags, fd, offset);
 	if (rval == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "mmap failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: mmap(%p,%zu,%d,%d,%d,%ld) failed",
+			 file, lineno, addr, length, prot, flags, fd,
+			 (long) offset);
 
 	return (rval);
 }
@@ -170,8 +182,9 @@ safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = munmap(addr, length);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "munmap failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: munmap(%p,%zu) failed",
+			 file, lineno, addr, length);
 
 	return (rval);
 }
@@ -190,8 +203,9 @@ safe_open(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = open(pathname, oflags, mode);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "open failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: open(%s,%d) failed",
+			 file, lineno, pathname, oflags);
 
 	return (rval);
 }
@@ -204,8 +218,9 @@ safe_pipe(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = pipe(fildes);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "pipe failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: pipe({%d,%d}) failed",
+			 file, lineno, fildes[0], fildes[1]);
 
 	return (rval);
 }
@@ -218,8 +233,9 @@ safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = read(fildes, buf, nbyte);
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte))
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "read failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: read(%d,%p,%zu) failed, returned %zd",
+			 file, lineno, fildes, buf, nbyte, rval);
 
 	return (rval);
 }
@@ -232,8 +248,9 @@ safe_setegid(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = setegid(egid);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "setegid failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: setegid(%u) failed",
+			 file, lineno, (unsigned) egid);
 
 	return (rval);
 }
@@ -246,8 +263,9 @@ safe_seteuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = seteuid(euid);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "seteuid failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: seteuid(%u) failed",
+			 file, lineno, (unsigned) euid);
 
 	return (rval);
 }
@@ -260,8 +278,9 @@ safe_setgid(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = setgid(gid);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "setgid failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: setgid(%u) failed",
+			 file, lineno, (unsigned) gid);
 
 	return (rval);
 }
@@ -274,8 +293,9 @@ safe_setuid(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = setuid(uid);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "setuid failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: setuid(%u) failed",
+			 file, lineno, (unsigned) uid);
 
 	return (rval);
 }
@@ -288,8 +308,9 @@ safe_unlink(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = unlink(pathname);
 	if (rval == -1)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "unlink failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: unlink(%s) failed",
+			 file, lineno, pathname);
 
 	return (rval);
 }
@@ -305,8 +326,8 @@ int safe_link(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "link(%s, %s) failed at %s:%d",
-			 oldpath, newpath, file, lineno);
+		         "%s:%d: link(%s, %s) failed",
+			 file, lineno, oldpath, newpath);
 	}
 
 	return rval;
@@ -322,8 +343,8 @@ off_t safe_lseek(const char *file, const int lineno,
 
 	if (rval == (off_t) -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "lseek(%i, %li, %i) failed at %s:%d",
-		         fd, (long)offset, whence, file, lineno);
+		         "%s:%d: lseek(%i, %li, %i) failed",
+			 file, lineno, fd, (long)offset, whence);
 	}
 
 	return rval;
@@ -339,8 +360,8 @@ int safe_symlink(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "link(%s, %s) failed at %s:%d",
-			 oldpath, newpath, file, lineno);
+		         "%s:%d: link(%s, %s) failed",
+			 file, lineno, oldpath, newpath);
 	}
 
 	return rval;
@@ -354,8 +375,9 @@ safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
 
 	rval = write(fildes, buf, nbyte);
 	if ((len_strict == 0 && rval == -1) || (size_t)rval != nbyte)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "write failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: write(%d, %p, %zu) failed",
+			file, lineno, fildes, buf, rval);
 
 	return (rval);
 }
@@ -368,7 +390,8 @@ int safe_ftruncate(const char *file, const int lineno,
 	rval = ftruncate(fd, length);
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "ftruncate failed at %s:%d", file, lineno);
+			 "%s:%d: ftruncate(%d, %ld) failed",
+			 file, lineno, fd, (long) length);
 	}
 
 	return rval;
@@ -381,8 +404,9 @@ int safe_truncate(const char *file, const int lineno,
 
 	rval = truncate(path, length);
 	if (rval == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "truncate failed at %s:%d",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: truncate(%s,%ld) failed",
+			 file, lineno, path, length);
 	}
 
 	return rval;
@@ -399,14 +423,14 @@ long safe_strtol(const char *file, const int lineno,
 	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
 	    || (errno != 0 && rval == 0))
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "strtol failed at %s:%d", file, lineno);
-	if (rval > max || rval < min)
-		tst_brkm(TBROK, cleanup_fn,
-			 "converted value out of range (%ld - %ld) at %s:%d",
-			 min, max, file, lineno);
+			 "%s:%d: strtol(%s) failed", file, lineno, str);
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
 		tst_brkm(TBROK, cleanup_fn,
-			 "Invalid value: '%s' at %s:%d", str, file, lineno);
+			 "%s:%d: strtol(%s): Invalid value", file, lineno, str);
+	if (rval > max || rval < min)
+		tst_brkm(TBROK, cleanup_fn,
+			 "%s:%d: strtol(%s): converted value %ld is out of range %ld - %ld",
+			 file, lineno, str, rval, min, max);
 
 	return rval;
 }
@@ -423,11 +447,11 @@ unsigned long safe_strtoul(const char *file, const int lineno,
 	if ((errno == ERANGE && rval == ULONG_MAX)
 	    || (errno != 0 && rval == 0))
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "strtol failed at %s:%d", file, lineno);
+			 "%s:%d: strtoul(%s) failed", file, lineno, str);
 	if (rval > max || rval < min)
 		tst_brkm(TBROK, cleanup_fn,
-			 "converted value out of range (%lu - %lu at %s:%d",
-			 min, max, file, lineno);
+			 "%s:%d: strtoul(%s): converted value %lu is out of range %lu - %lu",
+			 file, lineno, str, rval, min, max);
 	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
 		tst_brkm(TBROK, cleanup_fn,
 			 "Invalid value: '%s' at %s:%d", str, file, lineno);
@@ -446,11 +470,13 @@ long safe_sysconf(const char *file, const int lineno,
 	if (rval == -1) {
 		if (errno == EINVAL)
 			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "sysconf failed at %s:%d", file, lineno);
+				 "%s:%d: sysconf(%d) failed",
+				 file, lineno, name);
 		else
-			tst_resm(TINFO, "queried option is not available"
-				 " or thers is no definite limit at %s:%d",
-				 file, lineno);
+			tst_resm(TINFO, "%s:%d: sysconf(%d): "
+				 "queried option is not available"
+				 " or there is no definite limit",
+				 file, lineno, name);
 	}
 
 	return rval;
@@ -465,7 +491,7 @@ int safe_stat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "stat failed at %s:%d", file, lineno);
+			 "%s:%d: stat(%s,%p) failed", file, lineno, path, buf);
 	}
 
 	return rval;
@@ -480,7 +506,7 @@ int safe_fstat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "fstat failed at %s:%d", file, lineno);
+			 "%s:%d: fstat(%d, %p) failed", file, lineno, fd, buf);
 	}
 
 	return rval;
@@ -495,7 +521,7 @@ int safe_lstat(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "lstat failed at %s:%d", file, lineno);
+			 "%s:%d: lstat(%s,%p) failed", file, lineno, path, buf);
 	}
 
 	return rval;
@@ -510,7 +536,8 @@ int safe_getrlimit(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "getrlimit failed at %s:%d", file, lineno);
+			 "%s:%d: getrlimit(%d,%p) failed",
+			 file, lineno, resource, rlim);
 	}
 
 	return rval;
@@ -525,7 +552,8 @@ int safe_setrlimit(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "setrlimit failed at %s:%d", file, lineno);
+			 "%s:%d: setrlimit(%d,%p) failed",
+			 file, lineno, resource, rlim);
 	}
 
 	return rval;
@@ -540,7 +568,8 @@ int safe_chmod(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "chmod failed at %s:%d", file, lineno);
+			 "%s:%d: chmod(%s,0%o) failed",
+			 file, lineno, path, mode);
 	}
 
 	return rval;
@@ -555,7 +584,8 @@ int safe_fchmod(const char *file, const int lineno,
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "fchmod failed at %s:%d", file, lineno);
+			 "%s:%d: fchmod(%d,0%o) failed",
+			 file, lineno, fd, mode);
 	}
 
 	return rval;
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
