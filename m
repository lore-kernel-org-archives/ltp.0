From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 26 May 2018 13:15:45 +0200
Subject: [LTP] [PATCH 4/4] net/macsec0{1,
	2}.sh: Use TST_NET_SKIP_PARSE_ARGS=1
In-Reply-To: <20180526111545.20521-1-pvorel@suse.cz>
References: <20180526111545.20521-1-pvorel@suse.cz>
Message-ID: <20180526111545.20521-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These tests load ipsec_lib.sh and virt_lib.sh.
Currently tst_net.sh doesn't support being used by more libraries, so
when handling getopts the later one wins.
Disabling variables as they aren't used in the runtest file.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alexey, do you use library variables for debugging?
Or would you prefer to be without this and to have at least one
libraries getopts?


Kind regards,
Petr
---
 testcases/network/virt/macsec01.sh | 1 +
 testcases/network/virt/macsec02.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index 52d6f071a..ddcd4b41c 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -24,6 +24,7 @@ TST_NEEDS_TMPDIR=1
 
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+TST_NET_SKIP_PARSE_ARGS=1
 
 . ipsec_lib.sh
 . virt_lib.sh
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 617860d41..215973bee 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -24,6 +24,7 @@ TST_NEEDS_TMPDIR=1
 
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+TST_NET_SKIP_PARSE_ARGS=1
 
 . ipsec_lib.sh
 . virt_lib.sh
-- 
2.16.3

