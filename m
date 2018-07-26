From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Jul 2018 10:07:23 +0200
Subject: [LTP] [PATCH 1/1] README: Add link to patchwork instance
Message-ID: <20180726080723.21588-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ note patches in ML as preferred way
+ fix doc formatting

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

hope that preferring patches in ML over GitHub pull requests is not
controversial for anyone. That's the only reason why I send this tiny
doc patch to ML.


Kind regards,
Petr
---
 README.md | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index bfb05d921..240335657 100644
--- a/README.md
+++ b/README.md
@@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
 The git repository is located at GitHub at:
 https://github.com/linux-test-project/ltp
 
+The patchwork instance is at:
+https://patchwork.ozlabs.org/project/ltp/list/
+
 Warning!
 ========
 
@@ -178,6 +181,8 @@ There is also a step-by-step tutorial:
 If something is not covered there don't hesitate to ask on the LTP mailing
 list. Also note that these documents are available online at:
 
-https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
-https://github.com/linux-test-project/ltp/wiki/BuildSystem
-https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
+* https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
+* https://github.com/linux-test-project/ltp/wiki/BuildSystem
+* https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
+
+Although we accept GitHub pull requests, the preferred way is sending patches to our mailing list.
-- 
2.18.0

