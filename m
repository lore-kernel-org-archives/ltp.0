From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Apr 2019 15:33:25 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/stat01, 02,
 05: Cleanup && Convert to new API
In-Reply-To: <1554706347-2452-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190404131911.GB10585@rei.lan>
 <1554706347-2452-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190409133324.GB19255@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small simplification, thanks.

diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index 437ce0cf8..14f1036d5 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -48,36 +48,31 @@ static void verify_stat(unsigned int n)
 	}
 
 	if (stat_buf.st_uid != user_id) {
-		tst_res(TINFO, "stat_buf.st_uid = %i expected %i",
+		tst_res(TFAIL, "stat_buf.st_uid = %i expected %i",
 			stat_buf.st_uid, user_id);
 		fail++;
 	}
 
 	if (stat_buf.st_gid != group_id) {
-		tst_res(TINFO, "stat_buf.st_gid = %i expected %i",
+		tst_res(TFAIL, "stat_buf.st_gid = %i expected %i",
 			stat_buf.st_gid, group_id);
 		fail++;
 	}
 
 	if (stat_buf.st_size != FILE_SIZE) {
-		tst_res(TINFO, "stat_buf.st_size = %li expected %i",
+		tst_res(TFAIL, "stat_buf.st_size = %li expected %i",
 			(long)stat_buf.st_size, FILE_SIZE);
 		fail++;
 	}
 
 	if ((stat_buf.st_mode & MASK) != tc->mode) {
-		tst_res(TINFO, "stat_buf.st_mode = %o expected %o",
+		tst_res(TFAIL, "stat_buf.st_mode = %o expected %o",
 			(stat_buf.st_mode & MASK), tc->mode);
 		fail++;
 	}
 
-	if (fail) {
-		tst_res(TFAIL, "functionality of stat(%s) incorrect",
-			tc->pathname);
-		return;
-	}
-
-	tst_res(TPASS, "functionality of stat(%s) correct", tc->pathname);
+	if (!fail)
+		tst_res(TPASS, "stat(%s)", tc->pathname);
 }
 
 void setup(void)

-- 
Cyril Hrubis
chrubis@suse.cz
