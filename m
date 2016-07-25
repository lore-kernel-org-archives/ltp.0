From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 25 Jul 2016 15:52:03 +0300
Subject: [LTP] [PATCH] du01: create the temp file outside of the working
	directory
Message-ID: <1469451123-9296-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I noticed that with older kernels and with XFS the 'du -B 512'
scenario of this test case may fail:

[root@kholmanskikh du01]# uname -r
3.8.13-98.2.2.el6uek.x86_64
[root@kholmanskikh du01]# ls -l
total 10240
drwxr-xr-x 2 root root       24 Jul 25 14:48 testdir
-rw-r--r-- 1 root root 10485760 Jul 25 14:48 testfile
[root@kholmanskikh du01]# du -B 512
0		   ./testdir
20480		   .
[root@kholmanskikh du01]# du -B 512 > temp; cat temp
0		   ./testdir
20608		   .
[root@kholmanskikh du01]#

This happens because we create 'temp' file in the working directory,
i.e. 'temp' may already contain some data at the moment 'du' tries
to 'fstat' it.

So let's keep the working directory clean and create any extra
files outside of it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/commands/du/du01.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 799099e..df0fea9 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -31,6 +31,9 @@ setup()
 	tst_tmpdir
 	TST_CLEANUP=cleanup
 
+	ROD_SILENT mkdir basedir
+	ROD_SILENT cd basedir
+
 	ROD_SILENT dd if=/dev/zero of=testfile bs=1M count=10
 
 	ROD_SILENT mkdir -p testdir
@@ -53,11 +56,11 @@ du_test()
 {
 	local test_return
 
-	$1 > temp 2>&1
+	$1 > ../temp 2>&1
 	test_return=$?
 
 	if [ ${test_return} -ne 0 ]; then
-		grep -q -E "unrecognized option|invalid option" temp
+		grep -q -E "unrecognized option|invalid option" ../temp
 		if [ $? -eq 0 ]; then
 			tst_resm TCONF "'$1' not supported"
 		else
@@ -66,13 +69,13 @@ du_test()
 		return
 	fi
 
-	grep -q $2 temp
+	grep -q $2 ../temp
 	if [ $? -eq 0 ]; then
 		tst_resm TPASS "'$1' passed"
 	else
 		tst_resm TFAIL "'$1' failed"
 		tst_resm TINFO "Looking for '$2' in:"
-		cat temp
+		cat ../temp
 	fi
 }
 
-- 
1.7.1

