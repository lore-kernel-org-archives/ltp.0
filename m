From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Feb 2021 17:02:39 +0100
Subject: [LTP] [PATCH 0/4] Support for linux stable and glibc tags
Message-ID: <20210222160243.507-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel (4):
  lib: Add support for linux stable and glibc tags
  testinfo.pl: Update parsing more git trees
  io_uring02: Add linux-stable-git tag
  semctl09: Add glibc-git tag

 docparse/testinfo.pl                          | 102 +++++++++++-------
 lib/tst_test.c                                |  41 +++----
 .../kernel/syscalls/io_uring/io_uring02.c     |   7 ++
 .../kernel/syscalls/ipc/semctl/semctl09.c     |  17 ++-
 4 files changed, 106 insertions(+), 61 deletions(-)

-- 
2.30.1

