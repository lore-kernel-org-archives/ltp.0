From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Jun 2019 18:14:10 +0200
Subject: [LTP] [PATCH v4 0/4] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190613161414.29161-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Ignaz,

changes v3->v4:
* Add helper check_ima_policy() and use it in ima_measurements.sh and
  evm_overlay.sh
* Rephrase commit message for ima_measurements.sh changes and docs
* Use SPDX-License-Identifier: GPL-2.0-or-later

Anything wrong in docs / commit message?

Kind regards,
Petr

Petr Vorel (4):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima/ima_measurements.sh: Require builtin IMA tcb policy
  ima: Add overlay test + doc

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../security/integrity/ima/tests/README.md    | 83 +++++++++++++++++
 .../integrity/ima/tests/evm_overlay.sh        | 93 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 23 +----
 .../security/integrity/ima/tests/ima_setup.sh | 42 +++++----
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 10 files changed, 211 insertions(+), 48 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/README.md
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0

