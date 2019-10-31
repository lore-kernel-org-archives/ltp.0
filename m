From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 31 Oct 2019 11:21:14 +0100
Subject: [LTP] [PATCH v3 0/2] Increase fsync() coverage - GH#452
In-Reply-To: <20191009152459.GB15291@rei.lan>
References: <20191009152459.GB15291@rei.lan>
Message-ID: <20191031102116.10592-1-mdoucha@suse.cz>
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

Changes since v2:
- coding style fixes
- cleaner setup() and cleanup()
- use TEST() macro for checking fsync() result
- pedantic check of fsync() return value

Martin Doucha (2):
  Update syscalls/fsync03 to new API
  Improve coverage in syscalls/fsync03

 testcases/kernel/syscalls/fsync/fsync03.c | 178 ++++++++--------------
 1 file changed, 63 insertions(+), 115 deletions(-)

-- 
2.23.0

