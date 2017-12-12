From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 12 Dec 2017 14:52:27 +0300
Subject: [LTP] [PATCH 2/3] posix: aio_cancel: 5-1, 6-1,
	7-1: initialize aio_reqprio
In-Reply-To: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1513079548-23022-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

aiocb is allocated via malloc(), which does not clear the memory.
aio_write() may fail with EINVAL if aio_reqprio is not properly
initialized.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/aio_cancel/5-1.c        |    1 +
 .../conformance/interfaces/aio_cancel/6-1.c        |    1 +
 .../conformance/interfaces/aio_cancel/7-1.c        |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index ece29ac..de0a9e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -86,6 +86,7 @@ int main(void)
 		aiocb[i]->aio_nbytes = BUF_SIZE;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+		aiocb[i]->aio_reqprio = 0;
 
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
index 280ac15..765db2c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
@@ -87,6 +87,7 @@ int main(void)
 		aiocb[i]->aio_nbytes = BUF_SIZE;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+		aiocb[i]->aio_reqprio = 0;
 
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index c205d27..79d6b03 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -90,6 +90,7 @@ int main(void)
 		aiocb[i]->aio_nbytes = BUF_SIZE;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+		aiocb[i]->aio_reqprio = 0;
 
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-- 
1.7.1

