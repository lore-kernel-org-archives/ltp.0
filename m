From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 May 2018 11:16:26 +0200
Subject: [LTP] [PATCH 1/1] net/virt_lib.sh: Fix quoting default variable on
	dash
Message-ID: <20180515091626.16121-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dash (and maybe some other posix shells) needs quoting whole argument,
otherwise it's not able to assert:

/opt/ltp/testcases/bin/ipvlan01.sh: 384: local: l2,mode: bad variable name
/opt/ltp/testcases/bin/vlan01.sh: 360: local: ,protocol: bad variable name

The problem was in $opt, change also $start_id to use the same convention.

Fixes: dcacbcffe ("network/virt: add test-case 01 to virt_lib.sh")
       94aac42a0 ("network/virt: add test-case 02 to virt_lib.sh")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/virt_lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 72946c5be..095dbf3a3 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -356,8 +356,8 @@ virt_netperf_msg_sizes()
 # OPTIONS - different options separated by comma.
 virt_test_01()
 {
-	start_id=${start_id:-"1"}
-	local opts=${1:-""}
+	start_id="${start_id:-1}"
+	local opts="${1:-}"
 	local n=0
 
 	while true; do
@@ -380,8 +380,8 @@ virt_test_01()
 # OPTIONS - different options separated by comma.
 virt_test_02()
 {
-	start_id=${start_id:-"1"}
-	local opts=${1:-""}
+	start_id="${start_id:-1}"
+	local opts="${1:-}"
 	local n=0
 
 	while true; do
-- 
2.16.3

