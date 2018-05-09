From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 9 May 2018 18:54:22 +0800
Subject: [LTP] [PATCH] lib/tst_test.sh: Detect quoted parameters correctly
In-Reply-To: <20180508075025.kiwhybpeticscmbh@dell5510>
References: <20180508075025.kiwhybpeticscmbh@dell5510>
Message-ID: <1525863262-29703-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we assign "$@" containing quoted parameters to TST_ARGS variable and pass
the variable into getopts, only the first number from quoted parameters can be
processed.  "$@" seems to be treated as an array by default, and declaring
TST_ARGS as an array could fix this issue.

You can reproduce the issue by the folliwng url:
[1] https://lists.linux.it/pipermail/ltp/2018-May/008042.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34..2c246c2 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -265,7 +265,7 @@ tst_run()
 
 	OPTIND=1
 
-	while getopts "hi:$TST_OPTS" name $TST_ARGS; do
+	while getopts "hi:$TST_OPTS" name "${TST_ARGS[@]}"; do
 		case $name in
 		'h') tst_usage; exit 0;;
 		'i') TST_ITERATIONS=$OPTARG;;
@@ -420,7 +420,7 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		fi
 	fi
 
-	TST_ARGS="$@"
+	TST_ARGS=("$@")
 
 	while getopts ":hi:$TST_OPTS" tst_name; do
 		case $tst_name in
-- 
1.8.3.1



