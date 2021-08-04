From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed,  4 Aug 2021 15:04:45 +0300
Subject: [LTP] [PATCH 2/3] network/tst_net.sh: fix busybox/sysctl in
 tst_set_sysctl()
In-Reply-To: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210804120446.32835-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

busybox/sysctl expects -e option to be set before 'name=value'.
This can easily be fixed by splitting the string in tst_set_sysctl(),
so that 'rparam' with '-e' option is added in between.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 511fb7eb1..bb30c13ec 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -918,7 +918,7 @@ tst_set_sysctl()
 	local rparam=
 	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"
 
-	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
+	tst_net_run $safe $rparam "sysctl -q -w" "$name=$value"
 }
 
 tst_cleanup_rhost()
-- 
2.25.1

