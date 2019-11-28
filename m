From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 28 Nov 2019 10:36:09 +0100
Subject: [LTP] [PATCH 0/1] Use real FS block size in fallocate05
Message-ID: <20191128093610.6903-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using fixed-size buffer in fallocate05 caused some failures in the past
due to allocation requests being misaligned with actual file system blocks.
Btrfs in particular will treat misaligned allocation as regular write()
and apply copy-on-write to partially allocated blocks even on the first real
write().

While that behavior is somewhat surprising, it does make sense. Fix the error
by using multiples of real block size in fallocate() and write().

I've also found some XFS and Btrfs quirks which are documented in the patch.
The XFS behavior appears to be intentional. I'm still waiting for reply
whether the Btrfs quirk with deallocating blocks is a bug or not.

I'll also write another fallocate() test later for checking FS behavior
on intentionally misaligned allocation. But this fix can be committed before
that.

Martin Doucha (1):
  Use real FS block size in fallocate05

 .../kernel/syscalls/fallocate/fallocate05.c   | 75 ++++++++++++-------
 1 file changed, 50 insertions(+), 25 deletions(-)

-- 
2.24.0

