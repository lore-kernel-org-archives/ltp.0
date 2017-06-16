From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jun 2017 03:56:51 +0200
Subject: [LTP] [RFC PATCH v6 1/2] lib/test_net.sh: reset_ltp_netspace()
In-Reply-To: <20170616015652.11169-1-pvorel@suse.cz>
References: <20170616015652.11169-1-pvorel@suse.cz>
Message-ID: <20170616015652.11169-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function is useful when we know we broke netns (e.g. unloading
network driver).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 10cf6da3a..53e3b5995 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -50,12 +50,20 @@ init_ltp_netspace()
 	tst_wait_ipv6_dad
 }
 
+# Force to reset netns.
+reset_ltp_netspace()
+{
+	[ -n "$TST_USE_NETNS" ] || return
+	rm -f /var/run/netns/ltp_ns
+	pkill ns_create
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

