From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 May 2018 17:23:25 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/prctl02: Rewrite to the new
	library
In-Reply-To: <1526607037-22667-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180517152329.3h7zuuoatcbtklbl@dell5510>
 <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1526607037-22667-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180518152324.g5z7452vyn2bdx3o@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/prctl/prctl02.c | 195 +++++-------------------------
Pushed with minor changes (see patch bellow):

* Add SPDX-License-Identifier into first line (expected by checkpatch.pl script from kernel).
* Put TFAIL string into one line (refer not split quoted string if not too long).
* Removed obvious DESCRIPTION text.

Thanks for your patches!

Kind regards,
Petr

diff --git testcases/kernel/syscalls/prctl/prctl02.c testcases/kernel/syscalls/prctl/prctl02.c
index 1e7640b6d..ee4a6afe4 100644
--- testcases/kernel/syscalls/prctl/prctl02.c
+++ testcases/kernel/syscalls/prctl/prctl02.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * SPDX-License-Identifier: GPL-2.0-or-later
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- */
-
-/*
- * DESCRIPTION
+ *
  * 1) prctl() fails with EINVAL when an invalid value is given for option
  * 2) prctl() fails with EINVAL when option is PR_SET_PDEATHSIG & arg2 is
  * not zero or a valid signal number
@@ -41,8 +38,8 @@ static void verify_prctl(unsigned int n)
 	if (tc->exp_errno == TEST_ERRNO) {
 		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
 	} else {
-		tst_res(TPASS | TTERRNO, "prctl() failed unexpectedly, "
-			"expected %s", tst_strerrno(tc->exp_errno));
+		tst_res(TPASS | TTERRNO, "prctl() failed unexpectedly, expected %s",
+				tst_strerrno(tc->exp_errno));
 	}
 }
 
