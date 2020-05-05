From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 May 2020 13:45:01 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/inotify09: Add git tag.
Message-ID: <20200505114501.25722-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify09.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index ff7379252..fdfc9c078 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -94,6 +94,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d90a10e2444b"},
+		{}
+	}
 };
 
 #else
-- 
2.26.2

