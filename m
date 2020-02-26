From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Feb 2020 09:42:49 +0100
Subject: [LTP] [PATCH 1/1] request_key04: Use TFAIL instead of TBROK
Message-ID: <20200226084249.29561-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix unreported results error:
tst_test.c:1036: BROK: Test haven't reported results!

which also prevents to display kernel commit fix and CVE.

Fixes: 8ac26843e ("syscalls/request_key04: new test for request_key()
permission check bug")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

obvious fix which I'd normally merge without sending to ML.
But there are 19 tests which use tst_res(TBROK, and at least some of
them are affected by this (i.e. don't unconditionally report any result
before tst_res(TBROK), so we might want to fix it different way.

Kind regards,
Petr

 testcases/kernel/syscalls/request_key/request_key04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/request_key/request_key04.c b/testcases/kernel/syscalls/request_key/request_key04.c
index da036bf3a..c125f4261 100644
--- a/testcases/kernel/syscalls/request_key/request_key04.c
+++ b/testcases/kernel/syscalls/request_key/request_key04.c
@@ -65,7 +65,7 @@ static void do_test(void)
 	if (TST_ERR == EACCES) {
 		tst_res(TPASS, "request_key() failed with EACCES as expected");
 	} else {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"request_key() failed with unexpected error code");
 	}
 }
-- 
2.25.1

