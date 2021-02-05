From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Feb 2021 15:20:50 +0100
Subject: [LTP] [PATCH 1/2] tst_net.sh: Add API function to check netns use
Message-ID: <20210205142051.32055-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

or do we want to allow using TST_USE_NETNS?

Kind regards,
Petr

 testcases/lib/tst_net.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 1ddef2fea..d4633c509 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -131,6 +131,12 @@ init_ltp_netspace()
 	tst_restore_ipaddr rhost
 }
 
+# return 0: use ssh, 1: use netns
+tst_net_use_netns()
+{
+	[ -n "$TST_USE_NETNS" ]
+}
+
 # Run command on remote host.
 # tst_rhost_run -c CMD [-b] [-s] [-u USER]
 # Options:
-- 
2.30.0

