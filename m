From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Jan 2017 16:47:08 +0100
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and pread()
 declarations
Message-ID: <20170102154707.GA30109@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes numerous "implicit function declaration" on slightly older
distributions where pwrite() and pread() needs to defined either of
_XOPEN_SOURCE or _GNU_SOURCE.

This is a bit hacky solution to the problem, but consider that:

o These functions has to be inlined in the header because the prototype
  contains off_t whose size depends on compile time settings

o Defining _GNU_SOURCE in the safe macros header is not a solution
  either since it has to be defined before we include any libc headers
  in order to take any effect

Also note that glibc uses __REDIRECT() assembler tricks or preprocessor
rename to pread64() and pwrite64() in case that large file support is
turned on but that should not matter to us since these functions are not
used in 99% of the testcases and these that use it has to define
_GNU_SOURCE either way and gets these tricks included, at least that is
the theory.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

This is the last patch that should fix the numerous "implicit function
declaration" warnings. Either we do this or we need to create a separate
safe_* header for the safe_pread and safe_pwrite. Or has anybody a
better idea?

 include/tst_safe_macros.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index df858be..b51c025 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -98,8 +98,11 @@ static inline int safe_dup(const char *file, const int lineno,
 	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
 /*
- * inline function that uses off_t since sizeof(off_t) depends on compile flags
+ * Fallback function definition, older glibc does not export it unless we
+ * define _XOPEN_SOURCE or _GNU_SOURCE.
  */
+ssize_t pread(int fd, void *buf, size_t count, off_t offset);
+
 static inline ssize_t safe_pread(const char *file, const int lineno,
 		char len_strict, int fildes, void *buf, size_t nbyte,
 		off_t offset)
@@ -167,6 +170,12 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 #define SAFE_WRITE(len_strict, fildes, buf, nbyte) \
 	safe_write(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
+/*
+ * Fallback function definition, older glibc does not export it unless we
+ * define _XOPEN_SOURCE or _GNU_SOURCE.
+ */
+ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset);
+
 static inline ssize_t safe_pwrite(const char *file, const int lineno,
 		char len_strict, int fildes, const void *buf, size_t nbyte,
 		off_t offset)
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
