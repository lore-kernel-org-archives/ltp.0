From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 12:57:04 +0100
Subject: [LTP]  [PATCH 3/3] inotify06: kernel version check
In-Reply-To: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478087824-31577-4-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For test inotify06, kernels prior to 4.2 have a race when inode
is being deleted while inotify group watching that inode is being
torn down. When the race is hit, the kernel crashes or loops. So,
added a check to see if the kernel is >= 4.2.0, and if not, the
test breaks with TCONF and an appropriate message.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/inotify/inotify06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 71f7596..1caa70d 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -67,6 +67,9 @@ static void cleanup(void)
 
 static void setup(void)
 {
+    if (tst_kvercmp(4, 2, 0) < 0)
+		tst_brkm(TCONF, NULL, "Test must be run with kernel 4.2 or newer");
+
 	int i;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
-- 
1.9.1

