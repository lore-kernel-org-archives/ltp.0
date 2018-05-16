From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 14:39:24 +0200
Subject: [LTP] [RFC PATCH 2/2] net/{stress,
	virt}: Use TST_TESTFUNC_DATA and TST_TESTFUNC_DATA_IFS
In-Reply-To: <20180516123924.11047-1-pvorel@suse.cz>
References: <20180516123924.11047-1-pvorel@suse.cz>
Message-ID: <20180516123924.11047-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not-yet-signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This is just for demonstration purposes as
1) It's not applicable as it expect more changes to be posted later in
patch rewriting net/{stress,virt} into new shell API (see cover letter).
2) Changes are going to be done in 6 more files.
---
 testcases/network/stress/dccp/dccp_ipsec.sh | 6 ++----
 testcases/network/stress/ipsec/ipsec_lib.sh | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index dae530fa3..3b51e4587 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -21,10 +21,8 @@ do_setup()
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T dccp -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T dccp -n $1 -N $1 \
+		-r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index bfb022bd0..782c3fb89 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -48,7 +48,8 @@ ipsec_lib_parse_args()
 	r) IPSEC_REQUESTS="$2" ;;
 	esac
 
-	IPSEC_SIZE_ARRAY="$(echo $IPSEC_SIZE_ARRAY | sed 's/:/ /g')"
+	TST_TESTFUNC_DATA="$IPSEC_SIZE_ARRAY"
+	TST_TESTFUNC_DATA_IFS=":"
 }
 
 TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
-- 
2.16.3

