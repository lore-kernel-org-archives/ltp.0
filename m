From: Carlo Marcelo Arenas =?unknown-8bit?q?Bel=C3=B3n?= <carenas@gmail.com>
Date: Sat, 28 Oct 2017 07:21:30 -0700
Subject: [LTP] [PATCH] include: tab cleanup
Message-ID: <20171028142130.84069-1-carenas@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

odd location for using tabs where 1 space would be enough and more
consistent

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
---
 include/safe_macros_fn.h  | 4 ++--
 include/tst_safe_macros.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index dcea77573..3df952811 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -67,7 +67,7 @@ int safe_open(const char *file, const int lineno,
 int safe_pipe(const char *file, const int lineno,
               void (*cleanup_fn)(void), int fildes[2]);
=20
-ssize_t	safe_read(const char *file, const int lineno,
+ssize_t safe_read(const char *file, const int lineno,
                   void (*cleanup_fn)(void), char len_strict, int fildes,
                   void *buf, size_t nbyte);
=20
@@ -110,7 +110,7 @@ int safe_symlink(const char *file, const int lineno,
                  void (cleanup_fn)(void), const char *oldpath,
                  const char *newpath);
=20
-ssize_t	safe_write(const char *file, const int lineno,
+ssize_t safe_write(const char *file, const int lineno,
                    void (cleanup_fn)(void), char len_strict, int fildes,
                    const void *buf, size_t nbyte);
=20
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 95620050c..2e518d719 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -66,7 +66,7 @@ static inline int safe_dup(const char *file, const int li=
neno,
 #define SAFE_DUP(oldfd) \
 	safe_dup(__FILE__, __LINE__, (oldfd))
=20
-#define	SAFE_GETCWD(buf, size) \
+#define SAFE_GETCWD(buf, size) \
 	safe_getcwd(__FILE__, __LINE__, NULL, (buf), (size))
=20
 #define SAFE_GETPWNAM(name) \
--=20
2.14.3

