From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed,  4 Aug 2021 15:04:46 +0300
Subject: [LTP] [PATCH 3/3] network/tst_net.sh: extend the pattern in
 tst_ping_opt_unsupported()
In-Reply-To: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210804120446.32835-3-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index bb30c13ec..c15413a6d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -811,7 +811,7 @@ tst_netload_compare()
 
 tst_ping_opt_unsupported()
 {
-	ping $@ 2>&1 | grep -q "invalid option"
+	ping $@ 2>&1 | grep -qE "(invalid|unrecognized) option"
 }
 
 # tst_ping -c COUNT -s MESSAGE_SIZES -p PATTERN -I IFACE -H HOST
-- 
2.25.1

