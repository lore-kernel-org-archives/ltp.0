From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:54:54 +0300
Subject: [LTP] [PATCH 3/4] network/ipsec: use the same mode parameter name
	as in iproute
In-Reply-To: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
References: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1475762095-14612-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.ipsec_icmp                   |    8 ++++----
 testcases/network/stress/icmp/icmp-uni-basic.sh |    2 +-
 testcases/network/stress/ipsec/ipsec_lib.sh     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 071af7d..4a841e4 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -15,8 +15,8 @@ icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s "10 100 1000 10000 65
 icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s "10 100 1000 10000 65450"
 # Same message size but different content will result in different data size
 # after compression. So we just use a large enough message size(65000) for testing
-icmp4-uni-basic06 icmp-uni-basic.sh -p ipcomp -m transport -s "10 100 1000 10000 65000"
-icmp4-uni-basic07 icmp-uni-basic.sh -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
+icmp4-uni-basic06 icmp-uni-basic.sh -p comp -m transport -s "10 100 1000 10000 65000"
+icmp4-uni-basic07 icmp-uni-basic.sh -p comp -m tunnel -s "10 100 1000 10000 65000"
 
 # MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
 icmp6-uni-basic01 icmp-uni-basic.sh -6 -s "10 100 1000 10000 65527"
@@ -33,5 +33,5 @@ icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000
 icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65527"
 # Same message size but different content will result in different data size
 # after compression. So we just use a large enough message size(65000) for testing
-icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
-icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
+icmp6-uni-basic06 icmp-uni-basic.sh -6 -p comp -m transport -s "10 100 1000 10000 65000"
+icmp6-uni-basic07 icmp-uni-basic.sh -6 -p comp -m tunnel -s "10 100 1000 10000 65000"
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 963f3bc..04baa39 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -39,7 +39,7 @@ if $DO_IPSEC; then
 	case $IPSEC_PROTO in
 	ah)	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]" ;;
 	esp)	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]" ;;
-	ipcomp)	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]" ;;
+	comp)	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]" ;;
 	esac
 fi
 
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 99d0229..56422c3 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -93,7 +93,7 @@ tst_ipsec()
 		algo_line="enc $EALGO $EALGO_KEY auth $AALGO $AALGO_KEY"
 		proto="esp"
 		;;
-	ipcomp)
+	comp)
 		algo_line="comp $CALGO"
 		proto="comp"
 		;;
-- 
1.7.1

