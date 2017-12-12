From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 12 Dec 2017 14:52:26 +0300
Subject: [LTP] [PATCH 1/3] posix: aio_cancel: 3-1,
	4-1: prepare aiocb structures in advance
Message-ID: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests work this way. They sequentially issue a number of aio_write()
operations and then cancel them all. They expect that at least
one of the operations has not been completed when they issue
the cancel request. However, while preparing a request two
calls to malloc() are made, one of them is for a 1 MB block. This is
a relatively time-expensive operation, so on some systems it may (and does)
happen that all AIO writes are completed before aio_cancel() is called.

Preparing all aiocb structures in advance eliminates this problem.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/aio_cancel/3-1.c        |    7 ++++++-
 .../conformance/interfaces/aio_cancel/4-1.c        |    2 ++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
index ccb85e5..ead3be1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
@@ -65,6 +65,7 @@ int main(void)
 {
 	char tmpfname[256];
 	int fd;
+	struct aiocb *aiocb_list[BUF_NB];
 	struct aiocb *aiocb;
 	struct sigaction action;
 	int i;
@@ -121,7 +122,11 @@ int main(void)
 		aiocb->aio_sigevent.sigev_value.sival_ptr = aiocb;
 		aiocb->aio_reqprio = 0;
 
-		if (aio_write(aiocb) == -1) {
+		aiocb_list[i] = aiocb;
+	}
+
+	for (i = 0; i < BUF_NB; i++) {
+		if (aio_write(aiocb_list[i]) == -1) {
 			printf(TNAME " loop %d: Error@aio_write(): %s\n",
 			       i, strerror(errno));
 			return PTS_FAIL;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
index 76a45a1..7304857 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
@@ -86,7 +86,9 @@ int main(void)
 		aiocb[i]->aio_nbytes = BUF_SIZE;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+	}
 
+	for (i = 0; i < BUF_NB; i++) {
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error@aio_write(): %s\n",
 			       i, strerror(errno));
-- 
1.7.1

