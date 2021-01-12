From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 20:30:36 +0100
Subject: [LTP] [PATCH 0/3] Build fix undefined struct file_handle
Message-ID: <20210112193039.12506-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

this would be great to get merged before release.

Kind regards,
Petr

Petr Vorel (3):
  lapi: Move struct file_handle into lapi/fcntl.h
  fanotify: Fix build on undefined struct file_handle
  syscalls: Remove unused include <fcntl.h>

 include/lapi/fcntl.h                                   | 10 ++++++++++
 include/lapi/name_to_handle_at.h                       |  9 +--------
 testcases/kernel/syscalls/fanotify/fanotify.h          |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify09.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify13.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify15.c        |  1 -
 testcases/kernel/syscalls/fanotify/fanotify16.c        |  1 -
 .../syscalls/name_to_handle_at/name_to_handle_at01.c   |  1 -
 .../syscalls/name_to_handle_at/name_to_handle_at02.c   |  1 -
 .../syscalls/open_by_handle_at/open_by_handle_at01.c   |  1 -
 .../syscalls/open_by_handle_at/open_by_handle_at02.c   |  1 -
 11 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.29.2

