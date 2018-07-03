From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:07 +0200
Subject: [LTP] [PATCH v3 7/9] net/virt_lib.sh: Remove possibility to pass
	custom sizes to virt_netperf_msg_sizes()
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove unused client_requests=20000

Custom sizes haven't been used yet.
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
 testcases/network/virt/virt_lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index eaec33d8f..66f10bd41 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -328,8 +328,7 @@ virt_macsec_setup()
 
 virt_netperf_msg_sizes()
 {
-	local sizes="${@:-100 1000 2000 10000}"
-	client_requests=20000
+	local sizes="100 1000 2000 10000"
 
 	for s in $sizes; do
 		virt_compare_netperf pass "-n $s -N $s"
-- 
2.18.0

