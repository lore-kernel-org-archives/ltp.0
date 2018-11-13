From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 16:17:42 +0100
Subject: [LTP] [PATCH 0/3] Add rt signal newlib support + convert
	rt_sigsuspend01
Message-ID: <20181113151745.24676-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This set lays out interface for converting rt signal tests to new
library and also converts the rt_sigsuspend01 test.

Cyril Hrubis (3):
  lapi/rt_sigaction.h: Make it usable for newlib tests
  lapi/safe_rt_signal.h: Add.
  syscalls/rt_sigsuspend01: Cleanup && convert to newlib

 include/lapi/rt_sigaction.h                        |  10 +-
 include/lapi/safe_rt_signal.h                      |  50 ++++++++
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       | 135 +++++++--------------
 3 files changed, 101 insertions(+), 94 deletions(-)
 create mode 100644 include/lapi/safe_rt_signal.h

-- 
2.16.4

