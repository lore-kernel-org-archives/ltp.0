From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 22 Aug 2018 09:54:24 +0800
Subject: [LTP] [PATCH v2] syscalls/execveat03: Fix compiler errors
In-Reply-To: <1642007852.41615039.1534852963645.JavaMail.zimbra@redhat.com>
References: <1642007852.41615039.1534852963645.JavaMail.zimbra@redhat.com>
Message-ID: <1534902864-19343-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

According to open(2) and linkat(2) manpages, O_PATH and AT_EMPTY_PATH
flags were added since kernel v2.6.39, so these undefined flags led
to the following errors on older kernels(e.g. v2.6.32):
---------------------------------------------------------
execveat03.c:66: error: ‘O_PATH’ undeclared (first use in this function)
execveat03.c:69: error: ‘AT_EMPTY_PATH’ undeclared (first use in this function)
---------------------------------------------------------

1) Add AT_EMPTY_PATH into lapi/fcntl.h
2) Include lapi/fcntl.h in execveat03.c

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/fcntl.h                            | 4 ++++
 testcases/kernel/syscalls/execveat/execveat03.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 849439d..358230f 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -103,6 +103,10 @@
 # define AT_SYMLINK_NOFOLLOW 0x100
 #endif
 
+#ifndef AT_EMPTY_PATH
+# define AT_EMPTY_PATH 0x1000
+#endif
+
 #ifndef AT_REMOVEDIR
 # define AT_REMOVEDIR 0x200
 #endif
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index df27273..315620b 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -49,6 +49,7 @@
 #include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/execveat.h"
+#include "lapi/fcntl.h"
 
 #define OVL_MNT "ovl"
 #define TEST_APP "execveat_child"
-- 
1.8.3.1



