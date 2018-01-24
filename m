From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:02 +0100
Subject: [LTP] [PATCH 09/19] fix old-style-definition in vfork.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-10-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/freezer/vfork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/freezer/vfork.c b/testcases/kernel/controllers/freezer/vfork.c
index eeec89dc0..124a78363 100644
--- a/testcases/kernel/controllers/freezer/vfork.c
+++ b/testcases/kernel/controllers/freezer/vfork.c
@@ -88,7 +88,7 @@ void kill_child(void)
 
 }
 
-void child_cleanup()
+void child_cleanup(void)
 {
 	close(psync[0]);
 	tst_exit();
@@ -129,7 +129,7 @@ void sleepy_time(void)
 	} while (1);
 }
 
-void usage()
+void usage(void)
 {
 	tst_resm(TBROK, "usage: %s [-f [FILE]] [-s [NUM]] [-p] [NUM]\n\n"
 		 "\t-f FILE\t\tFile to output trace data to.\n"
-- 
2.13.6

