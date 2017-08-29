From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 17:11:24 -0700
Subject: [LTP] [RFC][PATCH 0/2] Add support to mount 'tmpfs' for EROFS
	testing
Message-ID: <20170829001126.142076-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are several tests in LTP (especially the syscalls) that test for EROFS
error return in case of "read-only filesystem" that fail on Android (and possibly
other systems) because of the fact that they need to find a free
loopback device, create, format and mount a filesystem by default.

This makes all those tests flaky for number of reasons
 - Loopback device paths are different on Android (i.e. /dev/block/loopN)
	- This is very easily fixable though.
 - Filesystem tools are different on Android and in some cases non-existent.

For a test that checks for EROFS, going through the whole filesystem generation
and mounting is an overkill since the filesystem is unused after the mount anyway.

So, add support to mount 'tmpfs' (read-only if required) in libltp instead
of creating a filesystem and mounting a device. This simplifies a lot of tests
as mentioned in the changelog for PATCH 1/2.

Note: I've tested this on Android system as well as an ubuntu based machine.

Sandeep Patil (2):
  libltp: add support to mount tmpfs
  access04: use the new tmpfs mount for EROFS testing

 include/tst_test.h                          |  6 ++++++
 lib/tst_test.c                              | 17 +++++++++++++++++
 testcases/kernel/syscalls/access/access04.c |  6 +++---
 3 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.14.1.342.g6490525c54-goog

