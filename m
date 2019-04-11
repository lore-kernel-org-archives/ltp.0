From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 01:31:12 +0200
Subject: [LTP] [PATCH 0/3][RFC] Android fixes and
	-Werror-implicit-function-declaration as default
Message-ID: <20190411233115.32744-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

patchset [1] from Zhengwang Ruan reminded me my old patchset, which I
haven't sent. Still not sure if all this hunting for 'implicitly
declaring library function' make sense. Maybe it'd be better just remove
-Werror-implicit-function-declaration for Android. Nevertheless this
patchset fixes most (or even all) of them enable
-Werror-implicit-function-declaration for all targets/platforms.

NOTE: this still don't fix Android build (with NDK compiler, outside AOSP
tree), but makes it closer (now it builds at least lib/ folder).

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-April/011643.html

Petr Vorel (3):
  cve/cve-2014-0196: Don't use libutil for Android
  Add more missing <string.h> and <strings.h> includes
  make: Add -Werror-implicit-function-declaration for all targets

 include/mk/env_post.mk                                      | 4 +---
 include/tst_net.h                                           | 1 +
 include/tst_numa.h                                          | 2 ++
 lib/tst_af_alg.c                                            | 1 +
 testcases/cve/Makefile                                      | 6 +++++-
 testcases/kernel/syscalls/acct/acct01.c                     | 1 +
 testcases/kernel/syscalls/add_key/add_key02.c               | 1 +
 testcases/kernel/syscalls/chmod/chmod06.c                   | 1 +
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c   | 1 +
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c   | 1 +
 .../kernel/syscalls/copy_file_range/copy_file_range01.c     | 1 +
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c           | 1 +
 testcases/kernel/syscalls/epoll_wait/epoll_wait01.c         | 1 +
 testcases/kernel/syscalls/execl/execl01_child.c             | 2 ++
 testcases/kernel/syscalls/execle/execle01_child.c           | 4 +++-
 testcases/kernel/syscalls/execlp/execlp01_child.c           | 2 ++
 testcases/kernel/syscalls/execv/execv01_child.c             | 2 ++
 testcases/kernel/syscalls/execve/execve01_child.c           | 4 +++-
 testcases/kernel/syscalls/execve/execve_child.c             | 4 +++-
 testcases/kernel/syscalls/execvp/execvp01_child.c           | 2 ++
 testcases/kernel/syscalls/exit/exit02.c                     | 1 +
 testcases/kernel/syscalls/getcwd/getcwd04.c                 | 1 +
 testcases/kernel/syscalls/getrandom/getrandom02.c           | 2 ++
 testcases/kernel/syscalls/ioctl/ioctl08.c                   | 1 +
 testcases/kernel/syscalls/keyctl/keyctl05.c                 | 1 +
 testcases/kernel/syscalls/keyctl/keyctl06.c                 | 1 +
 testcases/kernel/syscalls/link/link08.c                     | 1 +
 testcases/kernel/syscalls/listxattr/listxattr02.c           | 1 +
 testcases/kernel/syscalls/llistxattr/llistxattr02.c         | 1 +
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c     | 1 +
 testcases/kernel/syscalls/madvise/madvise10.c               | 1 +
 testcases/kernel/syscalls/mkdir/mkdir03.c                   | 1 +
 testcases/kernel/syscalls/read/read01.c                     | 1 +
 testcases/kernel/syscalls/request_key/request_key03.c       | 1 +
 testcases/kernel/syscalls/rmdir/rmdir02.c                   | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt03.c         | 1 +
 testcases/kernel/syscalls/write/write03.c                   | 1 +
 testcases/kernel/syscalls/writev/writev07.c                 | 1 +
 testcases/lib/tst_checkpoint.c                              | 1 +
 testcases/lib/tst_device.c                                  | 1 +
 testcases/lib/tst_kvcmp.c                                   | 1 +
 testcases/network/sctp/sctp_big_chunk.c                     | 1 +
 42 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.20.1

