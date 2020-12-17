From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 17 Dec 2020 09:58:52 +0100
Subject: [LTP] [PATCH] fastopen: add require to sch_netem driver
Message-ID: <20201217085852.26032-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index fb2cb8fc2..0e59ed506 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -11,6 +11,7 @@ TST_MIN_KVER="3.7"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="tc"
+TST_NEEDS_DRIVERS="sch_netem"
 TST_OPTS="R:"
 TST_USAGE=tcp_fastopen_usage
 TST_PARSE_ARGS=tcp_fastopen_parse_args
-- 
2.17.1

