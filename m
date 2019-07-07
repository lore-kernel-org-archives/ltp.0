From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun,  7 Jul 2019 21:00:11 +0200
Subject: [LTP] [PATCH 0/5] setdomainname() converted to new API
Message-ID: <20190707190016.27296-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

simple to new API + lapi header (fixes for MUSL + (maybe) for Bionic).
Given that sethostname() tests are identical, I'll probably reuse
setdomainname() (compiler time option).

Kind regards,
Petr

Petr Vorel (5):
  lib: include <errno.h> in tst_test.h
  lapi: Add utsname.h
  setdomainname01: Convert to new API
  setdomainname02: Convert to new API
  setdomainname03: Convert to new API

 configure.ac                                  |   1 +
 include/lapi/utsname.h                        |  16 ++
 include/tst_test.h                            |   1 +
 .../syscalls/setdomainname/setdomainname.h    |  58 ++++++
 .../syscalls/setdomainname/setdomainname01.c  | 162 +++-----------
 .../syscalls/setdomainname/setdomainname02.c  | 197 ++++--------------
 .../syscalls/setdomainname/setdomainname03.c  | 195 +++--------------
 7 files changed, 167 insertions(+), 463 deletions(-)
 create mode 100644 include/lapi/utsname.h
 create mode 100644 testcases/kernel/syscalls/setdomainname/setdomainname.h

-- 
2.20.1

