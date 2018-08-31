From: Christian Lanig <clanig@suse.com>
Date: Fri, 31 Aug 2018 17:24:08 +0200
Subject: [LTP] [RFC PATCH 0/1] Add automated tests for shell lib
In-Reply-To: <20180829172448.GA2960@dell5510>
References: <20180829172448.GA2960@dell5510>
Message-ID: <cover.1535725022.git.clanig@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The following patch adds the test cases by Petr Vorel. They can be executed by
automatically. doc/write-tests-for-shell-lib.txt describes how everything works.
The output tells whether each test has passed and when it failed, the diff is
printed.

I apologize for the badly formatted message I sent before and hope that this
time I used the right format options.

@Petr

> + It'd be nice to describe, how testing works - how to modify the output
> (in README.md or at least in commit message).
I am not sure that the text in doc/write-tests-for-shell-lib.txt should really
go in README.md. Probably just a link or something. But I can change it if
necessary.

In regard of the other comments, I have removed all double quotes where nothing
should go wrong as long as the person executing the script doesn't have
unsupported file or directory naming or pretty uncommon bugs in his or her
shell.

I have also removed unnecessary else statements (which I thought would be
necessary to stay compatible but this appeared to be a wrong impression when I
read the text about it more accurately a second time).
Also a -h / --help option was added which should be explanatory enough for
people who intuitively run the script with this option and to replace comments
about functionality in the header of the script file.

Another feature is to specify single test cases as arguments to only run these
and no other.

Both outputs, the desired and the actual one, are now stored in a temporary
folder and the PATH environment variable is modified temporarily, which implied
the necessity to add a cleanup function.

Regards,
Christian

Christian Lanig (1):
  Add automated tests for shell lib

 doc/write-tests-for-shell-lib.txt                  |  61 ++++++++++++
 .../shell/test.TST_TEST.TST_CNT.separate.sh        |  29 ++++++
 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh    |  27 ++++++
 lib/newlib_tests/shell/test.TST_TEST.getopts.sh    |  48 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST.sh            |  32 +++++++
 .../shell/test.TST_TEST_DATA.TST_CNT.separate.sh   |  32 +++++++
 .../shell/test.TST_TEST_DATA.TST_CNT.sh            |  30 ++++++
 .../shell/test.TST_TEST_DATA.getopts.sh            |  50 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST_DATA.sh       |  24 +++++
 .../shell/test.TST_TEST_DATA_IFS.getopts.sh        |  52 ++++++++++
 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh   |  27 ++++++
 lib/newlib_tests/test_sh_newlib.sh                 | 105 +++++++++++++++++++++
 12 files changed, 517 insertions(+)
 create mode 100644 doc/write-tests-for-shell-lib.txt
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.getopts.sh
 create mode 100755 lib/newlib_tests/shell/test.TST_TEST_DATA_IFS.sh
 create mode 100755 lib/newlib_tests/test_sh_newlib.sh

-- 
2.16.4

