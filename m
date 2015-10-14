From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 14 Oct 2015 12:27:46 +0300
Subject: [LTP] [Committed 3/3] network/nfs_stress/nfs04: print TPASS in the
	end of the test
In-Reply-To: <1444814866-20311-1-git-send-email-alexey.kodanev@oracle.com>
References: <1444814866-20311-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1444814866-20311-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs04 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
index b2375ab..e200227 100755
--- a/testcases/network/nfs/nfs_stress/nfs04
+++ b/testcases/network/nfs/nfs_stress/nfs04
@@ -34,5 +34,6 @@ nfs_setup
 
 tst_resm TINFO "create 10M file"
 ROD nfs04_create_file 10 nfs04.testfile
+tst_resm TPASS "Test finished"
 
 tst_exit
-- 
1.7.1

