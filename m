From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:37 +0100
Subject: [LTP] [PATCH 00/19] Unify error handling in LTP library
Message-ID: <20201026164756.30556-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP helper functions, mainly safe syscalls, often report two different source
code locations in error messages and sometimes handle syscall return values
incorrectly. This patchset unifies source code location formatting to only
show the calling line in the test program and fixes invalid return value
handling. Safe syscalls now make pedantic distinction between common errors
and invalid return values where applicable.

Some safe syscalls returned no value so they were not usable in test cleanup.
This is also fixed along with potential control flow issues when tst_brk()
does not immediately terminate the program.

Martin Doucha (19):
  Unify error handling in lib/tst_safe_macros.c
  Unify error handling in lib/tst_safe_sysv_ipc.c
  Unify error handling in lib/tst_safe_timerfd.c
  Unify error handling in lib/safe_file_ops.c
  Unify error handling in lib/safe_macros.c
  Unify error handling in lib/safe_net.c
  Unify error handling in lib/safe_stdio.c
  Unify error handling in lib/tst_mkfs.c
  Unify error handling in lib/tst_checkpoint.c
  Unify error handling in lib/tst_net.c
  Unify error handling in lib/tst_fs_setup.c
  Unify error handling in include/tst_safe_clocks.h
  Move executable code out of tst_safe_macros.h
  Unify error handling in moved functions
  Unify error handling in include/tst_safe_macros.h
  Unify error handling in include/tst_safe_posix_ipc.h
  Unify error handling in include/tst_safe_prw.h
  Unify error handling in lib/tst_resource.c
  Unify error handling in include/lapi/safe_rt_signal.h

 include/lapi/safe_rt_signal.h |  25 +-
 include/safe_file_ops_fn.h    |   8 +-
 include/tst_safe_clocks.h     |  48 ++-
 include/tst_safe_macros.h     | 130 ++++----
 include/tst_safe_posix_ipc.h  |   6 +-
 include/tst_safe_prw.h        |  16 +-
 lib/safe_file_ops.c           | 207 +++++++-----
 lib/safe_macros.c             | 602 ++++++++++++++++++++++------------
 lib/safe_net.c                | 262 +++++++++------
 lib/safe_stdio.c              |  34 +-
 lib/tst_checkpoint.c          |  23 +-
 lib/tst_fs_setup.c            |   8 +-
 lib/tst_mkfs.c                |  36 +-
 lib/tst_net.c                 |   9 +-
 lib/tst_resource.c            |   9 +-
 lib/tst_safe_macros.c         | 201 ++++++++++--
 lib/tst_safe_sysv_ipc.c       |  79 +++--
 lib/tst_safe_timerfd.c        |  32 +-
 18 files changed, 1100 insertions(+), 635 deletions(-)

-- 
2.28.0

