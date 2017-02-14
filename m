From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 10:28:52 +0100
Subject: [LTP] [COMMITED] [PATCH 1/3] lib/tst_tmpdir.c: fix compilation with
	older libc
Message-ID: <20170214092854.26536-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Compilation fails because of undefined __USE_GNU on RHEL5.11GA.
So we need to define _GNU_SOURCE to make __USE_GNU defined.

This has been broken by commmit:

commit fc0c72a85a9de6a846587855c3c40394a6782616
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Feb 13 15:35:09 2017 +0100

lib: Move rmobj() to tst_tmpdir.c

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
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
2.10.2

