From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:41 +0200
Subject: [LTP] [PATCH 0/7] UID/GID lookup fixes
Message-ID: <20210903154848.18705-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some LTP tests assume that certain user/group names exist on all systems.
That is not true and those tests fail as a result.

This patchset replaces lookups of specific named users/groups with either
some unused group ID or any existing user/group IDs, depending on test
scenario. There are more tests with the same issue but they also require
porting to the new LTP API. I'll submit those later one by one.

Martin Doucha (7):
  chmod05, fchmod05: Use free GID instead of "bin" group
  Simplify syscalls/mkdir02
  Add user/group ID lookup helper functions
  syscalls/kill05: Use any two unprivileged users
  syscalls/mkdir04: Simplify test and use any existing users
  syscalls/setregid02-04: Simplify GID handling
  syscalls/setregid02-04: Eliminate named group lookups

 include/tst_safe_macros.h                     |   6 ++
 include/tst_uid.h                             |  17 +++
 lib/tst_uid.c                                 | 100 ++++++++++++++++++
 testcases/kernel/syscalls/chmod/chmod05.c     |   7 +-
 testcases/kernel/syscalls/fchmod/fchmod05.c   |   7 +-
 testcases/kernel/syscalls/kill/kill05.c       |  23 ++--
 testcases/kernel/syscalls/mkdir/mkdir02.c     |  77 +++++---------
 testcases/kernel/syscalls/mkdir/mkdir04.c     |  30 ++----
 .../kernel/syscalls/setregid/setregid02.c     |  75 ++++++-------
 .../kernel/syscalls/setregid/setregid03.c     |  92 +++++++---------
 .../kernel/syscalls/setregid/setregid04.c     |  58 +++++-----
 11 files changed, 279 insertions(+), 213 deletions(-)

-- 
2.33.0

