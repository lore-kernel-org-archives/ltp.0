From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 19 Nov 2018 15:47:40 +0000
Subject: [LTP] [PATCH]  unshare01.sh: protect parameters expansion
Message-ID: <20181119154740.55898-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The script passes around as args some strings with spaces using
positional parameters: these are then in turn used unquoted to declare
local function vars; this usage of 'local' together with the unquoted
expansion is broken and leads to:

unshare_test()
{
        local unshare_opts=$1
        local verify_cmd=$2        <<<----124:
...
case $1 in
 unshare_test "--user" "id -u" "65534";;
....

unshare01.sh: 124: local: -u: bad variable name

This works fine on Bash but not on Dash (despite not being detected
by checkbashism) and it is closely related to the use of 'local';
i.e. removing instead 'local' while leaving the unquoted expansion
solves too.

Protect the positional parameter expansion with double quotes to
prevent globbing and word splitting.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/commands/unshare/unshare01.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
index 71b50ba3a..075511fd7 100755
--- a/testcases/commands/unshare/unshare01.sh
+++ b/testcases/commands/unshare/unshare01.sh
@@ -81,9 +81,9 @@ cleanup()
 
 check_id()
 {
-	local act_id=$1
-	local exp_id=$2
-	local cmd=$3
+	local act_id="$1"
+	local exp_id="$2"
+	local cmd="$3"
 
 	if [ ${act_id} -ne ${exp_id} ]; then
 		tst_res TFAIL "$cmd got wrong uid/gid"
@@ -94,9 +94,9 @@ check_id()
 
 check_mount()
 {
-	local tst_dir=$1
-	local exp_stat=$2
-	local cmd=$3
+	local tst_dir="$1"
+	local exp_stat="$2"
+	local cmd="$3"
 
 	case ${exp_stat} in
 	unmounted)
@@ -120,9 +120,9 @@ check_mount()
 
 unshare_test()
 {
-	local unshare_opts=$1
-	local verify_cmd=$2
-	local exp_result=$3
+	local unshare_opts="$1"
+	local verify_cmd="$2"
+	local exp_result="$3"
 
 	local unshare_cmd="unshare ${unshare_opts} ${verify_cmd}"
 
-- 
2.17.1

