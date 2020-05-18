From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 May 2020 23:15:14 +0200
Subject: [LTP] [PATCH 2/2] rpc_test.sh: Print used TI-RPC implementation
In-Reply-To: <20200518211514.20445-1-pvorel@suse.cz>
References: <20200518211514.20445-1-pvorel@suse.cz>
Message-ID: <20200518211514.20445-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This helps to debug glibc tests. Some of them are failing:
Cannot register service: RPC: Unable to receive; errno = Connection refused

+ unify case on message in check_portmap_rpcbind.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/rpc/basic_tests/rpc_lib.sh | 2 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
index 96dae8dd3..c7c868709 100644
--- a/testcases/network/rpc/basic_tests/rpc_lib.sh
+++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
@@ -11,5 +11,5 @@ check_portmap_rpcbind()
 		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
 			tst_brk TCONF "portmap or rpcbind is not running"
 	fi
-	tst_res TINFO "Using $PORTMAPPER"
+	tst_res TINFO "using $PORTMAPPER"
 }
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index dc97213d0..410482c14 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -55,6 +55,13 @@ setup()
 
 	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
 	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
+
+	tst_cmd_available ldd which || return
+	if ldd $(which $CLIENT) |grep -q /libtirpc\.so; then
+		tst_res TINFO "using libtirpc: yes"
+	else
+		tst_res TINFO "using libtirpc: no (probably using glibc)"
+	fi
 }
 
 cleanup()
-- 
2.26.2

