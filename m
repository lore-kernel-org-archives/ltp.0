From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Nov 2018 19:14:44 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add info about LTP_TIMEOUT_MUL into
	TBROK message
Message-ID: <20181130181444.26565-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

maybe it makes sense to add info about LTP_TIMEOUT_MUL variable.
I'm sorry, I didn't notice before.
This is the same message as it's in C API.

Kind regards,
Petr
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8bf5f84d1..c6ce7b6f3 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -371,7 +371,7 @@ _tst_setup_timer()
 
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
-	sleep $sec && tst_res TBROK "test killed, timeout!" && kill -9 -$pid &
+	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
 
 	_tst_setup_timer_pid=$!
 }
-- 
2.19.1

