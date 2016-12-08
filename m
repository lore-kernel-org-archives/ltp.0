From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Dec 2016 10:54:06 +0100
Subject: [LTP] [PATCH v2 1/2] network: fix printing commands in verbose mode
Message-ID: <20161208095407.9948-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Copy & paste error from testscripts/networkstress.sh

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 6b81823f9..2d2c6762c 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -94,7 +94,7 @@ if [ ${VERBOSE} = "yes" ]; then
 	echo " - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})"
 	echo " - ${RHOST_IFACES} remote interface (MAC address: ${RHOST_HWADDRS})"
 
-	cat $TMPDIR/network_stress.tests
+	cat $CMDFILE
 	${LTPROOT}/ver_linux
 	echo ""
 	echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
-- 
2.11.0

