From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  3 May 2017 16:50:16 +0200
Subject: [LTP] [RFC] [PATCH] commands/which01.sh: Fix test for debian.
Message-ID: <20170503145016.27519-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The which binary on Debian comes from debianutils package and not from
the which package (like it is on the most of the distros). It does not
support most of the options, which is fine, since the test produces
TCONF for these but also returns relative path instead of absolute one.

So this patch adds alternate version for the expected path and the test
passes if at least one of them matches.

Fixes #151.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/which/which01.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
index 579ac5b..eb87095 100755
--- a/testcases/commands/which/which01.sh
+++ b/testcases/commands/which/which01.sh
@@ -42,8 +42,13 @@ which_verify()
 {
 	until [ -z "$1" ]
 	do
-		grep -q "$1" temp
-		if [ $? -ne 0 ]; then
+		found="no"
+		for i in $1; do
+			if grep -q "$i" temp; then
+				found="yes"
+			fi
+		done
+		if [ "$found" != "yes" ]; then
 			echo "'$1' not found in:"
 			cat temp
 			echo
@@ -93,9 +98,9 @@ which_test()
 do_test()
 {
 	case $1 in
-	1) which_test "" "pname" "$PWD/pname";;
+	1) which_test "" "pname" "$PWD/pname ./pname";;
 	2) which_test "--all" "pname" "$PWD/bin/pname" "$PWD/pname";;
-	3) which_test "-a" "pname" "$PWD/bin/pname" "$PWD/pname";;
+	3) which_test "-a" "pname" "$PWD/bin/pname ./bin/pname" "$PWD/pname ./pname";;
 	4) which_test "--read-alias" "pname" "pname='pname -i'" "$PWD/pname";;
 	5) which_test "-i" "pname" "pname='pname -i'" "$PWD/pname";;
 	6) alias which='which --read-alias';
-- 
2.10.2

