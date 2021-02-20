From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Feb 2021 12:37:24 +0000
Subject: [LTP] [PATCH] open_posix_testsuite: correct fork11-1 report log
Message-ID: <20210220123724.16939-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../open_posix_testsuite/conformance/interfaces/fork/11-1.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
index 8a7796cfd..e31f3896f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
@@ -47,7 +47,7 @@ static int child(int fd)
 
 	if (fcntl(fd, F_SETLK, &fl) == -1) {
 		if (errno == EACCES || errno == EAGAIN) {
-			printf("PASSED: child did not inherit the lock\n");
+			printf("PASSED: Child locked file already locked by parent\n");
 			return PTS_PASS;
 		}
 
@@ -56,7 +56,7 @@ static int child(int fd)
 		return PTS_UNRESOLVED;
 	}
 
-	printf("Child locked file already locked by parent\n");
+	printf("Child did not inherit the lock\n");
 	return PTS_FAIL;
 }
 
-- 
2.21.3

