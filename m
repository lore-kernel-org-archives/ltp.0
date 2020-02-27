From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Feb 2020 17:39:21 +0100
Subject: [LTP] [PATCH 3/4] doc: Improve flags info
In-Reply-To: <20200227163922.317-1-pvorel@suse.cz>
References: <20200227163922.317-1-pvorel@suse.cz>
Message-ID: <20200227163922.317-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/style-guide.txt             | 4 ++--
 doc/test-writing-guidelines.txt | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index b853fa8dc..55331c8d7 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -102,8 +102,8 @@ concerned about portability.
 7. Handle TBROK and TFAIL correctly
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Use +TBROK+ when an unexpected failure unrelated to the goal of the testcase
-occurred, and use +TFAIL+ when an unexpected failure related to the goal of
+Use +tst_brk(TBROK)+ when an unexpected failure unrelated to the goal of the testcase
+occurred, and use +tst_res(TFAIL)+ when an unexpected failure related to the goal of
 the testcase occurred.
 
 8. Don't roll your own syscall numbers
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 48fd06764..5f08e364e 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -421,6 +421,7 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS' | Test has passed.
 | 'TFAIL' | Test has failed.
 | 'TINFO' | General message.
+| 'TWARN' | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
 
 The 'ttype' can be combined bitwise with 'TERRNO' or 'TTERRNO' to print
-- 
2.25.1

