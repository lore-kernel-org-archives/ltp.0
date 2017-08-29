From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 19:20:11 +0200
Subject: [LTP] [PATCH 1/1] net/traceroute01: Print traceroute version
Message-ID: <20170829172011.16424-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/traceroute/traceroute01.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 1e01a1c2c..04759697a 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -28,6 +28,9 @@ cleanup()
 
 setup()
 {
+	tst_resm TINFO "traceroute version:"
+	tst_resm TINFO $(traceroute --version 2>&1)
+
 	tst_check_cmds traceroute
 	tst_tmpdir
 }
-- 
2.14.0

