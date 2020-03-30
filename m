From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:43:33 +0200
Subject: [LTP] [PATCH v2 0/5] C API: .needs_cmds and SAFE_CMD()
Message-ID: <20200330124338.6764-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

just in case due massive rename I'm posting the changes.

Kind regards,
Petr

Petr Vorel (5):
  lib: Rename tst_run_cmd*() to tst_cmd*()
  lib/tst_cmd_*(): Turn int pass_exit_val into enum
  lib/tst_cmd_*(): Search for program in $PATH
  lib: Implement SAFE_CMD() macro (new API only)
  Use SAFE_CMD()

 doc/test-writing-guidelines.txt               | 20 +++---
 include/tst_cmd.h                             | 61 +++++++++++--------
 include/tst_safe_macros.h                     | 17 ++++++
 lib/{tst_run_cmd.c => tst_cmd.c}              | 32 ++++++----
 lib/tst_kernel.c                              |  3 +-
 lib/tst_mkfs.c                                |  2 +-
 lib/tst_module.c                              |  5 +-
 lib/tst_virt.c                                |  2 +-
 testcases/cve/stack_clash.c                   |  2 +-
 testcases/kernel/input/input_helper.c         |  4 +-
 testcases/kernel/syscalls/acct/acct02.c       |  2 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 16 ++---
 .../copy_file_range/copy_file_range02.c       |  2 +-
 .../kernel/syscalls/quotactl/quotactl01.c     | 11 +---
 .../kernel/syscalls/quotactl/quotactl06.c     |  9 +--
 .../syscalls/setpriority/setpriority01.c      |  4 +-
 testcases/kernel/syscalls/swapon/libswapon.c  |  2 +-
 testcases/network/netstress/netstress.c       |  2 +-
 .../network/nfs/nfs_stress/nfs05_make_tree.c  |  6 +-
 tools/apicmds/ltpapicmd.c                     |  2 +-
 20 files changed, 111 insertions(+), 93 deletions(-)
 rename lib/{tst_run_cmd.c => tst_cmd.c} (86%)

-- 
2.26.0

