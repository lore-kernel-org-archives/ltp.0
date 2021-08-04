From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed,  4 Aug 2021 15:04:44 +0300
Subject: [LTP] [PATCH 1/3] network/tcp_cc: check sch_netem driver in the lib
Message-ID: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

bbr01, bbr02 and dctcp01 are using netem.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/network/tcp_cc/tcp_cc_lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
index dff8cef19..1a6845664 100755
--- a/testcases/network/tcp_cc/tcp_cc_lib.sh
+++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
@@ -6,6 +6,7 @@
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl tc"
+TST_NEEDS_DRIVERS="sch_netem"
 
 . tst_net.sh
 
-- 
2.25.1

