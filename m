From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 16:51:10 +0100
Subject: [LTP] [PATCH v2 0/2] Implement syscall multiplexing
Message-ID: <20190321155112.13449-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is version 2 of the patchset, the main changes are documentation
for the multiplex function and also fixes in the select multiplexing
function.

Cyril Hrubis (2):
  tst_test: Add test multiplex function
  syscalls/select04: Test four syscall variants

 doc/test-writing-guidelines.txt               | 80 +++++++++++++++++
 include/tst_test.h                            | 14 +++
 lib/tst_test.c                                | 11 ++-
 testcases/kernel/syscalls/select/select04.c   |  5 +-
 testcases/kernel/syscalls/select/select_mpx.h | 87 +++++++++++++++++++
 5 files changed, 194 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/select/select_mpx.h

-- 
2.19.2

