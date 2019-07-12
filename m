From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jul 2019 16:15:28 +0200
Subject: [LTP] [PATCH 0/2] Fix acct failures on nearly full FS.
Message-ID: <20190712141530.22195-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unfortunately it looks like BSD process accounting on Linux is bit of a
minefield, even when you enable the accounting and everything looks OK
kernel may still drop the data silently for a couple of reasons. You can
have a look at kernel/acct.c. This patch disables the test if there is
no enough disk space because in that case data are silently dropped.

If there is less than 4% of free space the accounting is silently
disabled from the start hence the test produces TCONF unless there is at
least 4.1% of free space now.

Cyril Hrubis (2):
  safe_macros: Add SAFE_STATFS()
  syscalls/acct02: Fix failures with nearly full FS

 include/tst_safe_macros.h               | 18 ++++++++++++++++++
 testcases/kernel/syscalls/acct/acct02.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.21.0

