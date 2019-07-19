From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Jul 2019 14:08:05 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] syscalls/request_key05: Correct CVE
 number
Message-ID: <20190719120806.24214-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There was an typo in the comment that lists the CVE number.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/request_key/request_key05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/request_key/request_key05.c b/testcases/kernel/syscalls/request_key/request_key05.c
index aa2f3a7c6..129cc0507 100644
--- a/testcases/kernel/syscalls/request_key/request_key05.c
+++ b/testcases/kernel/syscalls/request_key/request_key05.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*
- * Test for CVE-2016-6951, original reproducer can be found here:
+ * Test for CVE-2017-6951, original reproducer can be found here:
  * http://www.spinics.net/lists/keyrings/msg01845.html
  *
  * request_key() is not in glibc, so we just use the syscall directly instead
-- 
2.21.0

