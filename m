From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  8 Sep 2017 18:39:55 +0200
Subject: [LTP] [PATCH] [COMMITTED] runtest/quickhit: Update for removed lseek
Message-ID: <20170908163955.15250-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The quickhit runtest was forgotten when lseek test were merged.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/quickhit | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/runtest/quickhit b/runtest/quickhit
index c286addce..2a4276938 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -171,14 +171,9 @@ link04 link04
 link05 link05
 # multi links (EMLINK) negative test
 lseek01 lseek01
-# Basic test for lseek(2)
 lseek02 lseek02
-# Negative test for lseek(2)
-lseek03 lseek03
-# Negative test for lseek(2) whence
-lseek04 lseek04
-# Negative test for lseek(2) of a fifo
-lseek05 lseek05
+lseek07 lseek07
+lseek11 lseek11
 # Negative test for lseek(2) of a pipe
 lstat02 lstat02
 # Basic test for lstat(2)
-- 
2.13.0

