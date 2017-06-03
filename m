From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:19 +0200
Subject: [LTP] [RFC PATCH v6 08/11] lib/test_net.sh: reset_ltp_netspace()
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function is useful when we know we broke netns (e.g. unloading
network driver).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f93f67411..91a62f9f6 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -42,12 +42,19 @@ init_ltp_netspace()
 	tst_wait_ipv6_dad
 }
 
+# Force to reset netns.
+reset_ltp_netspace()
+{
+	[ -n "$TST_USE_NETNS" ] || return
+	ip net del ltp_ns
+	init_ltp_netspace
+}
+
 # Run command on remote host.
 # Options:
 # -b run in background
 # -s safe option, if something goes wrong, will exit with TBROK
 # -c specify command to run
-
 tst_rhost_run()
 {
 	local pre_cmd=
-- 
2.12.2

