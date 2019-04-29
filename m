From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 14:46:30 +0200
Subject: [LTP] [PATCH 1/1] tst_net.sh: Remove -B option from tst_rhost_run()
Message-ID: <20190429124630.4834-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This option was added in 6bcf7ce05 ("lib: tst_rhost_run: new option -B
for saving background log") and used in tst_dump_rhost_cmd() added in
921fb2d2c ("network/tst_netload: dump background netstress output on
failure").
But d6ce33a2e ("netstress: set port dynamically on the server-side")
moved logging into netstress.log, created by netstress.c, -B is not
used any more.

NOTE: if this feature is reintroduced, it should check whether
TST_NEEDS_TMPDIR=1 is set (similar to fix e3a1aa106 ("net/tst_netload:
TBROK when TST_NEEDS_TMPDIR not set")).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 692278361..c27460f5f 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -129,7 +129,6 @@ init_ltp_netspace()
 # Run command on remote host.
 # Options:
 # -b run in background
-# -B run in background and save output to $TST_TMPDIR/bg.cmd
 # -s safe option, if something goes wrong, will exit with TBROK
 # -c specify command to run (this must be binary, not shell buildin/function)
 # RETURN: 0 on success, 1 on failure
@@ -141,15 +140,13 @@ tst_rhost_run()
 	local user="root"
 	local cmd=
 	local safe=0
-	local bg=
 
 	OPTIND=0
 
-	while getopts :bBsc:u: opt; do
+	while getopts :bsc:u: opt; do
 		case "$opt" in
-		b|B) [ "$TST_USE_NETNS" ] && pre_cmd= || pre_cmd="nohup"
-		   [ "$opt" = b ] && bg="/dev/null" || bg="$TST_TMPDIR/bg.cmd"
-		   post_cmd=" > $bg 2>&1 &"
+		b) [ "$TST_USE_NETNS" ] && pre_cmd= || pre_cmd="nohup"
+		   post_cmd=" > /dev/null 2>&1 &"
 		   out="1> /dev/null"
 		;;
 		s) safe=1 ;;
-- 
2.21.0

