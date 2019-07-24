From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 24 Jul 2019 10:03:26 +0200
Subject: [LTP] [PATCH 0/2] [RFC] BPF testing
Message-ID: <20190724080328.16145-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This patch set introduces a very basic test which kicks the tires of the bpf
system call. It doesn't actually load a eBPF program, I will create another
test for that. However I have some concerns which I will discuss while doing
that.

There are already extensive BPF tests in the kernel selftests. These appear to
be quite complex and test a variety of functionality. They also are far less
structured than LTP's modern tests and are tied to the kernel tree which makes
using them in QA a pain. There are also some tests in the BCC project, which
may test the kernel as a byproduct.

So there are a number of options which are not necessarily mutually exclusive:

1) Port (some of) the selftests to the LTP.
2) Port the LTP library to the selftests.
3) Focus the LTP's BPF tests on reproducing specific high impact bugs.

This patch set copies in the necessary headers so that we have zero external
dependencies. I will also use raw byte code for the program test which is at
least acceptable for trivial programs. So we do not need BCC or Clang/LLVM
with eBPF support or matching kernel sources to generate offsets into internal
structures.

For the time being atleast my preference would be for (3) while avoiding
taking on any dependencies to ensure those tests are run by users mostly
ignorant of BPF, but are still exposed to critical bugs in the BPF stack.

Richard Palethorpe (2):
  Essential headers for BPF map creation
  BPF: Sanity check creating and updating maps

 include/lapi/bpf.h                        | 242 ++++++++++++++++++++++
 include/lapi/syscalls/aarch64.in          |   1 +
 include/lapi/syscalls/i386.in             |   1 +
 include/lapi/syscalls/s390.in             |   1 +
 include/lapi/syscalls/sparc.in            |   1 +
 include/lapi/syscalls/x86_64.in           |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bpf/.gitignore  |   1 +
 testcases/kernel/syscalls/bpf/Makefile    |  10 +
 testcases/kernel/syscalls/bpf/bpf_map01.c | 138 ++++++++++++
 10 files changed, 398 insertions(+)
 create mode 100644 include/lapi/bpf.h
 create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
 create mode 100644 testcases/kernel/syscalls/bpf/Makefile
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c

-- 
2.22.0

