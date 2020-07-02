From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Thu,  2 Jul 2020 11:35:43 -0400
Subject: [LTP] [PATCH 0/2] Test cmdline measurement and IMA buffer passing
 through kexec
Message-ID: <20200702153545.3126-1-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset adds two tests that verify that data is passed correctly
through a kexec. Since the machine reboots several times when running these
tests, they must be run standalone and cannot be run with `runltp`.

The first test verifies that the kernel command line is measured correctly
when using kexec. The second test verifies that the IMA buffer is being
passed through kexec correctly.

Support for passing the IMA buffer through kexec has only been upstreamed
on powerpc so far, with a patchset in the process of being upstreamed for
support on arm64. Therefore, the only architectures that the tests
allow you to run them on (via `uname -m`) are ppc, ppc64, ppcle, ppc64le,
and aarch64.

The tests have been verified on ARM64. Would appreciate if
someone can execute the tests on a PowerPC machine and validate.

Lachlan Sneff (2):
  IMA: Verify that the kernel cmdline is passed and measured correctly
    through the kexec barrier.
  IMA: Verify IMA buffer passing through the kexec barrier

 testcases/kexec/README.md     | 30 ++++++++++++++
 testcases/kexec/cmdline.sh    | 78 +++++++++++++++++++++++++++++++++++
 testcases/kexec/ima_buffer.sh | 42 +++++++++++++++++++
 testcases/kexec/utils.sh      | 47 +++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 testcases/kexec/README.md
 create mode 100755 testcases/kexec/cmdline.sh
 create mode 100755 testcases/kexec/ima_buffer.sh
 create mode 100755 testcases/kexec/utils.sh

-- 
2.25.1

