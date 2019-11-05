From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue,  5 Nov 2019 01:53:39 +0100
Subject: [LTP] [PATCH 0/2] fanotify musl fixes
Message-ID: <20191105005341.19033-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

2 fixes fanotify builds for musl. What I don't like on this solution is
mixing our lapi implementation with kernel and glibc sources.

Also, understand, if you don't want to put these workarounds just for
musl. Alternative would be to detect presence of
fanotify_event_info_fid.fsid.val with autotools and just TCONF with
TST_TEST_TCONF() if missing (+ revert b8aebc835).

https://travis-ci.org/pevik/ltp/builds/607410576

Kind regards,
Petr

Petr Vorel (2):
  fanotify: Move __kernel_fsid_t definition to correct place
  fanotify: Rename fanotify_event_info_fid struct

 testcases/kernel/syscalls/fanotify/fanotify.h | 22 +++++++++----------
 .../kernel/syscalls/fanotify/fanotify13.c     |  4 ++--
 .../kernel/syscalls/fanotify/fanotify15.c     |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.24.0.rc2

