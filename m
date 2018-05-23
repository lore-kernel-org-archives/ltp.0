From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 May 2018 10:30:55 +0200
Subject: [LTP] [PATCH 1/1] lib/tst_test.sh: Silence getopts
Message-ID: <20180523083055.20338-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We handle the error already there, so there is no point printing
one more redundant message that doesn't have LTP format.

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 464c4c41e..ac315075f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -265,7 +265,7 @@ tst_run()
 
 	OPTIND=1
 
-	while getopts "hi:$TST_OPTS" name $TST_ARGS; do
+	while getopts ":hi:$TST_OPTS" name $TST_ARGS; do
 		case $name in
 		'h') tst_usage; exit 0;;
 		'i') TST_ITERATIONS=$OPTARG;;
-- 
2.16.3

