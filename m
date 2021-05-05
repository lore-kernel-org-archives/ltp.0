From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  5 May 2021 10:16:19 +0100
Subject: [LTP] [PATCH v3 0/4] BPF refactor and add bpf_prog05
Message-ID: <20210505091623.29121-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

V3:

* constify and add attributes

* replace insn builder with BPF_MAP_ARRAY_STX macro to insert multiple
  instructions.

V2:

* Added a number of helper functions to bpf_common and used them on
  all tests.

* Added some instruction concatenation helpers, but only used these on
  bpf_prog05 as they don't seem to make the other tests better to
  read.

* Further shorten bpf_prog05 by using a generic expect function

Richard Palethorpe (4):
  lapi/bpf: Add /= and %=
  bpf: Add map_array helper functions/macro and constify
  bpf: Add helper to run socket programs
  bpf: Check truncation on 32bit div/mod by zero

 include/lapi/bpf.h                         |   2 +
 runtest/cve                                |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/bpf/.gitignore   |   1 +
 testcases/kernel/syscalls/bpf/bpf_common.c |  64 ++++++--
 testcases/kernel/syscalls/bpf/bpf_common.h |  53 +++++-
 testcases/kernel/syscalls/bpf/bpf_prog01.c |  32 +---
 testcases/kernel/syscalls/bpf/bpf_prog02.c |  54 ++-----
 testcases/kernel/syscalls/bpf/bpf_prog03.c |  32 +---
 testcases/kernel/syscalls/bpf/bpf_prog04.c |  17 +-
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 177 +++++++++++++++++++++
 11 files changed, 308 insertions(+), 126 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog05.c

-- 
2.31.1

