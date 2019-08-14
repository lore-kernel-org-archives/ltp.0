From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Aug 2019 14:13:28 +0200
Subject: [LTP] [PATCH] syscalls/shmat03: Remove it from runtest/cve
Message-ID: <20190814121328.22999-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original POC[1] and CVE-2017-5669 are not tested by this test
anymore as it turned out that the CVE was bogus.

And the test became regression test for:

commit 8f89c007b6dec16a1793cb88de88fcc02117bbbc
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri May 25 14:47:30 2018 -0700

    ipc/shm: fix shmat() nil address after round-down when remapping

Hence we will keep the test but remove it from the CVE runtest file and adjust
the top level comment in the test code.

[1] https://bugzilla.kernel.org/attachment.cgi?id=252511
    from https://bugzilla.kernel.org/show_bug.cgi?id=192931

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Davidlohr Bueso <dave@stgolabs.net>
---
 runtest/cve                                   |  1 -
 testcases/kernel/syscalls/ipc/shmat/shmat03.c | 32 ++++++++++---------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index 33c9196e0..acbbbe5f5 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -16,7 +16,6 @@ cve-2016-9604 keyctl08
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
-cve-2017-5669 shmat03
 cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index 13ea39c63..18d3db028 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -4,26 +4,28 @@
  * Copyright (c) 2017 Fujitsu Ltd. (Xiao Yang <yangx.jy@cn.fujitsu.com>)
  */
 /*
- * Test for CVE-2017-5669 which allows us to map the nil page using shmat.
+ * Originated as a test for CVE-2017-5669 but as it turns out the CVE was bogus
+ * to begin with and the test was changed into a regression test for commit:
  *
- * When the bug is present shmat(..., (void *)1, SHM_RND) will round address
- * 0x1 down to zero and give us the (nil/null) page. With the current bug fix
- * in place, shmat it will return EINVAL instead. We also check to see if the
- * returned address is outside the nil page in case an alternative fix has
- * been applied.
+ * commit 8f89c007b6dec16a1793cb88de88fcc02117bbbc
+ * Author: Davidlohr Bueso <dave@stgolabs.net>
+ * Date:   Fri May 25 14:47:30 2018 -0700
  *
- * In any case we manage to map some memory we also try to write to it. This
- * is just to see if we get an access error or some other unexpected behaviour.
+ *  ipc/shm: fix shmat() nil address after round-down when remapping
  *
- * See commit 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ * Which makes sure that SHM_REMAP forbids NULL address consistently for
+ * SHM_RND as well.
  *
- * The commit above disallowed SHM_RND maps to zero (and rounded) entirely and
- * that broke userland for cases like Xorg. New behavior disallows REMAPs to
- * lower addresses (0<=PAGESIZE).
+ * The timeline went as:
  *
- * See commit a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
- * See commit 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
- * See https://github.com/linux-test-project/ltp/issues/319
+ * 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ * a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
+ * 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
+ *
+ * The original commit disallowed SHM_RND maps to zero (and rounded) entirely
+ * and that broke userland for cases like Xorg.
+ *
+ * See also https://github.com/linux-test-project/ltp/issues/319
  *
  * This test needs root permissions or else security_mmap_addr(), from
  * get_unmapped_area(), will cause permission errors when trying to mmap lower
-- 
2.21.0

