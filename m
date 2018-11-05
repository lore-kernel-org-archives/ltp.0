From: Sandeep Patil <sspatil@google.com>
Date: Mon,  5 Nov 2018 15:50:14 -0800
Subject: [LTP] [PATCH 0/5] Misc cleanups (new lib) and fixes for Android
Message-ID: <20181105235019.254846-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The following series contains patches to cleanup some of the old tests
and make use of the new library in them. That came with additional
benefit of getting easy ways to make those tests run on Android systems.

Note that some of these tests were made to run by hard coding for
ANDROID in them and that now goes away too.[1]

Sandeep Patil (5):
  chroot01: Use the 'tmpdir' we create.
  syscalls/chmod07: Use new ltp library
  syscalls/fchmod02: fall back to use "daemon" group if "users" is
    absent.
  syscalls/chmod05: Use new ltp library
  syscalls/posix_fadvise0[13]: Start using new library.

 testcases/kernel/syscalls/chmod/chmod05.c     | 187 ++++--------------
 testcases/kernel/syscalls/chmod/chmod07.c     | 174 ++++------------
 testcases/kernel/syscalls/chroot/chroot01.c   |   4 +-
 .../kernel/syscalls/fadvise/posix_fadvise01.c | 135 +++----------
 .../kernel/syscalls/fadvise/posix_fadvise03.c | 163 ++++-----------
 testcases/kernel/syscalls/fchmod/fchmod02.c   |   7 +-
 6 files changed, 148 insertions(+), 522 deletions(-)

1] https://android-review.googlesource.com/c/platform/external/ltp/+/813818
   https://android-review.googlesource.com/c/platform/external/ltp/+/813822

-- 
2.19.1.930.g4563a0d9d0-goog

