From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Nov 2019 14:34:14 +0100
Subject: [LTP] [PATCH] syscalls/shmat03: Remove CVE tag
Message-ID: <20191121133414.19808-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The CVE was proved to be bogus so as far as I can tell we shouldn't list
it in tags.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmat/shmat03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index 8a0b89bd5..dfa427a56 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -101,7 +101,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.tags = (const struct tst_tag[]) {
-		{"CVE", "2017-5669"},
 		{"linux-git", "95e91b831f87"},
 		{"linux-git", "a73ab244f0da"},
 		{"linux-git", "8f89c007b6de"},
-- 
2.21.0

