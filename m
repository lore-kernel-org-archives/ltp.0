From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 May 2018 14:22:20 +0200
Subject: [LTP] [RFC PATCH 1/3] lib/tst_net.sh: Pass $OPTARG as $2 to
	TST_PARSE_ARGS function
In-Reply-To: <20180503122222.2996-1-pvorel@suse.cz>
References: <20180503122222.2996-1-pvorel@suse.cz>
Message-ID: <20180503122222.2996-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that tests using tst_net.sh with legacy API doesn't have to use
OPTARG variable directly.
This helps a transition to new API a bit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 112bd5cd4..3a0fe0192 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -42,7 +42,7 @@ tst_net_read_opts()
 {
 	local OPTIND
 	while getopts "$TST_OPTS" opt; do
-		$TST_PARSE_ARGS "$opt"
+		$TST_PARSE_ARGS "$opt" "$OPTARG"
 	done
 }
 
-- 
2.16.3

