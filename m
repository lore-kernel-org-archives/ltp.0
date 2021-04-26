From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Apr 2021 16:17:00 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/getdents01: Fix dirp handling
Message-ID: <20210426141700.20036-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After previous fix the test still failed with large enough -i parameter,
e.g. -i 10, that was because we incremented the dirp in the run() loop.

This patch fixes that by simply using a different pointer for the loop
that check the buffer content.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getdents/getdents01.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index f36f8869a..e5e4689ee 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -81,16 +81,18 @@ static void run(void)
 
 	reset_flags();
 
+	void *recp = dirp;
+
 	do {
-		size_t d_reclen = tst_dirp_reclen(dirp);
-		const char *d_name = tst_dirp_name(dirp);
+		size_t d_reclen = tst_dirp_reclen(recp);
+		const char *d_name = tst_dirp_name(recp);
 
 		set_flag(d_name);
 
 		tst_res(TINFO, "Found '%s'", d_name);
 
 		rval -= d_reclen;
-		dirp += d_reclen;
+		recp += d_reclen;
 	} while (rval > 0);
 
 	check_flags();
-- 
2.26.3

