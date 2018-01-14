From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 14 Jan 2018 17:12:55 +0200
Subject: [LTP] [PATCH 0/3] LTP test for inotify watch after drop caches
Message-ID: <1515942778-12633-1-git-send-email-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series starts with a face lift to existing inotify tests and
adds a test for a problem reported [1] by Niklas Cassel for a setup
of inotify watch on overlayfs.

Also available as a github PR [2].

[1] https://marc.info/?l=linux-unionfs&m=151581833424827&w=2
[2] https://github.com/linux-test-project/ltp/pull/246

Amir Goldstein (3):
  inotify: fix -Wsign-compare compile warnings
  inotify: rewrite old cases with new lib
  syscalls/inotify07: test inotify watch after drop caches

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/inotify/inotify.h   |  10 +-
 testcases/kernel/syscalls/inotify/inotify01.c | 260 ++++++++----------
 testcases/kernel/syscalls/inotify/inotify02.c | 366 ++++++++++++--------------
 testcases/kernel/syscalls/inotify/inotify03.c | 158 +++++------
 testcases/kernel/syscalls/inotify/inotify04.c | 161 +++++------
 testcases/kernel/syscalls/inotify/inotify05.c | 193 ++++++--------
 testcases/kernel/syscalls/inotify/inotify06.c |  61 ++---
 testcases/kernel/syscalls/inotify/inotify07.c | 239 +++++++++++++++++
 10 files changed, 767 insertions(+), 683 deletions(-)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify07.c

-- 
2.7.4

