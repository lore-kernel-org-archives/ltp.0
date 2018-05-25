From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 25 May 2018 15:51:39 +0800
Subject: [LTP] [PATCH ltp] network/stress/ssh/ssh-stress01-rmt: fix
	shellcheck error
Message-ID: <20180525075139.12349-1-yixin.zhang@intel.com>
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
 testcases/network/stress/ssh/ssh-stress01-rmt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/ssh/ssh-stress01-rmt b/testcases/network/stress/ssh/ssh-stress01-rmt
index 2a84957ca..3f670a3b8 100644
--- a/testcases/network/stress/ssh/ssh-stress01-rmt
+++ b/testcases/network/stress/ssh/ssh-stress01-rmt
@@ -54,7 +54,7 @@ done
 all_conn=$(ps auxw | grep -Fv grep | \
 	grep "ssh[[:blank:]].*${ssh_config}" | awk '{print $2}')
 
-for ssh_pid in "$all_conn"; do
+for ssh_pid in $all_conn; do
 	kill $ssh_pid
 done
 
-- 
2.14.1

