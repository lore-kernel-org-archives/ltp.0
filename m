From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Sep 2019 16:59:11 +0200
Subject: [LTP] [RFC PATCH v4 0/5] shell: Introduce TST_TIMEOUT variable
Message-ID: <20190930145916.20465-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v3->v4:
* add test runner test_timeout.sh, move tests into separate directory
issues reported by Cyril:
* ceil LTP_TIMEOUT_MUL to int instead of complicating code with float
* Don't add LTP_TIMEOUT_MUL docs. This should be added to somewhere else, maybe to
  doc/user-guide.txt if [1] is accepted
* don't renumber sections
* move memcg_stress_test.sh change into separate commit

[1] https://patchwork.ozlabs.org/patch/1169282/

Petr Vorel (5):
  shell: Add tst_is_num()
  shell: Introduce TST_TIMEOUT variable, add checks
  shell: Add timeout shell API tests
  memcg_stress_test.sh: use TST_TIMEOUT (replace LTP_TIMEOUT_MUL)
  net/if-mtu-change.sh: set TST_TIMEOUT

 doc/test-writing-guidelines.txt               | 14 ++++++-
 lib/newlib_tests/shell/test_timeout.sh        | 38 ++++++++++++++++++
 lib/newlib_tests/shell/timeout01.sh           | 13 +++++++
 lib/newlib_tests/shell/timeout02.sh           | 13 +++++++
 .../memcg/stress/memcg_stress_test.sh         |  2 +-
 testcases/lib/tst_test.sh                     | 39 +++++++++++++++++--
 .../network/stress/interface/if-mtu-change.sh |  4 +-
 7 files changed, 116 insertions(+), 7 deletions(-)
 create mode 100755 lib/newlib_tests/shell/test_timeout.sh
 create mode 100755 lib/newlib_tests/shell/timeout01.sh
 create mode 100755 lib/newlib_tests/shell/timeout02.sh

-- 
2.23.0

