From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Oct 2017 16:51:15 +0800
Subject: [LTP] [PATCH] configure: complete the full path in configure.ac
Message-ID: <20171026085115.28595-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix a error in cross-compilation:
./config.status: line 1311: cd: include/lapi/syscalls: No such file or directory
./config.status: line 1311: ./regen.sh: No such file or directory

Signed-off-by: Li Wang <liwang@redhat.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2356531..39818cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -139,7 +139,7 @@ fi
 
 AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
 
-AC_CONFIG_COMMANDS([syscalls.h], [cd include/lapi/syscalls; ./regen.sh])
+AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
 
 # END testsuites knobs
 LTP_CHECK_FORTIFY_SOURCE
-- 
2.9.3

