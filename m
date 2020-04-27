From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 07:38:13 +0200
Subject: [LTP] [PATCH v2 2/2] net/sendfile01.sh: Check with timeout
In-Reply-To: <20200427053813.23112-1-pvorel@suse.cz>
References: <20200427053813.23112-1-pvorel@suse.cz>
Message-ID: <20200427053813.23112-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/sendfile/sendfile01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01.sh b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
index af9cadf57..7104de7aa 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01.sh
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
@@ -11,7 +11,7 @@ TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="diff stat"
+TST_NEEDS_CMDS="diff ss stat"
 . tst_net.sh
 
 do_setup()
@@ -28,7 +28,7 @@ do_setup()
 	tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
 	server_started=1
 	tst_res TINFO "wait for the server to start"
-	sleep 1
+	TST_RETRY_FUNC "tst_rhost_run -c 'ss -ltp' | grep -q '$port.*testsf'" 0
 }
 
 do_test()
-- 
2.26.1

