From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 8 Oct 2015 16:55:51 +0800
Subject: [LTP]  [PATCH v2] ftp: Move commands check to ftp_setup
In-Reply-To: <20150929164530.GA32482@rei.suse.cz>
References: <1442365546-63246-1-git-send-email-cuibixuan@huawei.com>
 <20150929164530.GA32482@rei.suse.cz>
Message-ID: <56162F97.6030905@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move commands check to ftp_setup and add vsftpd check to ftp02

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/network/tcp_cmds/ftp/ftp02     |    1 -
 testcases/network/tcp_cmds/ftp/ftp03     |    1 -
 testcases/network/tcp_cmds/ftp/ftp04     |    2 --
 testcases/network/tcp_cmds/ftp/ftp05     |    1 -
 testcases/network/tcp_cmds/ftp/ftp_setup |    2 ++
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp02 b/testcases/network/tcp_cmds/ftp/ftp02
index 92e7944..1316109 100755
--- a/testcases/network/tcp_cmds/ftp/ftp02
+++ b/testcases/network/tcp_cmds/ftp/ftp02
@@ -38,7 +38,6 @@

 setup()
 {
-	tst_check_cmds expect ftp useradd userdel
 	export TEST_USER="ftpuser2"
 }

diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
index 4ad5560..e2925e8 100755
--- a/testcases/network/tcp_cmds/ftp/ftp03
+++ b/testcases/network/tcp_cmds/ftp/ftp03
@@ -33,7 +33,6 @@

 setup()
 {
-	tst_check_cmds ftp useradd userdel vsftpd
 	export TEST_USER="ftpuser3"
 }

diff --git a/testcases/network/tcp_cmds/ftp/ftp04 b/testcases/network/tcp_cmds/ftp/ftp04
index f38640d..1327b8e 100755
--- a/testcases/network/tcp_cmds/ftp/ftp04
+++ b/testcases/network/tcp_cmds/ftp/ftp04
@@ -30,8 +30,6 @@

 setup()
 {
-	tst_check_cmds awk expect ftp vsftpd
-
 	TEST_USER=root

 	tvar=${MACHTYPE%-*}
diff --git a/testcases/network/tcp_cmds/ftp/ftp05 b/testcases/network/tcp_cmds/ftp/ftp05
index 65a8a67..e9e4272 100755
--- a/testcases/network/tcp_cmds/ftp/ftp05
+++ b/testcases/network/tcp_cmds/ftp/ftp05
@@ -38,7 +38,6 @@

 setup()
 {
-	tst_check_cmds expect ftp vsftpd
 	TEST_USER="anonymous"
 }

diff --git a/testcases/network/tcp_cmds/ftp/ftp_setup b/testcases/network/tcp_cmds/ftp/ftp_setup
index 1731a6d..f148281 100644
--- a/testcases/network/tcp_cmds/ftp/ftp_setup
+++ b/testcases/network/tcp_cmds/ftp/ftp_setup
@@ -26,6 +26,8 @@ do_setup()
 	export TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
 	export TEST_USER_HOMEDIR="/home/$TEST_USER"

+	tst_check_cmds awk expect ftp useradd userdel vsftpd
+
 	for vsftp_confdir in /etc/vsftpd /etc; do
 		if [ -r "$vsftp_confdir/vsftpd.conf" ]; then
 			VSFTP_CONF="$vsftp_confdir/vsftpd.conf"
-- 
1.6.0.2 .

