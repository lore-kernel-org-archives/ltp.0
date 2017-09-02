From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:20 +0200
Subject: [LTP] [RFC PATCH 0/6] cve: fixes for Android
Message-ID: <20170902005926.15923-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Here some fixes to be able to build testcases/cve directory.

Kind regards,
Petr

Petr Vorel (6):
  android: cve: Disable building cve-2017-5669
  android: lib: Add missing include for tst_safe_pthread.h
  android: Add pty.h header
  android: cve: Fix build
  android: cve/stack_clash: Fix PAGE_MASK defined in <sys/user.h>
  android: cve/stack_clash: Fix warning

 include/android/pty.h         | 46 +++++++++++++++++++++++++++++++++++++++++++
 include/android/versioning.h  | 32 ++++++++++++++++++++++++++++++
 include/tst_safe_pthread.h    |  4 ++++
 testcases/cve/Makefile        |  7 +++++++
 testcases/cve/cve-2014-0196.c |  9 +++++++++
 testcases/cve/stack_clash.c   |  8 ++++----
 6 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100644 include/android/pty.h
 create mode 100644 include/android/versioning.h

-- 
2.14.0

