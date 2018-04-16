From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Apr 2018 00:11:41 +0200
Subject: [LTP] [PATCH 1/1] network/vxlan02.sh: Fix duplicate parameters
Message-ID: <20180416221141.2781-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

vxlan02 and vxlan02_ipv6 tests had duplicate parameters 'dev ltp_ns_veth2':
ip li add ltp_v0 type vxlan dstport 0 id 16700000 group 239.1.1.1 dev ltp_ns_veth2 dev ltp_ns_veth2
Error: either "dev" is duplicate, or "ltp_ns_veth2" is a garbage.

Device was specified in in both the test file itself and in virt_add() function in virt_lib.sh.
Removed in test to be consistent with vlan02.sh.

Fixes: 8e5862c20 ("net: vxlan02: specify interface when adding multicast dst")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/vxlan02.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 07cf656d7..db152afdf 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -33,6 +33,6 @@ TST_USE_LEGACY_API=1
 [ "$TST_IPV6" ] && mult_addr="ff02::abc" || mult_addr="239.1.1.1"
 opt="group $mult_addr"
 
-virt_add_delete_test "id $start_id $opt dev $(tst_iface)"
+virt_add_delete_test "id $start_id $opt"
 
 tst_exit
-- 
2.16.3

