From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 11:22:39 +0100
Subject: [LTP] [PATCH 1/1] configure.ac: More descriptive NUMA error message
Message-ID: <20210121102239.18643-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some people were confused and searched for libnuma.so.2,
which does not exist.

Required is libnuma.so.1, but with LIBNUMA_API_VERSION >= 2.
The API version is tighten to libnuma version in git, but that has
nothing to do with library soname version, which is still 1.0.0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e44e25cc6..521a2e835 100644
--- a/configure.ac
+++ b/configure.ac
@@ -347,7 +347,7 @@ LTP_CHECK_SYSCALL_FCNTL
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
-	numa_error_msg="test requires libnuma >= 2 and it's development packages"
+	numa_error_msg="test requires libnuma1 with LIBNUMA_API_VERSION >= 2 and it's development packages"
 else
 	numa_error_msg="NUMA support was disabled during build"
 fi
-- 
2.30.0

