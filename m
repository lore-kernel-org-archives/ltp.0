From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Sep 2019 15:50:40 +0200
Subject: [LTP] [PATCH v3 0/3] shell: Introduce TST_TIMEOUT variable
Message-ID: <20190919135043.14359-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v2->v3:
* cast to int if awk is not available (Li) instead of TCONF
* actually round variable (with 0.5) (Clemens)
* fix variable description (Clemens)
* add 2 tests for TST_TIMEOUT (it'd be more useful to test
  LTP_TIMEOUT_MUL, but I'd wait for Christian's shell test
  patch [1] being merged)

NOTES:
There are a more changes in second patch, I kept them in the same commit
as it's related.
Current tests might not be much useful.

[1] https://patchwork.ozlabs.org/patch/1151766/

Petr Vorel (3):
  shell: Add tst_is_num()
  shell: Introduce TST_TIMEOUT variable, add checks
  net/if-mtu-change.sh: set TST_TIMEOUT

 doc/test-writing-guidelines.txt               | 89 ++++++++++++-------
 lib/newlib_tests/shell/timeout01.sh           | 13 +++
 lib/newlib_tests/shell/timeout02.sh           | 13 +++
 .../memcg/stress/memcg_stress_test.sh         |  2 +-
 testcases/lib/tst_test.sh                     | 49 +++++++++-
 .../network/stress/interface/if-mtu-change.sh |  4 +-
 6 files changed, 133 insertions(+), 37 deletions(-)
 create mode 100755 lib/newlib_tests/shell/timeout01.sh
 create mode 100755 lib/newlib_tests/shell/timeout02.sh

-- 
2.23.0

