From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:28 +0300
Subject: [LTP] [PATCH 4/6] network/tcp_cc/lib: add a function to set qdisc
	and txqueuelen
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cc/tcp_cc_lib.sh |   34 ++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
index b96c8af..7e93e1d 100755
--- a/testcases/network/tcp_cc/tcp_cc_lib.sh
+++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
@@ -9,6 +9,8 @@ TST_NEEDS_CMDS="sysctl tc"
 . tst_net.sh
 
 def_alg="cubic"
+prev_qlen=
+prev_queue=
 prev_alg=
 
 set_cong_alg()
@@ -21,8 +23,16 @@ set_cong_alg()
 
 tcp_cc_cleanup()
 {
+	local rmt_dev="dev $(tst_iface rhost)"
+
 	[ "$prev_cong_ctl" ] && \
 		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
+
+	[ "$prev_qlen" ] && \
+		tst_rhost_run -c "ip li set txqueuelen $prev_qlen $rmt_dev"
+
+	[ "$prev_queue" ] && \
+		tst_rhost_run -c "tc qdisc replace $rmt_dev root $prev_queue"
 }
 
 tcp_cc_setup()
@@ -30,6 +40,30 @@ tcp_cc_setup()
 	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
 }
 
+qdisc_list="pfifo_fast codel pfifo fq hfsc hhf htb pie prio sfb sfq"
+
+tcp_cc_set_qdisc()
+{
+	local qdisc="$1"
+	local qlen="${2:-1000}"
+	local cmd="tc qdisc replace"
+	local rmt_dev="$(tst_iface rhost)"
+
+	tst_res TINFO "set qdisc on $(tst_iface rhost) to $qdisc len $qlen"
+
+	[ -z "$prev_qlen" ] && \
+		prev_qlen=$(tst_rhost_run -s -c \
+			    "cat /sys/class/net/$rmt_dev/tx_queue_len")
+
+	[ -z "$prev_queue" ] && \
+		prev_queue=$(tst_rhost_run -s -c \
+			     "tc qdisc show dev $rmt_dev | head -1" | \
+			     cut -f2 -d' ')
+
+	tst_rhost_run -s -c "ip li set txqueuelen $qlen dev $rmt_dev"
+	tst_rhost_run -s -c "$cmd dev $rmt_dev root $qdisc"
+}
+
 tcp_cc_test01()
 {
 	local alg=$1
-- 
1.7.1

