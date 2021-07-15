From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 08:58:05 +0200
Subject: [LTP] [PATCH 1/1] doc: Specify linux-stable-git rule
Message-ID: <20210715065805.14086-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 45784195b..9d26a483d 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -2205,6 +2205,10 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+NOTE: We don't track all backports to stable kernel but just those which are
+      stable branch specific (unique), i.e. no commit in mainline. Example of
+      commits: c4a23c852e80, cac68d12c531.
+
 Glibc git commit in a regression test for a glibc bug:
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.32.0

