From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Sep 2019 16:05:41 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/madvise09: Workaround failures
 on newer kernels
Message-ID: <20190913140541.2753-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a short term workaround that bumps the number of allocated pages
to 128 because which is needed since kernel commit:

1a61ab (mm: memcontrol: replace zone summing with lruvec_page_state())

After a discussion with kernel developers we concluded that in order to
avoid depending on kernel internal implementation details we have to
allocate a dozen of megabytes instead, but that would require a more
complex changes to the test. As we are getting close to a LTP release we
decided to put this workaround in first, then we can rewrite the test
after the release.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
Acked-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 01075f641..cd556920c 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -57,7 +57,7 @@ static int sleep_between_faults;
 
 static int swap_accounting_enabled;
 
-#define PAGES 32
+#define PAGES 128
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
 
-- 
2.21.0

