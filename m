From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 15:40:40 +0300
Subject: [LTP] [PATCH 2/3] lib: tst_rhost_run: new option -B for saving
	background log
In-Reply-To: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1507812041-2068-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 8025582..cd67877 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -53,9 +53,9 @@ init_ltp_netspace()
 # Run command on remote host.
 # Options:
 # -b run in background
+# -B run in background and save output to $TST_TMPDIR/bg.cmd
 # -s safe option, if something goes wrong, will exit with TBROK
 # -c specify command to run
-
 tst_rhost_run()
 {
 	local pre_cmd=
@@ -64,13 +64,15 @@ tst_rhost_run()
 	local user="root"
 	local cmd=
 	local safe=0
+	local bg=
 
 	OPTIND=0
 
-	while getopts :bsc:u: opt; do
+	while getopts :bBsc:u: opt; do
 		case "$opt" in
-		b) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
-		   post_cmd=" > /dev/null 2>&1 &"
+		b|B) [ "$TST_USE_NETNS" ] && pre_cmd="" || pre_cmd="nohup"
+		   [ "$opt" = b ] && bg="/dev/null" || bg="$TST_TMPDIR/bg.cmd"
+		   post_cmd=" > $bg 2>&1 &"
 		   out="1> /dev/null"
 		;;
 		s) safe=1 ;;
-- 
1.7.1

