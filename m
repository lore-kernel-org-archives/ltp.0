From: Cedric Hnyda <chnyda@suse.com>
Date: Fri,  9 Oct 2015 16:26:44 +0200
Subject: [LTP]  [PATCH] inotify06: kernel version fix
Message-ID: <1444400804-3658-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

inotify06 is a regression test for kernels >= 4.2.
Add a condition so that only >= 4.2 kernels can run the test
because previous kernel are likely to crash because of the test.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/syscalls/inotify/inotify06.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 71f7596..090729d 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -69,6 +69,11 @@ static void setup(void)
 {
 	int i;
 
+	if ((tst_kvercmp(4, 2, 0)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are 4.2. and higher");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
-- 
2.1.4

