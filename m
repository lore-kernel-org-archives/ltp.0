From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 25 May 2018 15:44:47 +0800
Subject: [LTP] [PATCH ltp] kernel/fs/doio/rwtest: fix shellcheck error
Message-ID: <20180525074447.26298-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

testcases/kernel/fs/doio/rwtest:199:12: error: > is for string comparisons. Use -gt instead. [SC2071]
testcases/kernel/fs/doio/rwtest:320:10: error: Globs are ignored in [[ ]] except right of =/!=. Use a loop. [SC2203]
testcases/kernel/fs/doio/rwtest:347:7: error: Couldn't parse this test expression. [SC1073]
testcases/kernel/fs/doio/rwtest:347:25: error: Expected test to end here (don't wrap commands in []/[[]]).
                                               Fix any mentioned problems and try again. [SC1072]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/fs/doio/rwtest | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
index 90b1658f5..bd6bf9de2 100644
--- a/testcases/kernel/fs/doio/rwtest
+++ b/testcases/kernel/fs/doio/rwtest
@@ -196,7 +196,7 @@ do	case $1 in
 	-n | -Dn )
 		dOpts="$dOpts $1 $2"
 		# force file locking with > 1 process
-		if [[ $2 > 1 ]]
+		if [[ $2 -gt 1 ]]
 		then
 			dOpts="$dOpts -k"
 		fi
@@ -317,7 +317,7 @@ do
 		typeset -i n=0
 		while (( n < ${#szcache[*]} ))
 		do
-			if [[ szcache[$n] = $dir ]]; then
+			if [[ ${szcache[n]} = $dir ]]; then
 				break;
 			fi
 			n=n+1
@@ -344,7 +344,7 @@ do
 
 			# check if blks is a number, else set a default value for blks
 			default_sz=1000000
-			if [ $blks -eq $blks 2> /dev/null ]
+			if [ $blks -eq $blks ] 2>/dev/null
 			then
 
 				case $(uname) in
-- 
2.14.1

