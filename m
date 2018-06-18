From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jun 2018 19:37:03 +0200
Subject: [LTP] [PATCH 2/6] tst_test.sh: Introduce TST_LIB_LOADED
In-Reply-To: <20180618173707.30351-1-pvorel@suse.cz>
References: <20180618173707.30351-1-pvorel@suse.cz>
Message-ID: <20180618173707.30351-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This allows to detect whether library was loaded more than once.
This is used by tst_net.sh (which is loaded more than once itself
by tests macsec0{1,2}.sh)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d27b4afd6..c0ffc3316 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -29,6 +29,7 @@ export TST_CONF=0
 export TST_COUNT=1
 export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
+export TST_LIB_LOADED=1
 
 . tst_ansi_color.sh
 
-- 
2.17.1

