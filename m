From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:04 +0200
Subject: [LTP] [PATCH v3 4/9] tst_net.sh: Harden library against deadlocks
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 507d5b788..e55ac1ddc 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -78,6 +78,19 @@ tst_net_setup()
 
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
+if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
+	tst_res TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
+	unset TST_PARSE_ARGS_CALLER
+fi
+if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
+	tst_res TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
+	unset TST_SETUP_CALLER
+fi
+if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
+	tst_res TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
+	unset TST_USAGE_CALLER
+fi
+
 if [ -n "$TST_USE_LEGACY_API" ]; then
 	tst_net_read_opts "$@"
 fi
-- 
2.18.0

