From: Zou Wei <zou_wei@huawei.com>
Date: Thu, 19 Mar 2020 10:55:50 +0800
Subject: [LTP] [PATCH] aio_error/3-1.c: Call write before aio_error
Message-ID: <1584586550-11668-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In the case, if there is no write/read operation before aio_error,
aio_error will judge that the current asynchronous I/O has been successfully
completed, then return 0, case failed.

After the write/read operation is added, because aiocb.aio_reqprio is -1,
the write/read operation will return -1, so aio_error will also return EINVAL
because it detects that the asynchronous I/O has not completed successfully.

ps:
http://man7.org/linux/man-pages/man3/aio_error.3.html
RETURN VALUE
       This function returns one of the following:
       *  EINPROGRESS, if the request has not been completed yet.
       *  ECANCELED, if the request was canceled.
       *  0, if the request completed successfully.
       *  A positive error number, if the asynchronous I/O operation failed.
          This is the same value that would have been stored in the errno
          variable in the case of a synchronous read(2), write(2), fsync(2),
          or fdatasync(2) call.
ERRORS
       EINVAL aiocbp does not point at a control block for an asynchronous
              I/O request of which the return status (see aio_return(3)) has
              not been retrieved yet.

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 .../open_posix_testsuite/conformance/interfaces/aio_error/3-1.c      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
index 9ccda05..2b2c65b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
@@ -64,6 +64,11 @@ int main(void)
 	aiocb.aio_reqprio = -1;
 	aiocb.aio_nbytes = BUF_SIZE;

+	if (aio_write(&aiocb) != -1) {
+                printf(TNAME " Error at aio_write(): %s\n", strerror(errno));
+                return PTS_FAIL;
+        }
+
 	ret = aio_error(&aiocb);

 	if (ret != EINVAL) {
--
2.6.2

