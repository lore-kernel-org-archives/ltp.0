From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon,  5 Apr 2021 15:23:22 +0300
Subject: [LTP] [PATCH v1] openposix/mmap/1-4: correct a typo
Message-ID: <20210405122322.23134-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A typo in the name of the temporary file:
     pts_mmap_11_5 -> pts_mmap_11_4

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 .../open_posix_testsuite/conformance/interfaces/mmap/11-4.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
index cb238b40e..45dc746f3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
@@ -66,7 +66,7 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_4");
 #ifdef	__linux__
 	struct statfs buf;
 
-- 
2.30.2

