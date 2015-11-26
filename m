From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 27 Nov 2015 00:16:58 +0800
Subject: [LTP] [PATCH] sssd/sssd-lib.sh: fix the permission of sssd.conf
Message-ID: <1448554618-24055-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to restart sssd service successfully, the permission of sssd.conf should be set to 0600.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/commands/sssd/sssd-lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/sssd/sssd-lib.sh b/testcases/commands/sssd/sssd-lib.sh
index 9c84729..ab16fd4 100755
--- a/testcases/commands/sssd/sssd-lib.sh
+++ b/testcases/commands/sssd/sssd-lib.sh
@@ -114,7 +114,12 @@ setup()
 				$NSS_CONFIG_FILE
 		fi
 	else
-		tst_brkm TBROK NULL "$CONFIG_FILE not found!"
+		tst_resm TWARN "$CONFIG_FILE not found!"
+		touch $CONFIG_FILE
+	fi
+	chmod 0600 $CONFIG_FILE
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK NULL "fail to modify the permission of $CONFIG_FILE"
 	fi
 }
 
-- 
1.8.3.1



