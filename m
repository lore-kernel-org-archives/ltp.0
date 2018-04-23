From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:30 +0200
Subject: [LTP] [RFC PATCH 0/9] testcases: small improvements with TCONF
Message-ID: <20180423094639.14612-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello everyone,

I am currently trying LTP on an embededed device and while running
some tests, I noticed that some of them are returning "FAIL" but most
of the time, it is because some binaries (or options) are not available
on my root filesystem. Instead of returning "FAIL", I think they should 
return "TCONF". This is what this series does.

I haven't finished to run all the tests yet so I will send another bunch
of patches with other improvements. As it is the first time I used this
project and that I contributes to it, reviews or feedbacks on this first
set of patches would be very appreciated.

Thank you in advance!

Best regards,
Mylène

Mylène Josserand (9):
  testcases: su: Fix userdel use
  testcases: ar: Add TST_NEEDS_CMDS on "ar"
  testcases: file: Add TST_NEEDS_CMDS on readelf
  testcases: tar: Add TST_NEEDS_CMDS on gzip and bzip
  testcases: logrotate: Check if "file" command exists
  testcases: wc: Add "unrecognized option" as TCONF
  testcases: df: Add "--printf" option as needed commands
  testcases: test.sh: Check if "getconf" is available
  testcases: cpuset: Check if "getconf" is available

 testcases/commands/ar/ar01                                    | 3 +++
 testcases/commands/df/df01.sh                                 | 2 ++
 testcases/commands/file/file01.sh                             | 2 ++
 testcases/commands/logrotate/logrotate_tests.sh               | 3 ++-
 testcases/commands/su/su01                                    | 6 ++++--
 testcases/commands/tar/tar_tests.sh                           | 2 ++
 testcases/commands/wc/wc01.sh                                 | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 2 ++
 testcases/lib/test.sh                                         | 2 ++
 9 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.11.0

