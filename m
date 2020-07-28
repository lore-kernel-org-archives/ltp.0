From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Jul 2020 13:33:03 +0200
Subject: [LTP] [PATCH COMMITTED] thp04: avoid warnings in cleanup()
Message-ID: <a5b38150d2d496927567ef574610fee6d1fd8dd4.1595935959.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't call munmap on read/write_thp when test TCONFs earlier:
  thp04.c:72: CONF: Kernel does not support huge pages
  safe_macros.c:202: WARN: thp04.c:146: munmap((nil),0) failed: EINVAL (22)
  safe_macros.c:202: WARN: thp04.c:147: munmap((nil),0) failed: EINVAL (22)

Successful call to alloc_zero_page() always returns address > 0,
so add a NULL check to cleanup().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/thp/thp04.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index d21f77e72de1..e71261c1d986 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -143,8 +143,10 @@ static void cleanup(void)
 	if (writefd >= 0)
 		SAFE_CLOSE(writefd);
 
-	SAFE_MUNMAP(read_thp, thp_size);
-	SAFE_MUNMAP(write_thp, thp_size);
+	if (read_thp)
+		SAFE_MUNMAP(read_thp, thp_size);
+	if (write_thp)
+		SAFE_MUNMAP(write_thp, thp_size);
 }
 
 static struct tst_test test = {
-- 
2.18.1

