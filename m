From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 May 2018 11:40:53 +0200
Subject: [LTP] [PATCH 1/1] net/sctp: Fix parsing input variables in dash
Message-ID: <20180515094053.18355-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dash (and maybe some other posix shells) cannot handle unquoted $@.
It needs to be quoted when calling otherwise leads to error:
/opt/ltp/testcases/bin/sctp01.sh: 40: local: 65000: bad variable name

This is a quick fix, better than working with input parameters would be
add another test case in runtest/net.features.

Fixes: 7ade6a32e ("sctp: add test-case with random payload")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/sctp/sctp01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index bf13521c2..c4149af19 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -58,6 +58,6 @@ test_run()
 
 setup
 test_run
-test_run -A 65000
+test_run '-A 65000'
 
 tst_exit
-- 
2.16.3

