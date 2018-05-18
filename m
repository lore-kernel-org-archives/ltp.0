From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 May 2018 17:21:55 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/prctl01: Rewrite to the new
	library
In-Reply-To: <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180517152329.3h7zuuoatcbtklbl@dell5510>
 <1526607037-22667-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180518152154.ni6i3r5rzzhxoh2t@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/prctl/prctl01.c | 187 +++++-------------------------
>  1 file changed, 30 insertions(+), 157 deletions(-)

Pushed with minor changes (see patch bellow):

* Add SPDX-License-Identifier into first line (expected by checkpatch.pl script from kernel).
* Changed message for PR_SET_PDEATHSIG from TINFO to TPASS.
* Put TFAIL string into one line (refer not split quoted string if not too long).


Kind regards,
Petr

diff --git testcases/kernel/syscalls/prctl/prctl01.c testcases/kernel/syscalls/prctl/prctl01.c
index 4270e8472..b235981e6 100644
--- testcases/kernel/syscalls/prctl/prctl01.c
+++ testcases/kernel/syscalls/prctl/prctl01.c
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
  * This is a Phase I test for the prctl(2) system call.
  * It is intended to provide a limited exposure of the system call.
  */
@@ -25,7 +22,7 @@ static void verify_prctl(void)
 		return;
 	}
 
-	tst_res(TINFO, "prctl(PR_SET_PDEATHSIG) succeeded");
+	tst_res(TPASS, "prctl(PR_SET_PDEATHSIG) succeeded");
 
 	TEST(prctl(PR_GET_PDEATHSIG, &get_sig));
 	if (TEST_RETURN == -1) {
@@ -37,8 +34,8 @@ static void verify_prctl(void)
 		tst_res(TPASS,
 			"prctl(PR_GET_PDEATHSIG) got expected death signal");
 	} else {
-		tst_res(TFAIL, "prctl(PR_GET_PDEATHSIG) got death signal %d,"
-			" expected %d", get_sig, SIGUSR2);
+		tst_res(TFAIL, "prctl(PR_GET_PDEATHSIG) got death signal %d, expected %d",
+			get_sig, SIGUSR2);
 	}
 }
