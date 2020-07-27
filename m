From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2020 00:30:37 +0200
Subject: [LTP] [PATCH v5 0/4] IMA: kexec cmdline measurement
Message-ID: <20200727223041.13110-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

sending hopefully the last version. In the end I did quite few changes,
thus sending patchset instead of merging without review.

Tested on various setup:
ima_kexec 1 TCONF: IMA policy does not specify '^measure.*func=KEXEC_CMDLINE'
---
ima_kexec 1 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --append=foo passed as expected
ima_kexec 1 TPASS: kexec cmdline for --append=foo was measured correctly
ima_kexec 2 TPASS: kexec -s -l /boot/vmlinuz-5.3.13-1-default --command-line=bar passed as expected
ima_kexec 2 TPASS: kexec cmdline for --command-line=bar was measured correctly
---
ima_kexec 1 TBROK: kexec failed: kexec_file_load failed: Required key not available
---
ima_kexec 1 TWARN: policy not readable, it might not contain required measure func=KEXEC_CMDLINE
ima_kexec 1 TBROK: unable to find a correct entry for --reuse-cmdline

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add test for kexec cmdline measurement

Petr Vorel (3):
  IMA: Rename helper to require_ima_policy_cmdline
  IMA: Add policy related helpers
  IMA/ima_keys.sh: Fix policy readability check

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |   8 ++
 .../integrity/ima/datafiles/kexec.policy      |   1 +
 .../integrity/ima/tests/evm_overlay.sh        |   2 +-
 .../security/integrity/ima/tests/ima_kexec.sh | 111 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  |  10 +-
 .../integrity/ima/tests/ima_measurements.sh   |   2 +-
 .../security/integrity/ima/tests/ima_setup.sh |  41 ++++++-
 8 files changed, 164 insertions(+), 12 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/kexec.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

-- 
2.27.0

