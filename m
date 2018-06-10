From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 10 Jun 2018 12:13:09 +0200
Subject: [LTP] [PATCH 1/1] network.sh: Cleanup netpan logs
Message-ID: <20180610101309.8201-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

network.sh script doesn't delete it's logs, which can lead to fill /tmp.
Remove these files, which unify behavior with runltp and runltplite.sh
(just don't use trap to force remove on INT).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index c946e4d86..78257d8db 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -121,3 +121,5 @@ if [ $? -eq "0" ]; then
 else
 	echo ltp-pan reported FAIL
 fi
+
+rm -rf $TMPDIR
-- 
2.17.1

