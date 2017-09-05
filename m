From: Sandeep Patil <sspatil@google.com>
Date: Tue,  5 Sep 2017 16:03:30 -0700
Subject: [LTP] [RESEND][PATCH v2] android: pty01: Fix pty01 test for Android.
Message-ID: <20170905230330.132010-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test fails because 'grantpt()' is a no-op in bionic and doesn't set
the /dev/pts/X mode to '020600' as expected by the test. The change
skips that check if __BIONIC__ is defined so the rest of the test(s)
can proceed and detect other failures if any.

Signed-off-by: Sandeep Patil <sspatil@google.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
---
v1->v2
------
- Change the check from __ANDROID__ to __BIONIC__
- Added "Acked-by" from pvorel@suse.cz

 testcases/kernel/pty/pty01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index cbcc65c97..283612d55 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -99,9 +99,12 @@ static int test1(void)
 		tst_brkm(TBROK, NULL, "uid mismatch");
 	}
 
+	 /* grantpt() is a no-op in bionic. */
+#ifndef __BIONIC__
 	if (st.st_mode != (S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP)) {
 		tst_brkm(TBROK, NULL, "mode mismatch (mode=%o)", st.st_mode);
 	}
+#endif
 
 	slavefd = open(slavename, O_RDWR);
 	if (slavefd >= 0) {
-- 
2.14.1.581.gf28d330327-goog

