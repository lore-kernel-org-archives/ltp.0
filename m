From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Sep 2019 20:33:25 +0200
Subject: [LTP] [PATCH] doc: Add very simple library API writing guidelines
 docs
Message-ID: <20190924183325.6143-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is rather kind of a bad joke than a serious patch.

Inspired by Christian patch, where he adds write-tests-for-shell-lib.txt.
I guess we need more high level docs, where content of his patch would
be added.

Feel free to write more useful docs than my stub.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1151766/

 doc/library-api-writing-guidelines.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 doc/library-api-writing-guidelines.txt

diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
new file mode 100644
index 000000000..a238ee046
--- /dev/null
+++ b/doc/library-api-writing-guidelines.txt
@@ -0,0 +1,25 @@
+LTP Library API Writing Guidelines
+==================================
+
+1. General Rules
+----------------
+
+For extending library API it applies the same general rules as for writing tests
+(see test-writing-guidelines.txt), with strong focus on readability and simplicity.
+
+Library tests are in lib/newlib_tests directory.
+
+2. C API
+--------
+
+API source code is in headers include/*.h, include/lapi/*.h (backward compatibility)
+and C sources in lib/*.c. Files have tst_ prefix.
+
+3. Shell API
+------------
+
+API source code is in tst_test.sh, tst_security.sh and tst_net.sh
+(all in testcases/lib directory).
+
+Changes in the shell API should not introduce uncommon dependencies
+(use basic commands installed everywhere by default).
-- 
2.22.1

