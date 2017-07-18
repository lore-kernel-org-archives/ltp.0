From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 18 Jul 2017 09:33:15 +0200
Subject: [LTP] [PATCH 0/4] CVE-2016-10044 and SAFE_PERSONALITY
Message-ID: <20170718073319.23543-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch requires the previous CVE patch set!

It adds a test for CVE-2016-10044 and introduces the SAFE_PERSONALITY macro
since this is the second test I have written which uses the personality
syscall.

Richard Palethorpe (4):
  configure.ac: Add check for aio_abi.h
  lib: Add personality fallback and SAFE macro
  CVE-2012-0957: Use SAFE_PERSONALITY
  Test for CVE-2016-10044 mark AIO pseudo-fs noexec

 configure.ac                   |  4 ++
 include/lapi/personality.h     | 48 ++++++++++++++++++++++
 include/tst_personality.h      | 28 +++++++++++++
 lib/tst_personality.c          | 33 +++++++++++++++
 m4/ltp-personality.m4          | 24 +++++++++++
 runtest/cve                    |  1 +
 testcases/cve/.gitignore       |  1 +
 testcases/cve/cve-2012-0957.c  |  8 +---
 testcases/cve/cve-2016-10044.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 233 insertions(+), 6 deletions(-)
 create mode 100644 include/lapi/personality.h
 create mode 100644 include/tst_personality.h
 create mode 100644 lib/tst_personality.c
 create mode 100644 m4/ltp-personality.m4
 create mode 100644 testcases/cve/cve-2016-10044.c

-- 
2.13.2

