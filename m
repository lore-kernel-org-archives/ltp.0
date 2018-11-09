From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 9 Nov 2018 19:21:35 +0100
Subject: [LTP] [PATCH 2/2] syscalls/fchmod05.c: Cleanup && convert to
 new API
In-Reply-To: <1528975762-10624-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1528975762-10624-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20181109182122.GA26178@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/fchmod/fchmod05.c | 238 ++++++----------------------

thanks for your patch!
Merged, with following diff (variables renamed, _GNU_SOURCE and include not needed).


Kind regards,
Petr

@@ -16,12 +16,7 @@
  *  the mode of a directory but fails to set setgid bit on it.
  */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-
 #include <pwd.h>
-#include <grp.h>
 #include <errno.h>
 
 #include "tst_test.h"
@@ -37,7 +32,7 @@ static void verify_fchmod(void)
 	mode_t dir_mode;
 
 	TEST(fchmod(fd, PERMS_DIR));
-	if (TEST_RETURN == -1)
+	if (TST_RET == -1)
 		tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
 
 	SAFE_FSTAT(fd, &stat_buf);
@@ -64,7 +59,7 @@ static void setup(void)
 
 	if (setgroups(1, &ltpuser->pw_gid) == -1) {
 		tst_brk(TBROK, "Couldn't change supplementary group Id: %s",
-			tst_strerrno(TEST_ERRNO));
+			tst_strerrno(TST_ERR));
 	}
 
 	SAFE_CHOWN(TESTDIR, ltpuser->pw_uid, ltpgroup->gr_gid);
