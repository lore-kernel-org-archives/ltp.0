From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 13 Nov 2019 01:56:23 +0100
Subject: [LTP] [PATCH v2 0/3] fanotify musl fixes
Message-ID: <20191113005626.19585-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I generalized previous patch set a bit via autotools checks and also add
other cleanup (base decisions whether to define fallback definitions on
autotools checks).

BTW I tempted to use <linux/fanotify.h>, but not only we'd have to
define fanotify_mark(), but we'd also lost libc header testing.

https://travis-ci.org/pevik/ltp/builds/611138280
(openSUSE Tumbleweed failure is not related to this change)

Kind regards,
Petr

Petr Vorel (3):
  fanotify: Move __kernel_fsid_t definition to correct place
  fanotify: Rework checks for fallback definitions
  fanotify: Detect val vs. __val fanotify_event_info_fid.fsid member

 configure.ac                                  |  1 +
 m4/ltp-fanotify.m4                            |  8 +++++
 testcases/kernel/syscalls/fanotify/fanotify.h | 32 ++++++++++++-------
 .../kernel/syscalls/fanotify/fanotify13.c     |  8 ++---
 .../kernel/syscalls/fanotify/fanotify15.c     |  4 +--
 5 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 m4/ltp-fanotify.m4

-- 
2.24.0

