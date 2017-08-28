From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 09:40:41 -0700
Subject: [LTP] [PATCH v2 0/2] Fix getcwd0[12] tests for Android devices
Message-ID: <20170828164043.93407-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removes the unnecessary usage of temporary directory from getcwd01 and
falls back to the directory pointed to by $TMPDIR if "/tmp" doesn't exist
in getcwd02 test.

v1->v2
------
- Split the patch into separate patches for getcwd01 and getcwd02
- Remove the unnecessary header added in v1 (getcwd_helper.h)
- Change the fallback order for tmpdir in getcwd02 as pointed in v1 review

Sandeep Patil (2):
  getcwd01: Remove unnecessary usage of temporary directory
  android: getcwd02: use temp dir from $TMPDIR if present

 testcases/kernel/syscalls/getcwd/getcwd01.c |  6 ----
 testcases/kernel/syscalls/getcwd/getcwd02.c | 43 +++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.14.1.342.g6490525c54-goog

