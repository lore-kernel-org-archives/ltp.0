From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 3 Mar 2021 12:30:14 +0800
Subject: [LTP] [PATCH 3/3] lib/tst_test.c: Remove redundant needs_device
In-Reply-To: <20210303043014.484426-1-yangx.jy@cn.fujitsu.com>
References: <20210303043014.484426-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20210303043014.484426-3-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6bbee030b..9987e9543 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -942,13 +942,11 @@ static void do_setup(int argc, char *argv[])
 				tst_brk(TCONF, "%s driver not available", name);
 	}
 
-	if (tst_test->format_device)
-		tst_test->needs_device = 1;
+	if (tst_test->mount_device)
+		tst_test->format_device = 1;
 
-	if (tst_test->mount_device) {
+	if (tst_test->format_device)
 		tst_test->needs_device = 1;
-		tst_test->format_device = 1;
-	}
 
 	if (tst_test->all_filesystems)
 		tst_test->needs_device = 1;
-- 
2.25.1



