From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 13:26:36 +0100
Subject: [LTP] [PATCH 1/4] tst_test.h, test.h: Add mutual exclusion guards
Message-ID: <20170214122639.442-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These headers cannot be used at the same time, this makes sure they
aren't.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/test.h | 4 ++++
 include/tst_test.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/old/test.h b/include/old/test.h
index 209dc5b..2cb7b98 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -34,6 +34,10 @@
 #ifndef __TEST_H__
 #define __TEST_H__
 
+#ifdef TST_TEST_H__
+# error Newlib tst_test.h already included
+#endif /* TST_TEST_H__ */
+
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
diff --git a/include/tst_test.h b/include/tst_test.h
index 7dc371c..d8cc806 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -18,6 +18,10 @@
 #ifndef TST_TEST_H__
 #define TST_TEST_H__
 
+#ifdef __TEST_H__
+# error Oldlib test.h already included
+#endif /* __TEST_H__ */
+
 #include <unistd.h>
 
 #include "tst_common.h"
-- 
2.10.2

