From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Jun 2019 21:30:17 +0200
Subject: [LTP] [PATCH v3 0/4] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190611193021.17651-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Ignaz,

sorry for bothering you with one more version of this patchset.

Changes v2->v3:
* added one commit "ima/ima_measurements.sh: Require builtin IMA tcb policy"
to avoid false positives 
* added README.md in last commit (might be in separate commit)

Petr Vorel (4):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima/ima_measurements.sh: Require builtin IMA tcb policy
  ima: Add overlay test + doc

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../security/integrity/ima/tests/README.md    | 82 ++++++++++++++++
 .../integrity/ima/tests/evm_overlay.sh        | 94 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   |  3 +-
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++-
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 10 files changed, 192 insertions(+), 17 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/README.md
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0

