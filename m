From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 28 Sep 2020 12:47:29 -0700
Subject: [LTP] [PATCH v1 0/1] ima: Add test for selinux measurement
Message-ID: <20200928194730.20862-1-nramas@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by Linux Security Modules (LSM). Currently one
such LSM namely selinux is being updated to use this functionality.
This new functionality needs test automation in LTP.

This patch set adds tests which verify that the IMA subsystem correctly
measures the data provided by selinux.

This patch is based on 
commit 286401a1c1f3 ("thp04: Add linux tag")
in "master" branch in https://github.com/linux-test-project/ltp

This patch is dependent on the following patch series in LTP
https://patchwork.kernel.org/patch/11802771/

This series needs a kernel built on the following repo/branch/patches:
repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
branch: next
commit 8861d0af642c ("selinux: Add helper functions to get and set checkreqprot")

And the following patch series should be applied in the following order:
  1, https://patchwork.kernel.org/patch/11709527/
  2, https://patchwork.kernel.org/patch/11795559/
  3, https://patchwork.kernel.org/patch/11801525/
  4, https://patchwork.kernel.org/patch/11801585/

Lakshmi Ramasubramanian (1):
  ima: Add test for selinux measurement

 runtest/ima                                   |   2 +
 .../kernel/security/integrity/ima/README.md   |  19 +++
 .../integrity/ima/tests/ima_selinux_policy.sh |  72 ++++++++++
 .../integrity/ima/tests/ima_selinux_state.sh  | 136 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  28 ++++
 5 files changed, 257 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh

-- 
2.28.0

