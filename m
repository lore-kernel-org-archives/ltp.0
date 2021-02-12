From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2021 16:15:25 +0100
Subject: [LTP] [COMMITTED] [PATCH] mq_timedreceive_5-3: Initialize maxmsg
 properly
Message-ID: <20210212151525.20112-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test can be actually executed as non-root user but the maxmsg must
be set to a value that is less by user limit for messages and since we
do not send any messages we can safely initialize it to 1.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/mq_timedreceive/5-3.c               | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
index cc592f5a7..87f3365d5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
@@ -55,7 +55,8 @@ int main(void)
 	sprintf(mqname, "/" FUNCTION "_" TEST "_%d", getpid());
 
 	attr.mq_msgsize = BUFFER;
-	attr.mq_maxmsg = BUFFER;
+	attr.mq_maxmsg = 1;
+
 	mqdes = mq_open(mqname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR, &attr);
 	if (mqdes == (mqd_t) - 1) {
 		perror(ERROR_PREFIX "mq_open");
-- 
2.26.2

