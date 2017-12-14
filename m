From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Dec 2017 15:23:07 +0300
Subject: [LTP] [PATCH V2 2/2] posix: aio_error: 2-1: zero out the control
	block buffer
In-Reply-To: <1513254187-6528-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1513254187-6528-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1513254187-6528-2-git-send-email-stanislav.kholmanskikh@oracle.com>
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

 .../conformance/interfaces/aio_error/2-1.c         |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
index 12319dc..9ce2916 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
@@ -63,7 +63,7 @@ int main(void)
 	/* create AIO req */
 
 	for (i = 0; i < BUF_NB; i++) {
-		aiocb[i] = malloc(sizeof(struct aiocb));
+		aiocb[i] = calloc(1, sizeof(struct aiocb));
 		if (aiocb[i] == NULL) {
 			printf(TNAME " Error@malloc(): %s\n",
 			       strerror(errno));
-- 
1.7.1

