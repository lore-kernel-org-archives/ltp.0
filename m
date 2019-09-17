From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 17 Sep 2019 12:17:04 +0200
Subject: [LTP] [PATCH 0/2] Increase fsync() coverage - GH#452
Message-ID: <20190917101706.10013-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset partially solves GH issue #452. New test cases: Call fsync()
on open socket, fifo, and closed non-negative file descriptor.

What is not tested (yet): fsync() calls which produce EINTR, EIO, ENOSPC,
EROFS or EDQUOT errors. These errors can only happen while data in kernel
buffers is being written to disk. Producing these errors reliably would
require some control over the block device underlying the file system.

Martin Doucha (2):
  Update syscalls/fsync03 to new API
  Improve coverage in syscalls/fsync03

 testcases/kernel/syscalls/fsync/fsync03.c | 189 +++++++++-------------
 1 file changed, 76 insertions(+), 113 deletions(-)

-- 
2.22.1

