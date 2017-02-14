From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 14 Feb 2017 11:09:29 +0800
Subject: [LTP] [PATCH] lib/tst_tmpdir.c: fix compilation with older kernels
Message-ID: <1487041769-14292-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation fails because of undefined __USE_GNU on RHEL5.11GA.
So we need to define _GNU_SOURCE to make __USE_GNU defined.

This has been broken by commmit:

commit fc0c72a85a9de6a846587855c3c40394a6782616
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Feb 13 15:35:09 2017 +0100

	lib: Move rmobj() to tst_tmpdir.c

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_tmpdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 71ca3b9..405d377 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -56,7 +56,7 @@
  *		Neither tst_tmpdir() or tst_rmdir() has a return value.
  *
  *********************************************************/
-
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
1.8.3.1



