From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 16:51:18 +0100
Subject: [LTP] [PATCH v2 0/5] Introduce SAFE_FANOTIFY_MARK() macro + cleanup
Message-ID: <20201113155123.5959-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

Changes v1->v2
New commits:
* fanotify12: Drop incorrect hint
* fanotify: Handle supported features checks in setup()
* fanotify: Add a pedantic check for return value
* fanotify: Check FAN_REPORT_{FID,NAME} support

+ implemented changes you suggested for the original commit "fanotify:
Introduce SAFE_FANOTIFY_MARK() macro":

More info at the patches.

Kind regards,
Petr

Petr Vorel (5):
  fanotify12: Drop incorrect hint
  fanotify: Handle supported features checks in setup()
  fanotify: Introduce SAFE_FANOTIFY_MARK() macro
  fanotify: Check FAN_REPORT_{FID,NAME} support
  fanotify: Add a pedantic check for return value

 testcases/kernel/syscalls/fanotify/fanotify.h | 108 +++++++++++++++++-
 .../kernel/syscalls/fanotify/fanotify01.c     |  53 ++-------
 .../kernel/syscalls/fanotify/fanotify02.c     |  22 +---
 .../kernel/syscalls/fanotify/fanotify03.c     |  48 +++-----
 .../kernel/syscalls/fanotify/fanotify04.c     |  32 +-----
 .../kernel/syscalls/fanotify/fanotify05.c     |   9 +-
 .../kernel/syscalls/fanotify/fanotify06.c     |  21 +---
 .../kernel/syscalls/fanotify/fanotify07.c     |  17 +--
 .../kernel/syscalls/fanotify/fanotify09.c     |  19 +--
 .../kernel/syscalls/fanotify/fanotify10.c     |  44 ++-----
 .../kernel/syscalls/fanotify/fanotify11.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |  57 +++------
 .../kernel/syscalls/fanotify/fanotify13.c     |  33 +-----
 .../kernel/syscalls/fanotify/fanotify15.c     |  24 +---
 .../kernel/syscalls/fanotify/fanotify16.c     |  20 +---
 15 files changed, 188 insertions(+), 324 deletions(-)

-- 
2.29.2

