From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:14 +0200
Subject: [LTP] [PATCH 0/5] fanotify filesystem mark tests
Message-ID: <20181116065119.6912-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

This series adds some new tests to fanotify and is also available on
my github tree [1].

Patches 1-2 re-structure tests fanotify{01,03} to iterate over the
fanotify mark types and add some missing test coverage for FAN_MARK_MOUNT.

Patches 3-5 add test coverage for the new FAN_MARK_FILESYSTEM API, that
was merged for kernel v4.20-rc1, to tests fanotify{01,03,10}.
Older kernels will report TCONF on the new test cases.

Previous patches from me pending your review:
- Add test case to fanotify09 to track a bug fix in linux-next [2]
- Enhance readahead02 to track an overlayfs regression fix in v4.19 [3]

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fanotify_sb
[2] https://github.com/amir73il/ltp/commits/fanotify_ignore
[3] https://github.com/amir73il/ltp/commits/readahead_fadvise

Amir Goldstein (5):
  syscalls/fanotify01: check events also on mountpoint mark
  syscalls/fanotify03: check permission events also on mountpoint mark
  syscalls/fanotify01: add test for FAN_MARK_FILESYSTEM events
  syscalls/fanotify03: add test for FAN_MARK_FILESYSTEM permission
    events
  syscalls/fanotify10: add tests for FAN_MARK_FILESYSTEM and ignore mask

 testcases/kernel/syscalls/fanotify/fanotify.h |  3 +
 .../kernel/syscalls/fanotify/fanotify01.c     | 92 ++++++++++++-------
 .../kernel/syscalls/fanotify/fanotify03.c     | 55 +++++++++--
 .../kernel/syscalls/fanotify/fanotify10.c     | 40 +++++++-
 4 files changed, 148 insertions(+), 42 deletions(-)

-- 
2.17.1

