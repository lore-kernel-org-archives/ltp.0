From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:30 +0200
Subject: [LTP] [RFC PATCH v8 04/11] network/stress: Reduce the default
	number of cycles for various tests
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reducing value to one fifth resp. one tenth should be enough even for
stress testing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 6575c77f4..1357ea5b5 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -621,20 +621,20 @@ export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
 export FTP_UPLOAD_URLDIR="${FTP_UPLOAD_URLDIR:-pub}"
 
 # network/stress tests require additional parameters
-export NS_DURATION="${NS_DURATION:-3600}"
-export NS_TIMES="${NS_TIMES:-10000}"
+export NS_DURATION="${NS_DURATION:-720}"
+export NS_TIMES="${NS_TIMES:-2000}"
 export CONNECTION_TOTAL="${CONNECTION_TOTAL:-4000}"
-export IP_TOTAL="${IP_TOTAL:-10000}"
+export IP_TOTAL="${IP_TOTAL:-2000}"
 export IP_TOTAL_FOR_TCPIP="${IP_TOTAL_FOR_TCPIP:-100}"
-export ROUTE_TOTAL="${ROUTE_TOTAL:-10000}"
+export ROUTE_TOTAL="${ROUTE_TOTAL:-2000}"
 export MTU_CHANGE_TIMES="${MTU_CHANGE_TIMES:-1000}"
-export IF_UPDOWN_TIMES="${IF_UPDOWN_TIMES:-10000}"
+export IF_UPDOWN_TIMES="${IF_UPDOWN_TIMES:-2000}"
 export DOWNLOAD_BIGFILESIZE="${DOWNLOAD_BIGFILESIZE:-2147483647}"
 export DOWNLOAD_REGFILESIZE="${DOWNLOAD_REGFILESIZE:-1048576}"
 export UPLOAD_BIGFILESIZE="${UPLOAD_BIGFILESIZE:-2147483647}"
 export UPLOAD_REGFILESIZE="${UPLOAD_REGFILESIZE:-1024}"
 export MCASTNUM_NORMAL="${MCASTNUM_NORMAL:-20}"
-export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-40000}"
+export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-4000}"
 
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
 
-- 
2.13.2

