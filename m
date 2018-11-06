From: Sandeep Patil <sspatil@google.com>
Date: Tue,  6 Nov 2018 08:11:24 -0800
Subject: [LTP] [PATCH v2 0/2] Misc cleanup (new lib) and fixes for Android
Message-ID: <20181106161126.251484-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The following series contains patches to cleanup some of the old tests and
make use of the new library in them. That came with additional benefit
of getting easy ways to make those tests run on Android systems.

Note that some of these tests were made to run by hard coding for
ANDROID in them and that now goes away too [1]

v2:
-----
- Drop posix_fadvise patch (done in pull request by Amir Goldsten)
- Drop patches for chroot01 and chmod07, already merged.
- *really test and build the series*


Sandeep Patil (2):
  syscalls/fchmod02: fall back to use "daemon" group if "users" is
    absent.
  syscalls/chmod05: Use new ltp library

 testcases/kernel/syscalls/chmod/chmod05.c   | 191 ++++----------------
 testcases/kernel/syscalls/fchmod/fchmod02.c |   7 +-
 2 files changed, 41 insertions(+), 157 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

