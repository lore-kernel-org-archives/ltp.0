From: Vitaly Chikunov <vt@altlinux.org>
Date: Mon,  7 Sep 2020 10:51:09 +0300
Subject: [LTP] [PATCH] Fix removal of TMP by moving cleanup trap into main
 just after mktemp
Message-ID: <20200907075109.19194-1-vt@altlinux.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If user have TMP set and run 'runltp -h' their whole TMP dir is removed.

Fixes: https://github.com/linux-test-project/ltp/issues/722
Suggested-by: Cyril Hrubis <metan@ucw.cz>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 runltp | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 11654ebff..d53ef2941 100755
--- a/runltp
+++ b/runltp
@@ -552,6 +552,8 @@ main()
     # write to it as user nobody
     export TMPDIR=$TMP
 
+    trap "cleanup" 0
+
     chmod 777 $TMP || \
     {
       echo "unable to chmod 777 $TMP ... aborting"
@@ -952,7 +954,6 @@ cleanup()
 LTP_SCRIPT="$(basename $0)"
 
 if [ "$LTP_SCRIPT" = "runltp" ]; then
-    trap "cleanup" 0
     setup
     main "$@"
 fi
-- 
2.11.0

