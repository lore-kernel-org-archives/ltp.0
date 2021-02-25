From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 25 Feb 2021 15:09:25 +0100
Subject: [LTP] [PATCH] Reduce writev03 fuzzy_sync timeout
Message-ID: <20210225140925.16187-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Writev03 is fairly slow and tests multiple filesystems, each getting another
round of timeout. Reduce fuzzy sync time limit to 25% of standard timeout
to make the test finish slightly faster.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/writev/writev03.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 4dc55c191..6514404e6 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -49,6 +49,7 @@ static void setup(void)
 	mapfd = SAFE_OPEN(MAPFILE, O_CREAT|O_RDWR|O_TRUNC, 0644);
 	SAFE_WRITE(1, mapfd, buf, BUF_SIZE);
 
+	fzsync_pair.exec_time_p = 0.25;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
-- 
2.30.0

