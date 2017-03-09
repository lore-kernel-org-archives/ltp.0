From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Mar 2017 14:34:10 +0100
Subject: [LTP] [PATCH 2/2] daemonlib: Use is-active instead of status for
	systemctl
In-Reply-To: <20170309133410.8540-1-pvorel@suse.cz>
References: <20170309133410.8540-1-pvorel@suse.cz>
Message-ID: <20170309133410.8540-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'systemctl status service' exit code is broken in old distros. It
returns 0 even if service is not running. As we use status_daemon for
detecting whether service is running, it's more reliable to use
is-active.

systemctl bug was introduced in systemd v209 (f74294c1d), fixed in v213
(5bb75bc74).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/daemonlib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/daemonlib.sh b/testcases/lib/daemonlib.sh
index 2dcb1554d..0de3f86af 100644
--- a/testcases/lib/daemonlib.sh
+++ b/testcases/lib/daemonlib.sh
@@ -69,7 +69,7 @@ stop_daemon()
 status_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
-		systemctl status $1.service > /dev/null 2>&1
+		systemctl is-active $1.service > /dev/null 2>&1
 	elif command -v service >/dev/null 2>&1; then
 		service $1 status > /dev/null 2>&1
 	else
-- 
2.12.0

