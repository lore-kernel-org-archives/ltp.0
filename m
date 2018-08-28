From: Christian Lanig <clanig@suse.com>
Date: Tue, 28 Aug 2018 13:18:44 +0200
Subject: [LTP] [PATCH 2/2] Add wanted output to shell lib test case
In-Reply-To: <20180828111844.20152-1-clanig@suse.com>
References: <20180522193430.20117-2-pvorel@suse.cz>
 <20180828111844.20152-1-clanig@suse.com>
Message-ID: <20180828111844.20152-2-clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
Please do not merge!
I would like to get some feedback for this one and the previous patch. It is
based on Petr Vorel's [RFC,v3,2/2] lib: Add tests from May 22nd 2018 with the
message ID 20180522193430.20117-2-pvorel@suse.cz.
These two patches transfer Petr's test cases in a separate folder and a shell
script loops over all files as suggested in the replies to the initial message.
The output is verified against a comment section in the test case file itself.
This section is started with the line "# output:" and it is expected that it
goes to the end of the document without interception.
I have run the script with various Shell implementations to make sure it's
portable.

Limitations:
The script is currently unable to test e.g. whether TFAIL is displayed with red
color.
So far I have only added the correct output line in a single test case file so
just one test is currently passing.
Before proceeding I would like to know whether this is a good way to go.

 lib/newlib_tests/shell/test.TST_TEST.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/newlib_tests/shell/test.TST_TEST.sh b/lib/newlib_tests/shell/test.TST_TEST.sh
index 42f14151b..aa4e20377 100755
--- a/lib/newlib_tests/shell/test.TST_TEST.sh
+++ b/lib/newlib_tests/shell/test.TST_TEST.sh
@@ -21,5 +21,12 @@ do_test()
 }
 
 tst_run
+# output:
 # test 1 TINFO: Test 1 passed with no data ('')
 # test 1 TPASS: true returned 0
+#
+# Summary:
+# passed   1
+# failed   0
+# skipped  0
+# warnings 0
-- 
2.16.4

