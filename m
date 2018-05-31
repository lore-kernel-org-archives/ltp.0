From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 31 May 2018 10:37:40 +0800
Subject: [LTP] [PATCH v2 ltp] network/stress/ssh/ssh-stress01-rmt: fix
	shellcheck error
Message-ID: <20180531023740.22811-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

testcases/network/stress/ssh/ssh-stress01-rmt:57:16: error: Since you
double quoted this, it will not word split, and the loop will only run
once. [SC2066]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/network/stress/ssh/ssh-stress01-rmt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/network/stress/ssh/ssh-stress01-rmt b/testcases/network/stress/ssh/ssh-stress01-rmt
index 2a84957ca..b2f65793e 100644
--- a/testcases/network/stress/ssh/ssh-stress01-rmt
+++ b/testcases/network/stress/ssh/ssh-stress01-rmt
@@ -53,10 +53,7 @@ done
 # Disconnect all ssh connection
 all_conn=$(ps auxw | grep -Fv grep | \
 	grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}')
-
-for ssh_pid in "$all_conn"; do
-	kill $ssh_pid
-done
+kill $all_conn
 
 # Check the connectivity again
 ssh -$ip_ver -F $ssh_config $server_ipaddr \
-- 
2.14.1

