From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Sep 2018 12:48:13 +0800
Subject: [LTP] [PATCH] statx: fix compile errors with glibc<2.28
Message-ID: <20180919044813.22875-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

glibc 2.28 has shipped with a wrapper for the statx() system call.
Currently the build is broken against it, because sys/stat.h suddenly
declares all the same types that lapi/stat.h does.  Fix it by taking
the sys/stat.h ones if glibc>=2.28.

  include/lapi/stat.h:26:8: error: redefinition of ‘struct statx_timestamp’
  include/lapi/stat.h:73:8: error: redefinition of ‘struct statx’
---
 include/lapi/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 979e42d..7ba8618 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -20,7 +20,7 @@
  *
  * __reserved is held in case we need a yet finer resolution.
  */
-#if defined(HAVE_STRUCT_STATX_TIMESTAMP)
+#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 28)
 #include <sys/stat.h>
 #else
 struct statx_timestamp {
@@ -66,7 +66,7 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-#if defined(HAVE_STRUCT_STATX)
+#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 28)
 #include <sys/stat.h>
 #else
 struct statx {
-- 
2.9.5

