From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Feb 2020 09:30:19 +0100
Subject: [LTP] [PATCH 1/1] fsmount01: Avoid leaving file descriptor open
Message-ID: <20200219083019.22799-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is probably not needed, as fd will be closed at program exit
anyway.

Kind regards,
Petr

 testcases/kernel/syscalls/fsmount/fsmount01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 83185b48a..aea050506 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -16,6 +16,7 @@
 
 #define LINELENGTH 256
 #define MNTPOINT "newmount_point"
+
 static int sfd, mfd, is_mounted;
 
 static int ismount(char *mntpoint)
@@ -38,6 +39,9 @@ static int ismount(char *mntpoint)
 
 static void cleanup(void)
 {
+	if (sfd > 0)
+		SAFE_CLOSE(sfd);
+
 	if (is_mounted)
 		SAFE_UMOUNT(MNTPOINT);
 }
@@ -67,7 +71,6 @@ static void test_fsmount(void)
 		tst_brk(TBROK | TTERRNO, "fsmount() failed to create a mount object");
 	mfd = TST_RET;
 	tst_res(TPASS, "fsmount() created a mount object");
-	SAFE_CLOSE(sfd);
 
 	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
 	if (TST_RET < 0)
-- 
2.25.0

