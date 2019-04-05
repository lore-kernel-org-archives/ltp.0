From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Apr 2019 18:52:22 +0200
Subject: [LTP] [PATCH v2 0/3]	LTP reproducer on broken IMA on overlayfs
Message-ID: <20190405165225.27216-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a second version of patch demonstrating a bug on overlayfs when
combining IMA with EVM. There is ongoing work made by Ignaz Forster and
Fabian Vogt [1] [2], IMA only behavior was already fixed [3].

Main patch is the last one (previous are just a cleanup and not changed).

Kind regards,
Petr

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html
[3] https://patchwork.kernel.org/patch/10776231/

Petr Vorel (3):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima: Add overlay test

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../integrity/ima/tests/evm_overlay.sh        | 86 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++-
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 100 insertions(+), 16 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

-- 
2.21.0

