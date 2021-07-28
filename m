From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Wed, 28 Jul 2021 17:04:53 +0300
Subject: [LTP] [PATCH v2] ipsec_lib.sh: check ip_vti/ip6_vti are enabled or
 skip tests
In-Reply-To: <YQFWT/0MBcZsLNVV@pevik>
References: <YQFWT/0MBcZsLNVV@pevik>
Message-ID: <20210728140453.23356-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In network stress test groups there are tests expecting
CONFIG_NET_IPVTI/CONFIG_IPV6_VTI to be enabled in the kernel,
and if it's not they fail. There is a check for VTI support in
the ip utility, but not for the kernel. Skip these tests if
there is no ip_vti/ip6_vti support in the kernel.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index e395e1ff3..fce05622d 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -292,6 +292,14 @@ tst_ipsec_setup_vti()
 
 	tst_res TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
 
+	if [ "$TST_IPV6" ]; then
+                tst_net_run -q "tst_check_drivers ip6_vti" || \
+                        tst_brk TCONF "ip6_vti driver not available on lhost or rhost"
+        else
+                tst_net_run -q "tst_check_drivers ip_vti" || \
+                        tst_brk TCONF "ip_vti driver not available on lhost or rhost"
+        fi
+
 	tst_ipsec_vti lhost $ip_loc $ip_rmt $tst_vti
 	tst_ipsec_vti rhost $ip_rmt $ip_loc $tst_vti
 
-- 
2.26.2

