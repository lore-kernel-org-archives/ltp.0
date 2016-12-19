From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Dec 2016 13:54:07 +0100
Subject: [LTP] [PATCH] network: fix export for some non-bash shells
Message-ID: <20161219125407.15954-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

exporting with fails in some non-bash shels (at least on dash),
export: -n: bad variable name
=> quotation marks must be around whole expression.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f5321d73a..1d350fdd1 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -378,7 +378,7 @@ tst_ping()
 export RHOST="$RHOST"
 export PASSWD=${PASSWD:-""}
 # Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
-export LTP_RSH=${LTP_RSH:-"rsh -n"}
+export LTP_RSH="${LTP_RSH:-rsh -n}"
 
 # Test Links
 # Set first three octets of the network address, default is '10.0.0'
-- 
2.11.0

