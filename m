From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  9 Jun 2021 13:46:59 +0200
Subject: [LTP] [PATCH 4/4] syscalls/writev03: Adjust test runtime
In-Reply-To: <20210609114659.2445-1-chrubis@suse.cz>
References: <20210609114659.2445-1-chrubis@suse.cz>
Message-ID: <20210609114659.2445-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Bump the test timeout to 600s which gives us about 1 minute of runtime
per iteration.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/writev/writev03.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index d0c64743b..5408d0279 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -144,6 +144,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.min_cpus = 2,
+	.timeout = 600,
 	.setup = setup,
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
-- 
2.31.1

