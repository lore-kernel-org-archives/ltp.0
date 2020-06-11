From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jun 2020 18:35:12 +0800
Subject: [LTP] [PATCH v1 0/4] *** Add LOOP_CONFIGURE ioctl test ***
Message-ID: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit[1], it has added LOOP_CONFIGURE ioctl test.
From this commit, loop_set_fd calls loop_configure with zero
loop_config.

struct loop_config {
	__u32			fd;
	__u32                   block_size;
	struct loop_info64	info;
	__u64			__reserved[8];
}

In addition to doing what LOOP_SET_STATUS can do, LOOP_CONFIGURE can
also be used to:
- Set the correct block size immediately by setting
  loop_config.block_size (I test this in ioctl_loop08.c, like old
ioctl_loop06.c) 
- Explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
  in loop_config.info.lo_flags (I test this in ioctl_loop09.c, like old
ioctl_loop05.c) 
- Explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
  in loop_config.info.lo_flags (I test this in old ioctl_loop02.c)


[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3448914e8cc550ba792d4ccc74471d1ca4293a

Yang Xu (4):
  lapi: Add fallback for LOOP_CONFIGURE ioctl and struct loop_config
  syscalls/ioctl_loop02: Using LOOP_CONFIGURE to set read_only
  syscalls/ioctl_loop08: Add LOOP_CONFIGURE error test with invalid
    block size
  syscalls/ioctl_loop09: Add LOOP_CONFIGURE ioctl test with direct I/O
    flag

 configure.ac                                  |   1 +
 include/lapi/loop.h                           |  23 +++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   2 +
 .../kernel/syscalls/ioctl/ioctl_loop02.c      |  53 ++++--
 .../kernel/syscalls/ioctl/ioctl_loop08.c      | 101 ++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop09.c      | 151 ++++++++++++++++++
 7 files changed, 324 insertions(+), 9 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop09.c

-- 
2.23.0



