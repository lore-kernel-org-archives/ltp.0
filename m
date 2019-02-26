From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 26 Feb 2019 19:23:33 +0300
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: use SO_BINDTODEVICE in
	tst_netload()
In-Reply-To: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1551198213-10024-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since we have the information about the device, enable the
usage of the option, when starting netstress.

It can be disabled with TST_NETLOAD_BINDTODEVICE=0.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7625c51..9e26cee 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -537,6 +537,7 @@ tst_netload()
 	# number of server replies after which TCP connection is closed
 	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
 	local s_opts=
+	local bind_to_device=1
 
 	if [ ! "$TST_NEEDS_TMPDIR" = 1 ]; then
 		tst_brk_ TBROK "Using tst_netload requires setting TST_NEEDS_TMPDIR=1"
@@ -564,7 +565,8 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		D) cs_opts="${cs_opts}-D $OPTARG " ;;
+		D) cs_opts="${cs_opts}-D $OPTARG "
+		   bind_to_device=0 ;;
 		*) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
@@ -572,6 +574,11 @@ tst_netload()
 
 	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
 
+	if [ "$bind_to_device" = 1 -a "$TST_NETLOAD_BINDTODEVICE" = 1 ]; then
+		c_opts="${c_opts}-D $(tst_iface) "
+		s_opts="${s_opts}-D $(tst_iface rhost) "
+	fi
+
 	local expect_ret=0
 	[ "$expect_res" != "pass" ] && expect_ret=3
 
@@ -788,6 +795,7 @@ fi
 
 export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
 export TST_NETLOAD_CLN_NUMBER="${TST_NETLOAD_CLN_NUMBER:-2}"
+export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE:-1}"
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
 export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
-- 
1.7.1

