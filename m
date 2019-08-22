From: Christian Lanig <clanig@suse.com>
Date: Thu, 22 Aug 2019 21:12:44 +0200
Subject: [LTP] [RFC PATCH v2 0/1] Add automated tests for shell lib
In-Reply-To: <20181003113215.GB21139@dell5510>
References: <20181003113215.GB21139@dell5510>
Message-ID: <cover.1566500817.git.clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I am sorry that my reply took so long. Thank you very much for your comments
which helped me to improve the code.
I have made an overhaul of the code based on your suggestions but an option to
pass parameters to the tests is still not implemented. 
I'm sending you what I have so far because it would help me when you could
provide me more information regarding this.

I agree that it is difficult to find a way to process text the way needed here
without disregarding the Linux Kernel Coding Style that asks for code which is
transparent and easy to read when we only consider Shell commands. To address
this issue I have drafted a Python script that might go in the tools folder and
may perhaps be helpful in other cases as well. Since there are already Python
files in the project it might be a valid option.

Thank you very much for your patience.

Regards,
Christian Lanig

Christian Lanig (1):
  Add automated tests for shell lib

 doc/write-tests-for-shell-lib.txt                  |  59 ++++++++++
 lib/newlib_tests/shell/test_sh_newlib.sh           | 102 ++++++++++++++++++
 .../testcases/test.TST_TEST.TST_CNT.separate.sh    |  30 ++++++
 .../shell/testcases/test.TST_TEST.TST_CNT.sh       |  28 +++++
 .../shell/testcases/test.TST_TEST.getopts.sh       |  49 +++++++++
 lib/newlib_tests/shell/testcases/test.TST_TEST.sh  |  33 ++++++
 .../test.TST_TEST_DATA.TST_CNT.separate.sh         |  33 ++++++
 .../shell/testcases/test.TST_TEST_DATA.TST_CNT.sh  |  31 ++++++
 .../shell/testcases/test.TST_TEST_DATA.getopts.sh  |  51 +++++++++
 .../shell/testcases/test.TST_TEST_DATA.sh          |  25 +++++
 .../testcases/test.TST_TEST_DATA_IFS.getopts.sh    |  53 +++++++++
 .../shell/testcases/test.TST_TEST_DATA_IFS.sh      |  28 +++++
 tools/lookup_split_cut.py                          | 120 +++++++++++++++++++++
 13 files changed, 642 insertions(+)
 create mode 100644 doc/write-tests-for-shell-lib.txt
 create mode 100755 lib/newlib_tests/shell/test_sh_newlib.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.getopts.sh
 create mode 100755 lib/newlib_tests/shell/testcases/test.TST_TEST_DATA_IFS.sh
 create mode 100755 tools/lookup_split_cut.py

-- 
2.16.4

