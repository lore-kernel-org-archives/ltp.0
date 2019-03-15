From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2019 14:17:33 +0800
Subject: [LTP] [PATCH RFC] lib: invoke do_cleanup if failed to kill test
	processes
Message-ID: <20190315061733.24938-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP liabary should invoke do_cleanup function promptly when killing
test process doesn't work, especially useful to testcase do mount or
format devices in their setup phase. Otherwise, that abnormal broken
will effect the testcase which LTP is preparing to execute in next.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 7dd890b8d..ce7b37f70 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1035,6 +1035,7 @@ static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	alarm(5);
 
 	if (++sigkill_retries > 10) {
+		do_cleanup();
 		WRITE_MSG("Cannot kill test processes!\n");
 		WRITE_MSG("Congratulation, likely test hit a kernel bug.\n");
 		WRITE_MSG("Exitting uncleanly...\n");
-- 
2.20.1

