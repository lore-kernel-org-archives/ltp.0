From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:54 +0800
Subject: [LTP] [PATCH ltp 5/6] network/tcp_cmds/host/host01: Fix shellcheck
	issue SC2069
In-Reply-To: <20180420031855.22657-1-yixin.zhang@intel.com>
References: <20180420031855.22657-1-yixin.zhang@intel.com>
Message-ID: <20180420031855.22657-5-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: The order of the 2>&1 and the redirect matters. The 2>&1 has to
be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/network/tcp_cmds/host/host01 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/host/host01 b/testcases/network/tcp_cmds/host/host01
index fb59e35fa..1308870f7 100755
--- a/testcases/network/tcp_cmds/host/host01
+++ b/testcases/network/tcp_cmds/host/host01
@@ -60,8 +60,8 @@ do_test()
     while [ $TST_COUNT -lt $NUMLOOPS ]; do
 
         if rhost_addr=$(host $RHOST); then
-            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') 2>&1 >/dev/null
-            if ! host $rhost_addr 2>&1 >/dev/null; then
+            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') >/dev/null 2>&1
+            if ! host $rhost_addr >/dev/null 2>&1; then
                 end_testcase "reverse lookup with host failed"
             fi
 
-- 
2.14.1

