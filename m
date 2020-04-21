From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Apr 2020 20:00:02 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
Message-ID: <20200421180002.11351-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

I guess nothing controversial here as failure of starting server is
guarded by -s.
I was thinking about using TST_RETRY_FUNC, but passing command to it
leads to: tst_rhost_run: unknown option: l

What bothers me more, that TST_NEEDS_CMDS does not check command on
rhost. Do we want to have something like TST_NEEDS_CMDS_RHOST or we just
don't care?

Kind regards,
Petr

 testcases/network/tcp_cmds/sendfile/sendfile01.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01.sh b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
index af9cadf57..94fff2c9a 100755
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
@@ -28,7 +28,10 @@ do_setup()
 	tst_rhost_run -s -b -c "$server $(tst_ipaddr rhost) $port"
 	server_started=1
 	tst_res TINFO "wait for the server to start"
-	sleep 1
+	while true; do
+		tst_rhost_run -c "ss -ltp" | grep -q "$port.*testsf" && break
+		tst_sleep 10ms
+	done
 }
 
 do_test()
-- 
2.26.0

