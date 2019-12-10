From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 10 Dec 2019 09:04:16 +0100
Subject: [LTP] [PATCH v4] lsmod01: Add kernel module
Message-ID: <20191210080419.128773-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now that the naming debate for tst_needs vs. tst_require is done, I post the patch,
that started all of it again.

This patch adds a dummy module to lsmod01, to make the test run successfully,
if no modules are loaded at the time of test execution.

To have no impact on the test requirements, when modules are already loaded,
the root test and module search has to be done conditionally.
Therefor the library had to be extended/modified to add tst_require_root
and tst_require_module.


 doc/test-writing-guidelines.txt        |  6 ++++-
 testcases/commands/.gitignore          |  1 +
 testcases/commands/lsmod/Makefile      | 15 ++++++++++++
 testcases/commands/lsmod/lsmod01.sh    | 33 ++++++++++++++++++++++++++
 testcases/commands/lsmod/ltp_lsmod01.c | 28 ++++++++++++++++++++++
 testcases/lib/tst_net.sh               | 12 ++--------
 testcases/lib/tst_security.sh          |  4 ++--
 testcases/lib/tst_test.sh              | 43 +++++++++++++++++++---------------
 8 files changed, 110 insertions(+), 32 deletions(-)



