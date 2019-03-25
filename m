From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Mar 2019 14:37:25 +0100
Subject: [LTP] [PATCH v4] syscalls: Add userfaultfd testcase
In-Reply-To: <b1568a15-13bf-5151-bc04-47253183f6d7@suse.com>
References: <20190319080732.30819-1-camann@suse.com>
 <b1568a15-13bf-5151-bc04-47253183f6d7@suse.com>
Message-ID: <20190325133725.GB19716@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> Thanks for the feedback, so far.

> This version fixes compiler warnings, renames the syscall function in
> order to avoid conflicts with future glibc versions and changes
> "syscall" to "syscalls" in the subject.

Thanks for your work. Accepted with minor changes (functional change was to
include config.h before using HAVE_LINUX_USERFAULTFD_H).

Kind regards,
Petr


diff --git testcases/kernel/syscalls/userfaultfd/userfaultfd01.c testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index bb8395e7f..a5e142209 100644
--- testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -1,27 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 SUSE LLC
- *
  * Author: Christian Amann <camann@suse.com>
  *
- */
-
-/*
  * Test userfaultfd
  *
  * Force a pagefault event and handle it using userfaultfd
  * from a different thread
- *
  */
 
+#include "config.h"
 #include "tst_test.h"
-#include "tst_safe_macros.h"
-#include "tst_safe_pthread.h"
-#include "lapi/syscalls.h"
-#include <poll.h>
 
 #ifdef HAVE_LINUX_USERFAULTFD_H
 #include <linux/userfaultfd.h>
+#include <poll.h>
+
+#include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
 
 static int page_size;
 static char *page;
