From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Apr 2021 16:05:05 +0100
Subject: [LTP] [PATCH v2 0/5] BPF refactor and add bpf_prog05
Message-ID: <20210429150510.21585-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

V2:

* Added a number of helper functions to bpf_common and used them on
  all tests.

* Added some instruction concatenation helpers, but only used these on
  bpf_prog05 as they don't seem to make the other tests better to
  read.

* Further shorten bpf_prog05 by using a generic expect function

Richard Palethorpe (5):
  lapi/bpf: Add /=, %= and BPF_MAXINSNS
  bpf: Add map_array helper functions
  bpf: Add helper to run socket programs
  bpf: Add bpf_insn_buf, map and instruction concatenation helpers
  bpf: Check truncation on 32bit div/mod by zero

 include/lapi/bpf.h                         |   6 +
 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_common.c |  89 +++++++++++
 testcases/kernel/syscalls/bpf/bpf_common.h |  26 ++-
 testcases/kernel/syscalls/bpf/bpf_prog01.c |  32 +---
 testcases/kernel/syscalls/bpf/bpf_prog02.c |  54 ++-----
 testcases/kernel/syscalls/bpf/bpf_prog03.c |  32 +---
 testcases/kernel/syscalls/bpf/bpf_prog04.c |  17 +-
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 175 +++++++++++++++++++++
 11 files changed, 320 insertions(+), 114 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog05.c

-- 
2.31.1

