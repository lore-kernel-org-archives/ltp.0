From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 21 Jun 2021 12:03:42 +0200
Subject: [LTP] [PATCH] ssh-stress: Add hostkey generation
Message-ID: <20210621100342.4060942-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If not specified, default host keys (in /etc/ssh) are used.
If the keys do not exist, the test will fail or sshd will try to
create the keys in the default location.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/network/stress/ssh/ssh-stress.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index 997ad21db..baf1a7896 100755
--- a/testcases/network/stress/ssh/ssh-stress.sh
+++ b/testcases/network/stress/ssh/ssh-stress.sh
@@ -11,7 +11,7 @@ TST_TESTFUNC="test"
 TST_CNT=3
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="sshd ssh od pkill pgrep"
+TST_NEEDS_CMDS="sshd ssh ssh-keygen od pkill pgrep"
 
 . tst_net.sh
 
@@ -56,8 +56,15 @@ TCPKeepAlive yes
 UseDNS no
 StrictModes no
 PidFile $TST_TMPDIR/sshd.pid
+HostKey $TST_TMPDIR/ssh_host_rsa_key
+HostKey $TST_TMPDIR/ssh_host_ecdsa_key
+HostKey $TST_TMPDIR/ssh_host_ed25519_key
 EOF
 
+	ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_TMPDIR/ssh_host_rsa_key
+	ssh-keygen -q -N "" -t ecdsa -f $TST_TMPDIR/ssh_host_ecdsa_key
+	ssh-keygen -q -N "" -t ed25519 -f $TST_TMPDIR/ssh_host_ed25519_key
+
 	tst_res TINFO "Generate configuration file and key at the remote host"
 	tst_rhost_run -s -c "ssh-keygen -t rsa -N \"\" -f $TST_TMPDIR/id_rsa \
 		>/dev/null"
-- 
2.25.1

