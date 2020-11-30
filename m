From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 30 Nov 2020 17:02:35 +0100
Subject: [LTP] [PATCH] net/ip_tests: Return TCONF if ip command can not
 create dummy interface
Message-ID: <20201130160235.25105-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test if the dummy interface can be created, return TCONF if not.
Move ip4_addr before, to have it defined and avoid cleanup error.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/iproute/ip_tests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index 41c515696..1f0c4634d 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -23,11 +23,14 @@ init()
 	tst_res TINFO "inititalizing tests"
 
 	iface=ltp_dummy
+	ip4_addr=${IPV4_NET16_UNUSED}.6.6
 	lsmod | grep -q dummy || rm_dummy=1
 
-	ROD ip li add $iface type dummy
+	if ! ip li add $iface type dummy >/dev/null; then
+		rm_dummy=
+		tst_brk TCONF "Module 'dummy' not found"
+	fi
 
-	ip4_addr=${IPV4_NET16_UNUSED}.6.6
 	ROD ip a add ${ip4_addr}/24 dev $iface
 
 	cat > tst_ip02.exp <<-EOF
-- 
2.17.1

