From: Xiong Zhou <xzhou@redhat.com>
Date: Sat, 24 Mar 2018 08:47:51 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: log testing fstyp when iterating
	all_filesystems
Message-ID: <1521852471-3052-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's more clear that which test is going on and saving debug time
if anything goes wrong.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b5fce33..8be1332 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1044,6 +1044,8 @@ static int run_tcases_per_fs(void)
 		tst_brk(TCONF, "There are no supported filesystems");
 
 	for (i = 0; filesystems[i]; i++) {
+
+		tst_res(TINFO, "Testing on %s", filesystems[i]);
 		tdev.fs_type = filesystems[i];
 
 		prepare_device();
-- 
1.8.3.1

