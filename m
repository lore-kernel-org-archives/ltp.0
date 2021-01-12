From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 10:02:26 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/open01.c: Take use of
 TST_EXP_FD_SILENT
In-Reply-To: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20210112020227.11775-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current TST_EXP_FD macro reports the double passed for
one subtest, for example:
--------------------------------------------
./open01
tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
open01.c:48: TPASS: open() with sticky bit returned fd 3
open01.c:59: TPASS: sticky bit is set as expected
open01.c:48: TPASS: open() with sirectory bit returned fd 3
open01.c:59: TPASS: sirectory bit is set as expected

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0
--------------------------------------------

It is just a minor cleanup rather than a fix.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/open/open01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index 2f0ad550a..baf73ab11 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -45,7 +45,7 @@ static void verify_open(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	struct stat buf;
 
-	TST_EXP_FD(open(tc->filename, tc->flag, tc->mode),
+	TST_EXP_FD_SILENT(open(tc->filename, tc->flag, tc->mode),
 	           "open() with %s", tc->desc);
 	if (!TST_PASS)
 		return;
-- 
2.21.0



