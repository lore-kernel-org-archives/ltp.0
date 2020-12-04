From: Amir Goldstein <amir73il@gmail.com>
Date: Fri,  4 Dec 2020 11:59:25 +0200
Subject: [LTP] [PATCH 0/5] Fanotify cleanup and test for v5.9 regression
Message-ID: <20201204095930.866421-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Here are my followup patches to your great cleanup and
a new test for a bug fix that is already included in v5.9.y.

Note that I resurrected the helper from your V5 patches that
you turned into a macro following Cyril's comment.
I hope you both find the result satisfying.

There are no direct calls to fanotify_init() after those
cleanups (except for the intended use in fanotify14).

FYI, I have another test (inotify) for another v5.9 regression.
The fix is queued for upstream, but did reach upstream yet, so
I will post that test later.

Thanks,
Amir.

Amir Goldstein (5):
  syscalls/fanotify: Generalize check for FAN_REPORT_FID support
  syscalls/fanotify: Use generic checks for fanotify_init flags
  syscalls/fanotify09: Read variable length events
  syscalls/fanotify09: Add test case with two non-dir children
  syscalls/fanotify09: Add test case for events with filename info

 testcases/kernel/syscalls/fanotify/fanotify.h |  46 +++--
 .../kernel/syscalls/fanotify/fanotify01.c     |   4 +-
 .../kernel/syscalls/fanotify/fanotify09.c     | 167 +++++++++++++-----
 .../kernel/syscalls/fanotify/fanotify10.c     |  26 ++-
 .../kernel/syscalls/fanotify/fanotify11.c     |  21 +--
 .../kernel/syscalls/fanotify/fanotify13.c     |   2 +-
 .../kernel/syscalls/fanotify/fanotify15.c     |   2 +-
 .../kernel/syscalls/fanotify/fanotify16.c     |  14 +-
 8 files changed, 180 insertions(+), 102 deletions(-)

-- 
2.25.1

