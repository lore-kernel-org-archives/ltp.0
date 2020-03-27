From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:18 +0100
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
Message-ID: <20200327213924.18816-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I implemented .needs_cmds + SAFE_RUN_CMD().

I also checked for command in path in tst_run_cmd_fds_() as suggested by
Cyril + added possibility to TCONF when program not found. This leaded
to more verbose changes. + There is a double check (first in
.needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.

Also this change is not used in copy_file_range02.c, because it does not
require these commands. Is it worth to reduce code it'd be good to separate
file into two, put common functions in header and tests with
fd_immutable and fd_swapfile into new test?

Petr Vorel (6):
  lib: Implement .needs_cmds
  Use .needs_cmds
  lib/tst_run_cmd_*(): Turn int pass_exit_val into enum
  lib/tst_run_cmd_*(): Search for program in $PATH
  lib: Implement SAFE_RUN_CMD() macro (new API only)
  Use SAFE_RUN_CMD()

 doc/test-writing-guidelines.txt               | 29 +++++++++++---
 include/tst_cmd.h                             | 39 +++++++++++--------
 include/tst_safe_macros.h                     | 20 ++++++++++
 include/tst_test.h                            |  3 ++
 lib/tst_kernel.c                              |  3 +-
 lib/tst_mkfs.c                                |  3 +-
 lib/tst_module.c                              |  3 +-
 lib/tst_run_cmd.c                             | 28 ++++++++-----
 lib/tst_test.c                                | 11 ++++++
 testcases/kernel/input/input_helper.c         |  4 +-
 testcases/kernel/syscalls/acct/acct02.c       |  2 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 24 +++++-------
 .../copy_file_range/copy_file_range02.c       |  2 +-
 .../kernel/syscalls/quotactl/quotactl01.c     | 18 +++------
 .../kernel/syscalls/quotactl/quotactl06.c     | 16 +++-----
 .../syscalls/setpriority/setpriority01.c      |  5 ++-
 testcases/network/netstress/netstress.c       |  2 +-
 17 files changed, 134 insertions(+), 78 deletions(-)

-- 
2.25.1

