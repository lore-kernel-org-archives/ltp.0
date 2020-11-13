From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 17:49:39 +0100
Subject: [LTP] [PATCH v3 0/5] Introduce SAFE_FANOTIFY_MARK() macro + cleanup
Message-ID: <20201113164944.26101-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

quick fix for old distros.

changes v2->v3:
* move safe_fanotify_*() after constant definitions

Kind regards,
Petr

Petr Vorel (5):
  fanotify12: Drop incorrect hint
  fanotify: Handle supported features checks in setup()
  fanotify: Introduce SAFE_FANOTIFY_MARK() macro
  fanotify: Check FAN_REPORT_{FID,NAME} support
  fanotify: Add a pedantic check for return value

 testcases/kernel/syscalls/fanotify/fanotify.h | 150 +++++++++++++++---
 .../kernel/syscalls/fanotify/fanotify01.c     |  53 ++-----
 .../kernel/syscalls/fanotify/fanotify02.c     |  22 +--
 .../kernel/syscalls/fanotify/fanotify03.c     |  48 ++----
 .../kernel/syscalls/fanotify/fanotify04.c     |  32 +---
 .../kernel/syscalls/fanotify/fanotify05.c     |   9 +-
 .../kernel/syscalls/fanotify/fanotify06.c     |  21 +--
 .../kernel/syscalls/fanotify/fanotify07.c     |  17 +-
 .../kernel/syscalls/fanotify/fanotify09.c     |  19 +--
 .../kernel/syscalls/fanotify/fanotify10.c     |  44 ++---
 .../kernel/syscalls/fanotify/fanotify11.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |  57 ++-----
 .../kernel/syscalls/fanotify/fanotify13.c     |  33 +---
 .../kernel/syscalls/fanotify/fanotify15.c     |  24 +--
 .../kernel/syscalls/fanotify/fanotify16.c     |  20 +--
 15 files changed, 209 insertions(+), 345 deletions(-)

-- 
2.29.2

