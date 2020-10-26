From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:38 +0100
Subject: [LTP] [PATCH 01/19] Unify error handling in lib/tst_safe_macros.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check for invalid syscall return values, don't ignore silently
- Always return syscall result so that all SAFE_*() functions can be called
  in test cleanup

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h |  30 ++++----
 lib/tst_safe_macros.c     | 154 ++++++++++++++++++++++++++++++--------
 2 files changed, 137 insertions(+), 47 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index fd0fcd278..42d923370 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -130,7 +130,7 @@ int safe_setreuid(const char *file, const int lineno,
 int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid);
 
 #define SAFE_SETPGID(pid, pgid) \
-	safe_setpgid(__FILE__, __LINE__, (pid), (pgid));
+	safe_setpgid(__FILE__, __LINE__, (pid), (pgid))
 
 pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 
@@ -141,7 +141,7 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 	safe_unlink(__FILE__, __LINE__, NULL, (pathname))
 
 #define SAFE_LINK(oldpath, newpath) \
-        safe_link(__FILE__, __LINE__, NULL, (oldpath), (newpath))
+	safe_link(__FILE__, __LINE__, NULL, (oldpath), (newpath))
 
 #define SAFE_LINKAT(olddirfd, oldpath, newdirfd, newpath, flags) \
 	safe_linkat(__FILE__, __LINE__, NULL, (olddirfd), (oldpath), \
@@ -151,7 +151,7 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 	safe_readlink(__FILE__, __LINE__, NULL, (path), (buf), (bufsize))
 
 #define SAFE_SYMLINK(oldpath, newpath) \
-        safe_symlink(__FILE__, __LINE__, NULL, (oldpath), (newpath))
+	safe_symlink(__FILE__, __LINE__, NULL, (oldpath), (newpath))
 
 #define SAFE_WRITE(len_strict, fildes, buf, nbyte) \
 	safe_write(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
@@ -178,10 +178,10 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 	safe_fchown(__FILE__, __LINE__, NULL, (fd), (owner), (group))
 
 #define SAFE_WAIT(status) \
-        safe_wait(__FILE__, __LINE__, NULL, (status))
+	safe_wait(__FILE__, __LINE__, NULL, (status))
 
 #define SAFE_WAITPID(pid, status, opts) \
-        safe_waitpid(__FILE__, __LINE__, NULL, (pid), (status), (opts))
+	safe_waitpid(__FILE__, __LINE__, NULL, (pid), (status), (opts))
 
 #define SAFE_KILL(pid, sig) \
 	safe_kill(__FILE__, __LINE__, NULL, (pid), (sig))
@@ -350,7 +350,7 @@ static inline int safe_statfs(const char *file, const int lineno,
 	return rval;
 }
 #define SAFE_STATFS(path, buf) \
-        safe_statfs(__FILE__, __LINE__, (path), (buf))
+	safe_statfs(__FILE__, __LINE__, (path), (buf))
 
 static inline off_t safe_lseek(const char *file, const int lineno,
                                int fd, off_t offset, int whence)
@@ -432,32 +432,32 @@ int safe_sigaction(const char *file, const int lineno,
 #define SAFE_SIGACTION(signum, act, oldact) \
 	safe_sigaction(__FILE__, __LINE__, (signum), (act), (oldact))
 
-void safe_sigaddset(const char *file, const int lineno,
+int safe_sigaddset(const char *file, const int lineno,
                     sigset_t *sigs, int signo);
 #define SAFE_SIGADDSET(sigs, signo) \
 	safe_sigaddset(__FILE__, __LINE__, (sigs), (signo))
 
-void safe_sigdelset(const char *file, const int lineno,
+int safe_sigdelset(const char *file, const int lineno,
                     sigset_t *sigs, int signo);
 #define SAFE_SIGDELSET(sigs, signo) \
 	safe_sigdelset(__FILE__, __LINE__, (sigs), (signo))
 
-void safe_sigemptyset(const char *file, const int lineno,
+int safe_sigemptyset(const char *file, const int lineno,
                       sigset_t *sigs);
 #define SAFE_SIGEMPTYSET(sigs) \
 	safe_sigemptyset(__FILE__, __LINE__, (sigs))
 
-void safe_sigfillset(const char *file, const int lineno,
+int safe_sigfillset(const char *file, const int lineno,
 		     sigset_t *sigs);
 #define SAFE_SIGFILLSET(sigs) \
 	safe_sigfillset(__FILE__, __LINE__, (sigs))
 
-void safe_sigprocmask(const char *file, const int lineno,
+int safe_sigprocmask(const char *file, const int lineno,
                       int how, sigset_t *set, sigset_t *oldset);
 #define SAFE_SIGPROCMASK(how, set, oldset) \
 	safe_sigprocmask(__FILE__, __LINE__, (how), (set), (oldset))
 
-void safe_sigwait(const char *file, const int lineno,
+int safe_sigwait(const char *file, const int lineno,
                   sigset_t *set, int *sig);
 #define SAFE_SIGWAIT(set, sig) \
 	safe_sigwait(__FILE__, __LINE__, (set), (sig))
@@ -563,11 +563,11 @@ int safe_personality(const char *filename, unsigned int lineno,
 	}							\
 	} while (0)
 
-void safe_unshare(const char *file, const int lineno, int flags);
+int safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
-void safe_setns(const char *file, const int lineno, int fd, int nstype);
-#define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype));
+int safe_setns(const char *file, const int lineno, int fd, int nstype);
+#define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype))
 
 static inline void safe_cmd(const char *file, const int lineno, const char *const argv[],
 				  const char *stdout_path, const char *stderr_path)
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 41b2141d7..dd7f604eb 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -23,10 +23,14 @@ int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
 	int rval;
 
 	rval = setpgid(pid, pgid);
-	if (rval) {
-		tst_brk(TBROK | TERRNO,
-		        "%s:%d: setpgid(%i, %i) failed",
-			file, lineno, pid, pgid);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setpgid(%i, %i) failed", pid, pgid);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setpgid(%i, %i) return value %d", pid, pgid,
+			rval);
 	}
 
 	return rval;
@@ -37,9 +41,13 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
 	pid_t pgid;
 
 	pgid = getpgid(pid);
+
 	if (pgid == -1) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: getpgid(%i) failed", file, lineno, pid);
+		tst_brk_(file, lineno, TBROK | TERRNO, "getpgid(%i) failed",
+			pid);
+	} else if (pgid < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid getpgid(%i) return value %d", pid, pgid);
 	}
 
 	return pgid;
@@ -50,9 +58,13 @@ int safe_personality(const char *filename, unsigned int lineno,
 {
 	int prev_persona = personality(persona);
 
-	if (prev_persona < 0) {
+	if (prev_persona == -1) {
 		tst_brk_(filename, lineno, TBROK | TERRNO,
 			 "persona(%ld) failed", persona);
+	} else if (prev_persona < 0) {
+		tst_brk_(filename, lineno, TBROK | TERRNO,
+			 "Invalid persona(%ld) return value %d", persona,
+			 prev_persona);
 	}
 
 	return prev_persona;
@@ -64,10 +76,14 @@ int safe_setregid(const char *file, const int lineno,
 	int rval;
 
 	rval = setregid(rgid, egid);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "setregid(%li, %li) failed",
-			 (long)rgid, (long)egid);
+			 "setregid(%li, %li) failed", (long)rgid, (long)egid);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid setregid(%li, %li) return value %d",
+			 (long)rgid, (long)egid, rval);
 	}
 
 	return rval;
@@ -79,10 +95,14 @@ int safe_setreuid(const char *file, const int lineno,
 	int rval;
 
 	rval = setreuid(ruid, euid);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "setreuid(%li, %li) failed",
-			 (long)ruid, (long)euid);
+			 "setreuid(%li, %li) failed", (long)ruid, (long)euid);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid setreuid(%li, %li) return value %d",
+			 (long)ruid, (long)euid, rval);
 	}
 
 	return rval;
@@ -101,55 +121,87 @@ int safe_sigaction(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"sigaction(%s (%d), %p, %p) failed",
 			tst_strsig(signum), signum, act, oldact);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigaction(%s (%d), %p, %p) return value %d",
+			tst_strsig(signum), signum, act, oldact, rval);
 	}
 
 	return rval;
 }
 
-void safe_sigaddset(const char *file, const int lineno,
+int safe_sigaddset(const char *file, const int lineno,
                     sigset_t *sigs, int signo)
 {
 	int rval;
 
 	rval = sigaddset(sigs, signo);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "sigaddset() %s (%i) failed",
-			 tst_strsig(signo), signo);
+			"sigaddset() %s (%i) failed", tst_strsig(signo),
+			signo);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigaddset() %s (%i) return value %d",
+			tst_strsig(signo), signo, rval);
 	}
+
+	return rval;
 }
 
-void safe_sigdelset(const char *file, const int lineno,
+int safe_sigdelset(const char *file, const int lineno,
                     sigset_t *sigs, int signo)
 {
 	int rval;
 
 	rval = sigdelset(sigs, signo);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "sigdelset() %s (%i) failed",
-			 tst_strsig(signo), signo);
+			"sigdelset() %s (%i) failed", tst_strsig(signo),
+			signo);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigdelset() %s (%i) return value %d",
+			tst_strsig(signo), signo, rval);
 	}
+
+	return rval;
 }
 
-void safe_sigemptyset(const char *file, const int lineno,
+int safe_sigemptyset(const char *file, const int lineno,
                       sigset_t *sigs)
 {
 	int rval;
 
 	rval = sigemptyset(sigs);
-	if (rval == -1)
+
+	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigemptyset() return value %d", rval);
+	}
+
+	return rval;
 }
 
-void safe_sigfillset(const char *file, const int lineno,
+int safe_sigfillset(const char *file, const int lineno,
 		     sigset_t *sigs)
 {
 	int rval;
 
 	rval = sigfillset(sigs);
-	if (rval == -1)
+
+	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO, "sigfillset() failed");
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigfillset() return value %d", rval);
+	}
+
+	return rval;
 }
 
 static const char *strhow(int how)
@@ -166,28 +218,44 @@ static const char *strhow(int how)
 	}
 }
 
-void safe_sigprocmask(const char *file, const int lineno,
+int safe_sigprocmask(const char *file, const int lineno,
                       int how, sigset_t *set, sigset_t *oldset)
 {
 	int rval;
 
 	rval = sigprocmask(how, set, oldset);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "sigprocmask(%s, %p, %p)", strhow(how), set, oldset);
+			"sigprocmask(%s, %p, %p) failed", strhow(how), set,
+			oldset);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid sigprocmask(%s, %p, %p) return value %d",
+			strhow(how), set, oldset, rval);
 	}
+
+	return rval;
 }
 
-void safe_sigwait(const char *file, const int lineno,
+int safe_sigwait(const char *file, const int lineno,
                   sigset_t *set, int *sig)
 {
 	int rval;
 
 	rval = sigwait(set, sig);
-	if (rval != 0) {
+
+	if (rval > 0) {
 		errno = rval;
-		tst_brk_(file, lineno, TBROK, "sigwait(%p, %p)", set, sig);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"sigwait(%p, %p) failed", set, sig);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			"Invalid sigwait(%p, %p) return value %d", set, sig,
+			rval);
 	}
+
+	return rval;
 }
 
 struct group *safe_getgrnam(const char *file, const int lineno,
@@ -241,19 +309,24 @@ int safe_chroot(const char *file, const int lineno, const char *path)
 	int rval;
 
 	rval = chroot(path);
+
 	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "chroot(%s) failed",
+			path);
+	} else if (rval) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "chroot(%s) failed", path);
+			 "Invalid chroot(%s) return value %d", path, rval);
 	}
 
 	return rval;
 }
 
-void safe_unshare(const char *file, const int lineno, int flags)
+int safe_unshare(const char *file, const int lineno, int flags)
 {
 	int res;
 
 	res = unshare(flags);
+
 	if (res == -1) {
 		if (errno == EINVAL) {
 			tst_brk_(file, lineno, TCONF | TERRNO,
@@ -262,18 +335,30 @@ void safe_unshare(const char *file, const int lineno, int flags)
 			tst_brk_(file, lineno, TBROK | TERRNO,
 				 "unshare(%d) failed", flags);
 		}
+	} else if (res) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid unshare(%d) return value %d", flags, res);
 	}
+
+	return res;
 }
 
-void safe_setns(const char *file, const int lineno, int fd, int nstype)
+int safe_setns(const char *file, const int lineno, int fd, int nstype)
 {
 	int ret;
 
 	ret = setns(fd, nstype);
+
 	if (ret == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO, "setns(%i, %i) failed",
-		         fd, nstype);
+			fd, nstype);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setns(%i, %i) return value %d", fd, nstype,
+			ret);
 	}
+
+	return ret;
 }
 
 long tst_safe_ptrace(const char *file, const int lineno, int req, pid_t pid,
@@ -299,10 +384,15 @@ int safe_pipe2(const char *file, const int lineno, int fildes[2], int flags)
 	int ret;
 
 	ret = pipe2(fildes, flags);
+
 	if (ret == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			"pipe2({%d,%d}) failed with flag(%d)",
-			fildes[0], fildes[1], flags);
+			"pipe2({%d,%d}) failed with flag(%d)", fildes[0],
+			fildes[1], flags);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid pipe2({%d,%d}, %d) return value %d",
+			fildes[0], fildes[1], flags, ret);
 	}
 
 	return ret;
-- 
2.28.0

