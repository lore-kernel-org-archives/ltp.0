From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 00:05:25 +0200
Subject: [LTP] [PATCH 4/4] tst_net.sh: Warn about enabled AppArmor
In-Reply-To: <20181011220525.24628-1-pvorel@suse.cz>
References: <20181011220525.24628-1-pvorel@suse.cz>
Message-ID: <20181011220525.24628-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is due some false positives because improper usage or bugs
in AppArmor profiles (e.g. traceroute, dnsmasq).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index a4467da7c..d60d50820 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -713,6 +713,11 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
 	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
 	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
 	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+
+	if [ -f /sys/module/apparmor/parameters/enabled ] && [ "$(cat /sys/module/apparmor/parameters/enabled)" = "Y" ]; then
+		tst_res_ TINFO "AppArmor enabled, this may affect test results"
+	fi
+
 	export TST_PARSE_VARIABLES="yes"
 fi
 
-- 
2.19.0

