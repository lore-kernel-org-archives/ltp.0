From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jun 2021 17:10:12 +0200
Subject: [LTP] [PATCH 2/2] tst_ipaddr_un.sh: Properly disable netns
 initialization
In-Reply-To: <20210603151012.14760-1-pvorel@suse.cz>
References: <20210603151012.14760-1-pvorel@suse.cz>
Message-ID: <20210603151012.14760-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It stopped working due 40110018e, but even before there were issues:

tst_ipaddr_un 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
tst_ipaddr_un 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
cat: /sys/class/net/eth0/mtu: No such file or directory
cat: /sys/class/net/eth0/address: No such file or directory

Fixes: 807d60628 ("net: Add tst_ipaddr_un.sh test")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/net/tst_ipaddr_un.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/newlib_tests/shell/net/tst_ipaddr_un.sh b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
index 512d6d880..e7730b8d0 100755
--- a/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
+++ b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
@@ -7,8 +7,11 @@ TST_CNT=2
 
 PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
 
-# workaround to disable netns initialization
-RHOST="foo"
+TST_NET_SKIP_VARIABLE_INIT=1
+
+# from tst_net_vars.c
+IPV4_NET16_UNUSED="10.23"
+IPV6_NET32_UNUSED="fd00:23"
 
 . tst_net.sh
 
-- 
2.31.1

