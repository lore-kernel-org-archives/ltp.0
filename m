From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Mar 2019 17:16:35 +0100
Subject: [LTP] [PATCH 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190327161638.7407-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

based on reproducer made by Ignaz Forster <iforster@suse.de>
used for his not upstreamed patchset [1] and previous report [2].

Mimi: does this test make sense to you?

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Ignaz Forster <iforster@suse.de>
Cc: Fabian Vogt <FVogt@suse.com>
Cc: Weihua Du <WHDu@suse.com>
Cc: linux-integrity@vger.kernel.org

Petr Vorel (3):
  ima: Call test's cleanup inside ima_setup.sh cleanup
  shell: Add $TST_DEVICE as default parameter to tst_umount
  ima: Add overlay test

 doc/test-writing-guidelines.txt               |  4 +-
 runtest/ima                                   |  1 +
 testcases/commands/df/df01.sh                 |  7 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 .../integrity/ima/tests/ima_overlay.sh        | 65 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh | 12 ++--
 .../integrity/ima/tests/ima_violations.sh     |  2 -
 testcases/lib/tst_test.sh                     |  2 +-
 8 files changed, 79 insertions(+), 16 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_overlay.sh

-- 
2.21.0

