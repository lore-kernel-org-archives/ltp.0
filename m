From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Jan 2020 12:37:12 +0100
Subject: [LTP] [PATCH 0/3] Fixes for old distros
Message-ID: <20200117113715.22786-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

few fixes for old SLES we still support,
which I'd like to merge before release.

Kind regards,
Petr

Petr Vorel (3):
  pidfd_send_signal: Build with _GNU_SOURCE
  tst_device.h: Use lapi/syscalls.h instead of <sys/syscall.h>
  lapi/syscalls: Add syncfs

 include/lapi/syscalls/arm.in                                    | 1 +
 include/lapi/syscalls/hppa.in                                   | 1 +
 include/lapi/syscalls/i386.in                                   | 1 +
 include/lapi/syscalls/ia64.in                                   | 1 +
 include/lapi/syscalls/powerpc.in                                | 1 +
 include/lapi/syscalls/powerpc64.in                              | 1 +
 include/lapi/syscalls/s390.in                                   | 1 +
 include/lapi/syscalls/s390x.in                                  | 1 +
 include/lapi/syscalls/sh.in                                     | 1 +
 include/lapi/syscalls/sparc.in                                  | 1 +
 include/lapi/syscalls/sparc64.in                                | 1 +
 include/lapi/syscalls/x86_64.in                                 | 1 +
 include/tst_device.h                                            | 2 +-
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c     | 1 +
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c     | 1 +
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c     | 1 +
 16 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.24.1

