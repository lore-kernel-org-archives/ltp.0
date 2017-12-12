From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 12 Dec 2017 14:52:28 +0300
Subject: [LTP] [PATCH 3/3] posix: aio_error: 2-1: initialize aio_reqprio
In-Reply-To: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1513079548-23022-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1513079548-23022-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

aio_write() may fail if aio_reqprio is not properly initialized.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/aio_error/2-1.c         |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
index 12319dc..f7116ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
@@ -79,6 +79,7 @@ int main(void)
 		aiocb[i]->aio_nbytes = BUF_SIZE;
 		aiocb[i]->aio_offset = 0;
 		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
+		aiocb[i]->aio_reqprio = 0;
 
 		if (aio_write(aiocb[i]) == -1) {
 			printf(TNAME " loop %d: Error at aio_write(): %s\n",
-- 
1.7.1

