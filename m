From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Dec 2016 14:24:16 +0100
Subject: [LTP] [PATCH 1/1] network: remove unnecessary check for rsh in
	scripts
Message-ID: <20161219132416.26987-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

scripts rlogin01 and telnet01 don't use rsh directly, but via
tst_rhost_run. This means that ssh or netns can be used instead of rsh.

IMHO these checks should be done in tst_rhost_run().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/rlogin/rlogin01 | 2 +-
 testcases/network/tcp_cmds/telnet/telnet01 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01 b/testcases/network/tcp_cmds/rlogin/rlogin01
index f53b1a88a..162b8f0d8 100755
--- a/testcases/network/tcp_cmds/rlogin/rlogin01
+++ b/testcases/network/tcp_cmds/rlogin/rlogin01
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 setup()
 {
-	tst_check_cmds rlogin expect rsh
+	tst_check_cmds rlogin expect
 
 	if [ -z $RUSER ]; then
 		RUSER=root
diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index a1609f0f6..f2f2444a8 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 setup()
 {
-	tst_check_cmds telnet expect rsh
+	tst_check_cmds telnet expect
 
 	if [ -z $RUSER ]; then
 		RUSER=root
-- 
2.11.0

