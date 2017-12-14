From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Dec 2017 15:23:06 +0300
Subject: [LTP] [PATCH V2 1/2] posix: aio_cancel: 5-1, 6-1,
	7-1: zero out the control block buffer
Message-ID: <1513254187-6528-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Per aio(7) it's recommended to zero out the control block buffer
before use to avoid possible failures due to uninitialized fields.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

Changes since V1:
 - use calloc()

 .../conformance/interfaces/aio_cancel/5-1.c        |    2 +-
 .../conformance/interfaces/aio_cancel/6-1.c        |    2 +-
 .../conformance/interfaces/aio_cancel/7-1.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index ece29ac..9d36c8b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -69,7 +69,7 @@ int main(void)
 	/* create AIO req */
 
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = malloc(sizeof(struct aiocb));
+		aiocb[i] = calloc(1, sizeof(struct aiocb));
 		if (aiocb[i] == NULL) {
 			printf(TNAME " Error at malloc(): %s\n",
 			       strerror(errno));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
index 280ac15..e194f49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
@@ -71,7 +71,7 @@ int main(void)
 	/* create AIO req */
 
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = malloc(sizeof(struct aiocb));
+		aiocb[i] = calloc(1, sizeof(struct aiocb));
 		if (aiocb[i] == NULL) {
 			printf(TNAME " Error at malloc(): %s\n",
 			       strerror(errno));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index c205d27..5e9bccf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -68,7 +68,7 @@ int main(void)
 
 	/* create AIO req */
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = malloc(sizeof(struct aiocb));
+		aiocb[i] = calloc(1, sizeof(struct aiocb));
 
 		if (aiocb[i] == NULL) {
 			printf(TNAME " Error@malloc(): %s\n",
-- 
1.7.1

