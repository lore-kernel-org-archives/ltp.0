From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 30 May 2018 12:40:45 -0300
Subject: [LTP] [PATCH] shmat() for 0 (or <PAGESIZE with RND flag) has to
	fail with REMAPs
Message-ID: <20180530154045.17803-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Rafael David Tinoco <rafael.tinoco@canonical.com>

Fixes: https://github.com/linux-test-project/ltp/issues/319

According to upstream thread (https://lkml.org/lkml/2018/5/28/2056),
cve-2017-5669 needs to address the "new" way of handling nil addresses
for shmat() when used with MAP_FIXED or SHM_REMAP flags.

- mapping nil-page is OK on lower addresses with MAP_FIXED (or else X11 is broken)
- mapping nil-page is NOT OK with SHM_REMAP on lower addresses

Addresses Davidlohr Bueso's comments/changes:

commit 8f89c007b6de
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri May 25 14:47:30 2018 -0700

    ipc/shm: fix shmat() nil address after round-down when remapping

commit a73ab244f0da
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri May 25 14:47:27 2018 -0700

    Revert "ipc/shm: Fix shmat mmap nil-page protection"

For previously test made based on:

commit 95e91b831f87
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Mon Feb 27 14:28:24 2017 -0800

    ipc/shm: Fix shmat mmap nil-page protection

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 testcases/cve/cve-2017-5669.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2017-5669.c b/testcases/cve/cve-2017-5669.c
index 1ca598326..16e4d80be 100644
--- a/testcases/cve/cve-2017-5669.c
+++ b/testcases/cve/cve-2017-5669.c
@@ -28,6 +28,9 @@
  * is just to see if we get an access error or some other unexpected behaviour.
  *
  * See commit 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ * See commit a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
+ * See commit 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
+ * See https://github.com/linux-test-project/ltp/issues/319
  */
 #include <sys/types.h>
 #include <sys/ipc.h>
@@ -60,7 +63,11 @@ static void cleanup(void)
 static void run(void)
 {
 	tst_res(TINFO, "Attempting to attach shared memory to null page");
-	shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
+	/*
+	 * shmat() for 0 (or < PAGESIZE with RND flag) has to fail with REMAPs
+	 * https://github.com/linux-test-project/ltp/issues/319
+	 */
+	shm_addr = shmat(shm_id, ((void *)1), SHM_RND | SHM_REMAP);
 	if (shm_addr == (void *)-1) {
 		shm_addr = NULL;
 		if (errno == EINVAL) {
-- 
2.17.1

