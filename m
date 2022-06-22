Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D2C43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 09:19:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88F3E3C9493
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 11:19:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C5B03C1364
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 11:19:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 7AADD1A009AB
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 11:19:28 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59A413D5;
 Wed, 22 Jun 2022 02:19:26 -0700 (PDT)
Received: from deb-build-vm.home (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E3B3F66F;
 Wed, 22 Jun 2022 02:19:25 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: ltp@lists.linux.it
Date: Wed, 22 Jun 2022 10:19:19 +0100
Message-Id: <20220622091919.19468-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Fix mountns01/02/03/04 final umounts using more
 peculiar dir names
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Running LTP20220527 release it appears that the recently re-written tests
mountns02/03/04 can now throw a warning on their final umount attempt in
some setup:

<<<test_output>>>
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns04.c:38: TPASS: unbindable mount passed
tst_device.c:395: TWARN: umount('A') failed with EINVAL
mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
tst_device.c:434: TINFO: No device is mounted at B

Moreover, the underlying safe_umount() then upgrades the TWARN emitted
from tst_umount to a TBROK, so causing the test to completely fail:

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 2
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=4 corefile=no

Even though the final SAFE_UMOUNTs in the test body properly unmount the
test created mountpoints, the final cleanup functions, that finally check
to see if those mountpoints are still mounted, can be fooled into falsely
thinking that test-chosen mountpoints "A" or "B" are still there: this is
due to the fact that the internal helper tst_is_mounted() uses a simple
strstr() on /proc/mounts to check if a directory is still mounted and
clearly the currently test-chosen names are far too much simple, being
one-letter, and they can be easily matched by other unrelated mountpoints
that happen to exist on a specific setup.

Use a more peculiar naming for the test chosen mountpoints and generalize
accordingly all the comments.

Cc: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- use LTP_ prefix for global names
v1 --> v2
- using more peculiar naming for mountpoints
- fix comments
- dropped previous SAFE_UMONUT removal

A better, more long term fix should be to fix/harden tst_is_mounted logic,
but looking at mountpoint(1) implementation this is far from trivial to
be done (especially for bind mounts) and it would require a bit of
're-inventing the wheel' to bring all the mountpoint/libmount helpers and
logic inside LTP; on the other side a dirty and ugly solution based on
something like tst_system("mountpoint -q <dir>") would be less portable
since would add the new mountpoint application as an LTP pre-requisite.
(and so just breaking a few CI probably without having a 'mountpoint-less'
failover mechanism)...so I just generalized the chosen names for now...
---
 testcases/kernel/containers/mountns/mountns.h  |  4 ++--
 .../kernel/containers/mountns/mountns01.c      | 18 +++++++++---------
 .../kernel/containers/mountns/mountns02.c      | 18 +++++++++---------
 .../kernel/containers/mountns/mountns03.c      | 18 +++++++++---------
 .../kernel/containers/mountns/mountns04.c      |  8 ++++----
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
index ad8befa71..76b37b477 100644
--- a/testcases/kernel/containers/mountns/mountns.h
+++ b/testcases/kernel/containers/mountns/mountns.h
@@ -10,8 +10,8 @@
 #include "tst_test.h"
 #include "lapi/namespaces_constants.h"
 
-#define DIRA "A"
-#define DIRB "B"
+#define DIRA "LTP_DIR_A"
+#define DIRB "LTP_DIR_B"
 
 static int dummy_child(void *v)
 {
diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 452fe1d10..e99134aba 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -12,21 +12,21 @@
  *
  * [Algorithm]
  *
- * - Creates directories "A", "B" and files "A/A", "B/B"
+ * - Creates directories DIR_A, DIR_B and files DIR_A/"A", DIR_B/"B"
  * - Unshares mount namespace and makes it private (so mounts/umounts have no
  *   effect on a real system)
- * - Bind mounts directory "A" to "A"
- * - Makes directory "A" shared
+ * - Bind mounts directory DIR_A to DIR_A
+ * - Makes directory DIR_A shared
  * - Clones a new child process with CLONE_NEWNS flag
  * - There are two test cases (where X is parent namespace and Y child namespace):
  *  1. First test case
- *   .. X: bind mounts "B" to "A"
- *   .. Y: must see "A/B"
- *   .. X: umounts "A"
+ *   .. X: bind mounts DIR_B to DIR_A
+ *   .. Y: must see DIR_A/"B"
+ *   .. X: umounts DIR_A
  *  2. Second test case
- *   .. Y: bind mounts "B" to "A"
- *   .. X: must see "A/B"
- *   .. Y: umounts "A"
+ *   .. Y: bind mounts DIR_B to DIR_A
+ *   .. X: must see DIR_A/"B"
+ *   .. Y: umounts DIR_A
  */
 
 #include <sys/wait.h>
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index cbd435958..258b61217 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -12,22 +12,22 @@
  *
  * [Algorithm]
  *
- * - Creates directories "A", "B" and files "A/A", "B/B"
+ * - Creates directories DIR_A, DIR_B and files DIR_A/"A", DIR_B/"B"
  * - Unshares mount namespace and makes it private (so mounts/umounts have no
  *   effect on a real system)
- * - Bind mounts directory "A" to "A"
- * - Makes directory "A" private
+ * - Bind mounts directory DIR_A to DIR_A
+ * - Makes directory DIR_A private
  * - Clones a new child process with CLONE_NEWNS flag
  * - There are two test cases (where X is parent namespace and Y child
  *   namespace):
  *  1. First test case
- *   .. X: bind mounts "B" to "A"
- *   .. Y: must see "A/A" and must not see "A/B"
- *   .. X: umounts "A"
+ *   .. X: bind mounts DIR_B to DIR_A
+ *   .. Y: must see DIR_A/"A" and must not see DIR_A/"B"
+ *   .. X: umounts DIR_A
  *  2. Second test case
- *   .. Y: bind mounts "B" to "A"
- *   .. X: must see "A/A" and must not see "A/B"
- *   .. Y: umounts A
+ *   .. Y: bind mounts DIR_B to DIR_A
+ *   .. X: must see DIR_A/"A" and must not see DIR_A/"B"
+ *   .. Y: umounts DIRA
  */
 
 #include <sys/wait.h>
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 5c19a96a9..f37ae7902 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -12,24 +12,24 @@
  *
  * [Algorithm]
  *
- * - Creates directories "A", "B" and files "A/A", "B/B"
+ * - Creates directories DIRA, DIRB and files DIRA/"A", DIRB/"B"
  * - Unshares mount namespace and makes it private (so mounts/umounts have no
  *   effect on a real system)
- * - Bind mounts directory "A" to itself
- * - Makes directory "A" shared
+ * - Bind mounts directory DIRA to itself
+ * - Makes directory DIRA shared
  * - Clones a new child process with CLONE_NEWNS flag and makes "A" a slave
  *   mount
  * - There are two testcases (where X is parent namespace and Y child
  *   namespace):
  *  1. First test case
- *   .. X: bind mounts "B" to "A"
- *   .. Y: must see the file "A/B"
- *   .. X: umounts "A"
+ *   .. X: bind mounts DIRB to DIRA
+ *   .. Y: must see the file DIRA/"B"
+ *   .. X: umounts DIRA
  *  2. Second test case
- *   .. Y: bind mounts "B" to "A"
- *   .. X: must see only the "A/A" and must not see "A/B" (as slave mount does
+ *   .. Y: bind mounts DIRB to DIRA
+ *   .. X: must see only the DIRA/"A" and must not see DIRA/"B" (as slave mount does
  *         not forward propagation)
- *   .. Y: umounts "A"
+ *   .. Y: umounts DIRA
  */
 
 #include <sys/wait.h>
diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index cc63a03d9..46937ddcd 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -10,12 +10,12 @@
  * Tests an unbindable mount: unbindable mount is an unbindable
  * private mount.
  *
- * - Creates directories "A", "B" and files "A/A", "B/B"
+ * - Creates directories DIRA, DIRB and files DIRA/"A", DIRB/"B"
  * - Unshares mount namespace and makes it private (so mounts/umounts have no
  *   effect on a real system)
- * - Bind mounts directory "A" to "A"
- * - Makes directory "A" unbindable
- * - Check if bind mount unbindable "A" to "B" fails as expected
+ * - Bind mounts directory DIRA to DIRA
+ * - Makes directory DIRA unbindable
+ * - Check if bind mount unbindable DIRA to DIRB fails as expected
  */
 
 #include <sys/wait.h>
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
