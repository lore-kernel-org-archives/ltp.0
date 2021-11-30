Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A9C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 07:12:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08F323C5A83
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 08:11:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9AD3C4E29
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 08:11:47 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2D1E200C3D
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 08:11:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638256305; i=@fujitsu.com;
 bh=fbPJkFrBZmgZR7RSBO6Zc2wZkHJReOUQdNuL31V/R88=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=u8QYlDltHRxaVFG5ajsDFzj6KzTCsVXMaKTr7iXERj87xN6EYyvXtcnYDdumysUtH
 O8cf2LdNDpOBekcjQ2eY177liKCX+7lmRuvVfQJ0Zi8hFe2sI8BaF1os9lywKbAUIk
 kw4Xlog4tgpTdrEWONcHXwprlHnaC0CKq+PmDeW87wwuIIvsCsfpVeoZx2n7IU9gfR
 7irFIDfhXdJXwlil3RIVVgVBSEyz0GqclsMa49Z8xZnPzSaN5W6q7dRXleMmWQSJvA
 Cu/4/j/0ssuS3CvbF3AD+UWiZY0/YKzZ9ZQ842MYko5eNhXOtI4JAlRTiY9nofQgHd
 lM/3bgaVvAPvQ==
Received: from [100.115.2.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id BD/D4-12056-1BEC5A16;
 Tue, 30 Nov 2021 07:11:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRWlGSWpSXmKPExsViZ8MxSXfjuaW
 JButnClqs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBm7r+xnLvhsU9F+6ANrA+Nlgy5GLg4hgbOM
 EjMefWTrYuQEcnYySTya5gxh72GUaLsmA2KzCWhKPOtcwAxiiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC9hLrJmwCsxmEVCVuPt3AiOIzSvgITGj+wZYvYSAgsSUh+/B5nAKeEosvvsYyOYA2pUose
 5rMUS5oMTJmU9YIMZLSBx88YIZolVR4lLHN0YIu0Ji1qw2JghbTeLquU3MExgFZyFpn4WkfQE
 j0ypGi6SizPSMktzEzBxdQwMDXUNDU11DXSO9xCrdRL3UUt3y1OISXUO9xPJivdTiYr3iytzk
 nBS9vNSSTYzA4E0pZmTawbis76feIUZJDiYlUd7mzUsThfiS8lMqMxKLM+KLSnNSiw8xynBwK
 Enw9pwCygkWpaanVqRl5gAjCSYtwcGjJML7/gxQmre4IDG3ODMdInWKUZejedLy7cxCLHn5ea
 lS4rytZ4GKBECKMkrz4EbAovoSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWFeE5ApPJl5JXC
 bXgEdwQR0xNuli0GOKElESEk1MFVvsE0RyHjDmHL1zv/zR3ksvUpta9Q2zpz3sEsmVTVl22SV
 N6uY82cqn5mYPan24+v7DLE8Ibn3G37HVoW+mtHx9olw9Z9Xv/+8qQo13xW7leXZ+gmsF89lf
 lrDX/c39Z3z9Jq4v4s+6B99PydCe5WjfprXj6c7tfJeNkwMkPln/7OOWy5988zCF/O5c/q4di
 TL5n+Nv3zc88rLGd9yvgbuNDzgKvlPNUuOQ2SvzZRoNrNX+dtZZwjb6BwR+fKWLS5gX73Zj3V
 6vfP5Wl+axR7WXR69+v3+UL3D3+ovpC5Y83lPWo8to183x5zVMVn80RpRVox7LdjbLN0/5lSs
 um/bvtLPKUPHYPerV6W93UosxRmJhlrMRcWJAIJ9P3dlAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1638256305!46576!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23244 invoked from network); 30 Nov 2021 07:11:45 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 30 Nov 2021 07:11:45 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 29234250375
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 07:11:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1BFC6236939
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 07:11:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 07:11:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 30 Nov 2021 15:11:13 +0800
Message-ID: <1638256273-5208-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638256273-5208-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YaSYuLV+XPW/pQ5/@yuki>
 <1638256273-5208-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/statx: Add docparse formatting
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 31 +++++++++------------
 testcases/kernel/syscalls/statx/statx02.c | 12 +++++----
 testcases/kernel/syscalls/statx/statx03.c | 26 +++++++-----------
 testcases/kernel/syscalls/statx/statx05.c |  8 +++---
 testcases/kernel/syscalls/statx/statx06.c | 33 +++++++----------------
 testcases/kernel/syscalls/statx/statx07.c | 21 ++++++++-------
 6 files changed, 53 insertions(+), 78 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 524acd273..b52bb2988 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -4,35 +4,28 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
  * This code tests the functionality of statx system call.
  *
  * TESTCASE 1:
  * The metadata for normal file are tested against predefined values:
- * 1) gid
- * 2) uid
- * 3) mode
- * 4) blocks
- * 5) size
- * 6) nlink
- * 7) mnt_id
  *
- * A file is created and metadata values are set with
- * predefined values.
- * Then the values obtained using statx is checked against
- * the predefined values.
+ * - gid
+ * - uid
+ * - mode
+ * - blocks
+ * - size
+ * - nlink
+ * - mnt_id
  *
  * TESTCASE 2:
  * The metadata for device file are tested against predefined values:
- * 1) MAJOR number
- * 2) MINOR number
  *
- * A device file is created seperately using mknod(must be a root user).
- * The major number and minor number are set while creation.
- * Major and minor numbers obtained using statx is checked against
- * predefined values.
+ * - MAJOR number
+ * - MINOR number
+ *
  * Minimum kernel version required is 4.11.
  */
 
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
index 63133a3b7..56577599c 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -4,12 +4,13 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
+ *
+ * This code tests the following flags with statx syscall:
  *
- * This code tests the following flags:
- * 1) AT_EMPTY_PATH
- * 2) AT_SYMLINK_NOFOLLOW
+ * - AT_EMPTY_PATH
+ * - AT_SYMLINK_NOFOLLOW
  *
  * A test file and a link for it is created.
  *
@@ -19,6 +20,7 @@
  * To check symlink no follow flag, the linkname is statxed.
  * To ensure that link is not dereferenced, obtained inode is compared
  * with test file inode.
+ *
  * Minimum kernel version required is 4.11.
  */
 
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
index c72d7fead..de2fe4d38 100644
--- a/testcases/kernel/syscalls/statx/statx03.c
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -4,25 +4,17 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
- * This code tests if expected error values are returned for specific cases by
- * statx.
- * The error cases are simulated and the return value is checked against
- * expected error number value.
- * The following error values are tested:
- * 1) EBADF - Bad file descriptor
- * 2) EFAULT - Bad address
- * 3) EINVAL - Invalid argument
- * 4) ENOENT - No such file or directory
- * 5) ENOTDIR - Not a directory
- * 6) ENAMETOOLONG - Filename too long
+ * Test basic error handling of statx syscall:
  *
- * Error scenario is simulated for each listed flag by passing
- * respective arguments.
- * The obtained error flag is checked against the expected
- * flag value for that scenario.
+ * - EBADF - Bad file descriptor
+ * - EFAULT - Bad address
+ * - EINVAL - Invalid argument
+ * - ENOENT - No such file or directory
+ * - ENOTDIR - Not a directory
+ * - ENAMETOOLONG - Filename too long
  *
  * Minimum Kernel version required is 4.11.
  */
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 81a5bcbf2..83c6c3ab5 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -4,10 +4,12 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
+ *
+ * Test statx syscall with STATX_ATTR_ENCRYPTED flag
  *
- * 1) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
+ * - STATX_ATTR_ENCRYPTEDL: A key is required for the file to be encrypted by
  *                          the filesystem.
  *
  * e4crypt is used to set the encrypt flag (currently supported only by ext4).
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 0469d66c5..4a0685a65 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -1,36 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0 or later
 /*
- *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
- *  Email : code@zilogic.com
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email : code@zilogic.com
  */
 
-/*
- * DESCRIPTION :
+/*\
+ * [Description]
  *
- * Test-Case 1 : Testing btime
- * flow :       The time before and after the execution of the create
- *              system call is noted.
- *		It is checked whether the birth time returned by statx lies in
- *              this range.
+ * Test the following file timestamps of statx syscall:
  *
- * Test-Case 2 : Testing mtime
- * flow :       The time before and after the execution of the write
- *              system call is noted.
- *              It is checked whether the modification time returned
- *              by statx lies in this range.
+ * - btime - The time before and after the execution of the create system call is noted.
  *
- * Test-Case 3 : Testing atime
- * flow :       The time before and after the execution of the read
- *              system call is noted.
- *              It is checked whether the access time returned by statx lies in
- *              this range.
+ * - mtime - The time before and after the execution of the write system call is noted.
  *
- * Test-Case 4 : Testing ctime
- * flow :	The time before and after the execution of the chmod
- *              system call is noted.
- *              It is checked whether the status change time returned by statx
- *              lies in this range.
+ * - atime - The time before and after the execution of the read system call is noted.
  *
+ * - ctime - The time before and after the execution of the chmod system call is noted.
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index ec1cdd190..e7045edaa 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -1,15 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
- *  Email : code@zilogic.com
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email : code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
  * This code tests the following flags:
- * 1) AT_STATX_FORCE_SYNC
- * 2) AT_STATX_DONT_SYNC
+ *
+ * - AT_STATX_FORCE_SYNC
+ * - AT_STATX_DONT_SYNC
  *
  * By exportfs cmd creating NFS setup.
  *
@@ -29,11 +30,11 @@
  *
  * The support for SYNC flags was implemented in NFS in:
  *
- * commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
- * Author: Trond Myklebust <trond.myklebust@primarydata.com>
- * Date:   Thu Jan 4 17:46:09 2018 -0500
+ *  commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
+ *  Author: Trond Myklebust <trond.myklebust@primarydata.com>
+ *  Date:   Thu Jan 4 17:46:09 2018 -0500
  *
- *     Support statx() mask and query flags parameters
+ *  Support statx() mask and query flags parameters
  *
  * Hence we skip the test on anything older than 4.16.
  */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
