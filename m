From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Dec 2020 08:15:45 +0100
Subject: [LTP] [PATCH 1/1] host01.sh: Allow to overwrite the default hostname
Message-ID: <20201211071545.10209-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using hostname for test requires DNS setup.
Allow to set hostname (e.g. github.com) via $HOSTNAME in case host not
set. This restores the old behavior (the legacy API version used $RHOST).

Suggested-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/host/host01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/host/host01.sh b/testcases/network/tcp_cmds/host/host01.sh
index 662afe8b4..e6d8d4d06 100755
--- a/testcases/network/tcp_cmds/host/host01.sh
+++ b/testcases/network/tcp_cmds/host/host01.sh
@@ -12,7 +12,7 @@ TST_NEEDS_CMDS="awk host hostname"
 
 do_test()
 {
-	local lhost="$(hostname)"
+	local lhost="${HOSTNAME:-$(hostname)}"
 	local addr
 
 	tst_res TINFO "test basic functionality of the host command"
-- 
2.29.2

