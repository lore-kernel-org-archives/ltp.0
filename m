From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 27 Apr 2019 07:52:10 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] net: Use $TST_IPVER in tst_icmp() and
	tst_ipsec_vti()
Message-ID: <20190427055210.11697-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                    | 7 +++----
 testcases/network/stress/ipsec/ipsec_lib.sh | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 69d196f78..692278361 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -669,7 +669,6 @@ tst_icmp()
 	local opts=
 	local num=
 	local ret=0
-	local ver="${TST_IPV6:-4}"
 
 	OPTIND=0
 	while getopts :t:s: opt; do
@@ -689,12 +688,12 @@ tst_icmp()
 	opts="${opts}-M $(tst_hwaddr rhost) -t $timeout"
 
 	for size in $msg_sizes; do
-		ns-icmpv${ver}_sender -s $size $opts
+		ns-icmpv${TST_IPVER}_sender -s $size $opts
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_res_ TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
+			tst_res_ TPASS "'ns-icmpv${TST_IPVER}_sender -s $size $opts' pass"
 		else
-			tst_res_ TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
+			tst_res_ TFAIL "'ns-icmpv${TST_IPVER}_sender -s $size $opts' fail"
 			break
 		fi
 	done
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 74d4fc0cb..d40941d45 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -245,7 +245,7 @@ tst_ipsec_vti()
 
 	local o_dir="src $src dst $dst"
 	local i_dir="src $dst dst $src"
-	local ipx="ip -${TST_IPV6:-4} xf"
+	local ipx="ip -$TST_IPVER xf"
 
 	cleanup_vti=$vti
 
-- 
2.20.1

