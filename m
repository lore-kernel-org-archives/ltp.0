From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  7 Dec 2020 15:56:39 +0100
Subject: [LTP] [PATCH 1/1] doc: Document .min_cpus
Message-ID: <20201207145639.8424-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recently added (in fa32a727d).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Feel free to document it more.

Kind regards,
Petr

 doc/test-writing-guidelines.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 3c2ab7166..dcb5d9d43 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2134,8 +2134,14 @@ struct tst_test test = {
 	.test_all = run,
 	...
 };
-
 -------------------------------------------------------------------------------
+
+2.2.37 Require minimum numbers of CPU for a testcase
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests require more than single CPU. It can be defined with
+`.min_cpus = N`.
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.29.2

