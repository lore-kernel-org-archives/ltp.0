From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:45 +0200
Subject: [LTP] [PATCH v2 6/8] net/virt_lib.sh: Remove possibility to pass
	custom sizes
In-Reply-To: <20180622151047.13002-1-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
Message-ID: <20180622151047.13002-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to virt_netperf_msg_sizes(). Custom sizes haven't been used yet.

This is a preparation for next commit, which (while rewriting tests into
new shell API) start using virt_netperf_msg_sizes() as test functions
directly (as in new API it gets $1 for test number since 4bcc0addf.

    TST_TESTFUNC="virt_netperf_msg_sizes"

instead of wrapping it into function:

    TST_TESTFUNC="do_test"
    do_test()
    {
	virt_netperf_msg_sizes
    }

Actually the best would be to replace sizes array in function with
TST_TEST_DATA, but that would require split tests cases, which use
virt_netperf_msg_sizes() with other functions, which are without arrays
(e.g. virt_compare_netperf() and virt_minimize_timeout() in vlan03.sh,
geneve01.sh abd vxlan03.sh)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
If you don't like it, I'll just use version with TST_TESTFUNC="do_test"
in next commit. Using TST_TEST_DATA is TODO (if you're interested, I'd
do it after having done this patch).
---
 testcases/network/virt/virt_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index eaec33d8f..f92c38fd2 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -328,7 +328,7 @@ virt_macsec_setup()
 
 virt_netperf_msg_sizes()
 {
-	local sizes="${@:-100 1000 2000 10000}"
+	local sizes="100 1000 2000 10000"
 	client_requests=20000
 
 	for s in $sizes; do
-- 
2.17.1

