From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:04 +0100
Subject: [LTP] [PATCH v5 00/10] Introduce SAFE_FANOTIFY_MARK() macro +
 cleanup
Message-ID: <20201201174214.24625-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

Changes v4->v5:
* Fix issue with "fanotify: Add helper for FAN_REPORT_FID support on fs"
  on fanotify01 (unwanted skipping tests). FAN_REPORT_FID is now tested
  both for general support in kernel with fanotify_init() and support on
  tested filesystem in fanotify_mark().

* Fix issue with FAN_MARK_FILESYSTEM (new commit "fanotify: Add helper
  for mark support check").

* Split "[v4,2/6] fanotify: Handle supported features checks in setup()"
  into two commits:
  fanotify: Add helper for access permission check
  fanotify: Add helper for event support check
  (easier to review).

* Drop commit "[v4,5/6] fanotify: Check FAN_REPORT_{FID, NAME} support"
  => IMHO not needed now, as there are {REQUIRE_,}FANOTIFY_FAN_REPORT_FID_ERR_MSG()
  helpers which check for FAN_REPORT_FID. Or am I'm wrong and you need it
  for your patchset?
  There will be needed to add also helper for FAN_REPORT_NAME/FAN_REPORT_DIR_FID
  for fanotify10.c (for kernels > 5.1 && < 5.9), but this is now covered by check
  in create_fanotify_groups() and I don't want to block your patchset even more.
  And this helper should eliminate a need for check in safe_fanotify_init().

* Also safe_fanotify_mark() got simplified more (removing check for
  FAN_MARK_FILESYSTEM and EOPNOTSUPP etc.).

* Properly remove TCONF messages in commit where they're replaced
  (fanotify10.c, also for FAN_REPORT_FID in fanotify01.c and
  fanotify15.c due FAN_REPORT_FID handled in
  {REQUIRE_,}FANOTIFY_FAN_REPORT_FID_ERR_MSG()).

* New commits:
  fanotify: Add helper for mark support check
  fanotify: Use tst_brk_ in safe_fanotify_init()
  fanotify16: Test also on FUSE
  fanotify: Cleanup <sys/fanotify.h> use

I tested everything on kernel without FAN_MARK_FILESYSTEM and
FAN_REPORT_FID support and on newer kernels (5.3.18, 5.7.1, 5.10.0-rc5).

Hope I haven't omitted anything this time (apart from helper for
FAN_REPORT_NAME/FAN_REPORT_DIR_FID).

Kind regards,
Petr

Petr Vorel (10):
  fanotify12: Drop incorrect hint
  fanotify: Add helper for access permission check
  fanotify: Add helper for event support check
  fanotify: Add helper for FAN_REPORT_FID support on fs
  fanotify16: Test also on FUSE
  fanotify: Add helper for mark support check
  fanotify: Introduce SAFE_FANOTIFY_MARK() macro
  fanotify: Use tst_brk_ in safe_fanotify_init()
  fanotify: Add a pedantic check for return value
  fanotify: Cleanup <sys/fanotify.h> use

 testcases/kernel/syscalls/fanotify/fanotify.h | 191 +++++++++++++++---
 .../kernel/syscalls/fanotify/fanotify01.c     |  82 +++-----
 .../kernel/syscalls/fanotify/fanotify02.c     |  27 +--
 .../kernel/syscalls/fanotify/fanotify03.c     |  66 ++----
 .../kernel/syscalls/fanotify/fanotify04.c     |  37 +---
 .../kernel/syscalls/fanotify/fanotify05.c     |  14 +-
 .../kernel/syscalls/fanotify/fanotify06.c     |  26 +--
 .../kernel/syscalls/fanotify/fanotify07.c     |  22 +-
 .../kernel/syscalls/fanotify/fanotify08.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify09.c     |  24 +--
 .../kernel/syscalls/fanotify/fanotify10.c     |  56 ++---
 .../kernel/syscalls/fanotify/fanotify11.c     |  12 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |  63 ++----
 .../kernel/syscalls/fanotify/fanotify13.c     |  59 ++----
 .../kernel/syscalls/fanotify/fanotify14.c     |   6 +-
 .../kernel/syscalls/fanotify/fanotify15.c     |  47 +----
 .../kernel/syscalls/fanotify/fanotify16.c     |  32 +--
 17 files changed, 320 insertions(+), 449 deletions(-)

-- 
2.29.2

