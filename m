From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Sep 2015 13:06:51 +0800
Subject: [LTP] [PATCH] lib/mem.c: handle the case oom0{3,
	5} exit with EAGAIN situation
Message-ID: <1442380011-22409-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes oom0{3,5} failed as the following results:

oom05       0  TINFO  :  start OOM testing for mlocked pages.
oom05       0  TINFO  :  expected victim is 3371.
oom05       0  TINFO  :  thread (3fff788ff1c0), allocating 3221225472 bytes.
...
oom05       5  TFAIL  :  mem.c:153: victim unexpectedly ended with retcode: 11, expected: 12

In the OOM test, that tries to consume all memory. But the test doesn't retry to mlock, it simply
exits with errno returned by mlock. At the moment testcase is expecting either ENOMEM or getting
killed by kernel.

Here do retry the function if mlock() fail with 'EAGAIN' errno.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 8fe4bf0..dc9d958 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -39,8 +39,13 @@ static int alloc_mem(long int length, int testcase)
 	if (s == MAP_FAILED)
 		return errno;
 
-	if (testcase == MLOCK && mlock(s, length) == -1)
-		return errno;
+	if (testcase == MLOCK) {
+		while (mlock(s, length) == -1) {
+			if (EAGAIN != errno)
+				return errno;
+		}
+	}
+
 #ifdef HAVE_MADV_MERGEABLE
 	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
 		return errno;
-- 
1.8.3.1

