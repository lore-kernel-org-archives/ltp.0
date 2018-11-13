From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Nov 2018 17:30:08 +0100
Subject: [LTP] [PATCH v4 2/2] net/ipsec: Add check for xfrm_user kernel
	module
In-Reply-To: <20181113163008.9093-1-pvorel@suse.cz>
References: <20181113163008.9093-1-pvorel@suse.cz>
Message-ID: <20181113163008.9093-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

xfrm_user is required by ip xfrm command.
Check is performed only when needed.
Call in cleanup function could trigger infinite loop,
therefore check only once.

NOTE: we cannot use tst_test_drivers() due tst_rhost_run() limitation.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index b099fdeaf..74d4fc0cb 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -81,6 +81,12 @@ ipsec_lib_setup()
 	cleanup_vti=
 	ALG=
 	ALGR=
+
+	if [ -n "$IPSEC_MODE" ]; then
+		tst_net_run "tst_check_drivers xfrm_user" || \
+			tst_brk TCONF "xfrm_user driver not available on lhost or rhost"
+		cleanup_xfrm=1
+	fi
 }
 
 TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
@@ -110,6 +116,8 @@ tst_ipsec_setup()
 # tst_ipsec_cleanup: flush ipsec state and policy rules
 tst_ipsec_cleanup()
 {
+	[ -z "$cleanup_xfrm" ] && return
+
 	ip xfrm state flush
 	ip xfrm policy flush
 	tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
-- 
2.19.1

