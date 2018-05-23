From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 10:18:25 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/1] lib/tst_net.sh: Silence getopts for
	legacy API
Message-ID: <20180523081825.18294-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Commits bellow removed ':' silencing getopts for legacy API. As there is
currently no warning for network scripts using TST_PARSE_ARGS in legacy
API, adding it into library.

5dea314ee ("net/nfs_lib.sh: Cleanup for legacy API")
52c754c7b ("net/tcp_fastopen_run.sh: Cleanup in TST_PARSE_ARGS functions
for legacy API")

Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 5a0fe77ab..a8f80b518 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -41,7 +41,7 @@ tst_net_parse_args()
 tst_net_read_opts()
 {
 	local OPTIND
-	while getopts "$TST_OPTS" opt; do
+	while getopts ":$TST_OPTS" opt; do
 		$TST_PARSE_ARGS "$opt" "$OPTARG"
 	done
 }
-- 
2.16.3

