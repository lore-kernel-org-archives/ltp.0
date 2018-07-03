From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:03 +0200
Subject: [LTP] [PATCH v3 3/9] tst_net.sh: Introduce TST_LIB_NET_LOADED
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to load it only once.

Some tests (macsec0{1,2}.sh) load tst_net.sh twice via loading from
ipsec_lib.sh and virt_lib.sh. That brings duplicity in some variables
(TST_OPTS) and create infinite loop, as tst_net_setup calls itself.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index aad701952..507d5b788 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -19,6 +19,9 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 
+[ -n "$TST_LIB_NET_LOADED" ] && return 0
+TST_LIB_NET_LOADED=1
+
 TST_OPTS="6$TST_OPTS"
 TST_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_PARSE_ARGS="tst_net_parse_args"
@@ -73,9 +76,7 @@ tst_net_setup()
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
-if [ -z "$TST_LIB_LOADED" ]; then
-	[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
-fi
+[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
 if [ -n "$TST_USE_LEGACY_API" ]; then
 	tst_net_read_opts "$@"
-- 
2.18.0

