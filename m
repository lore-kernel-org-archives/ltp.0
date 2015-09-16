From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 16 Sep 2015 01:05:46 +0000
Subject: [LTP]  [PATCH] ftp/ftp02: The case needs to check vsftpd first
Message-ID: <1442365546-63246-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ftp02 case will use vsftpd so we should check it first

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/tcp_cmds/ftp/ftp02 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
index 92e7944..6b84f22 100755
--- a/testcases/network/tcp_cmds/ftp/ftp02
+++ b/testcases/network/tcp_cmds/ftp/ftp02
@@ -38,7 +38,7 @@
 
 setup()
 {
-	tst_check_cmds expect ftp useradd userdel
+	tst_check_cmds expect ftp useradd userdel vsftpd
 	export TEST_USER="ftpuser2"
 }
 
-- 
1.6.0.2

