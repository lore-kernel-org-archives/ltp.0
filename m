From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2017 17:26:01 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] syscalls/inotify03: Require root
Message-ID: <20170315162602.25921-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We are mounting a device there after all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify03.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 3ff33ef..d3007b0 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -166,6 +166,8 @@ static void setup(void)
 {
 	int ret;
 
+	tst_require_root();
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
-- 
2.10.2

