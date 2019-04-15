From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 13:37:55 +0200
Subject: [LTP] [COMMITTED][PATCH] runltp: Remove unused -n option
Message-ID: <20190415113755.1386-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: f7201dfc ("tools: Remove unused code.")
Fixes: #158

Reported-by: Muthu Mohan.T <nortonmohan@yahoo.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

there should have been "... also from help" in commit message.

Kind regards,
Petr
---
 runltp | 1 -
 1 file changed, 1 deletion(-)

diff --git a/runltp b/runltp
index 928696b9e..ec0811834 100755
--- a/runltp
+++ b/runltp
@@ -148,7 +148,6 @@ usage()
 		[CHECK_TYPE=2 => Thread Concurrency Check tracing children as well]
 		[CHECK_TYPE=3 => Full Memory Leak & Thread Concurrency Check tracing children as well]
     -N              Run all the networking tests.
-    -n              Run LTP with network traffic in background.
     -o OUTPUTFILE   Redirect test output to a file.
     -p              Human readable format logfiles.
     -q              Print less verbose output to screen. This implies
-- 
2.21.0

