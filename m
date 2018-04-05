From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  5 Apr 2018 14:05:55 +0300
Subject: [LTP] [PATCH 2/2] nfs06: decrease number of processes per fsstress
	run
In-Reply-To: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
References: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1522926355-18029-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From 50 to 10. It multiplies by number of mounts and
can slow test execution significantly.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs06 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
index eb35157..33c2d5a 100755
--- a/testcases/network/nfs/nfs_stress/nfs06
+++ b/testcases/network/nfs/nfs_stress/nfs06
@@ -34,7 +34,7 @@ do_test()
 	local n=0
 	local pids
 	for i in $VERSION; do
-		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 50 -r -c > /dev/null &
+		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 10 -r -c > /dev/null &
 		pids="$pids $!"
 		n=$(( n + 1 ))
 	done
-- 
1.7.1

