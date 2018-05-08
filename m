From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 8 May 2018 11:12:21 +0800
Subject: [LTP] [PATCH] lib/tst_net.sh: Detect quoted parameters correctly
In-Reply-To: <20180507193234.6810-2-pvorel@suse.cz>
References: <20180507193234.6810-2-pvorel@suse.cz>
Message-ID: <1525749141-29004-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we pass $* to tst_net_read_opts, we cannot detect quoted parameters
correctly, which process only first number from quoted parameters.
For example, running sctp_ipsec.sh -s "100 1000 65535":
------------------------------------------------------
...
sctp_ipsec 1 TINFO: run server 'netstress -T sctp -S 10.167.220.185 -R 500000 -B /tmp/sctp_ipsec.8MpnrPPXkq'
sctp_ipsec 1 TINFO: run client 'netstress -l -T sctp -H 10.167.220.185 -n 100 -N 100 -S 10.167.220.179 -a 2 -r 500 -d tst_netload.res -g 50802'
sctp_ipsec 1 TPASS: netstress passed, time spent '397' ms
------------------------------------------------------

We solve this issue by passing "$@" to tst_net_read_opts.
For example, running sctp_ipsec.sh -s "100 1000 65535":
------------------------------------------------------
...
sctp_ipsec 1 TINFO: run server 'netstress -T sctp -S 10.167.220.185 -R 500000 -B /tmp/sctp_ipsec.93mw7qy2BW'
sctp_ipsec 1 TINFO: run client 'netstress -l -T sctp -H 10.167.220.185 -n 100 -N 100 -S 10.167.220.179 -a 2 -r 500 -d tst_netload.res -g 36311'
sctp_ipsec 1 TPASS: netstress passed, time spent '254' ms
sctp_ipsec 2 TINFO: run server 'netstress -T sctp -S 10.167.220.185 -R 500000 -B /tmp/sctp_ipsec.93mw7qy2BW'
sctp_ipsec 2 TINFO: run client 'netstress -l -T sctp -H 10.167.220.185 -n 1000 -N 1000 -S 10.167.220.179 -a 2 -r 500 -d tst_netload.res -g 45078'
sctp_ipsec 2 TPASS: netstress passed, time spent '276' ms
sctp_ipsec 3 TINFO: run server 'netstress -T sctp -S 10.167.220.185 -R 500000 -B /tmp/sctp_ipsec.93mw7qy2BW'
sctp_ipsec 3 TINFO: run client 'netstress -l -T sctp -H 10.167.220.185 -n 65535 -N 65535 -S 10.167.220.179 -a 2 -r 500 -d tst_netload.res -g 36871'
sctp_ipsec 3 TPASS: netstress passed, time spent '1288' ms
------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 32b4f09..df850a0 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -78,7 +78,7 @@ if [ -z "$TST_LIB_LOADED" ]; then
 fi
 
 if [ -n "$TST_USE_LEGACY_API" ]; then
-	tst_net_read_opts $*
+	tst_net_read_opts "$@"
 	ipver=${TST_IPV6:-4}
 fi
 
-- 
1.8.3.1



