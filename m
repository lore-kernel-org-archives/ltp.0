From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Mar 2019 11:14:04 +0100
Subject: [LTP] [PATCH v2] syscalls/ioctl08: add file deduplication
 testcases
In-Reply-To: <20190322133228.18901-1-camann@suse.com>
References: <20190322133228.18901-1-camann@suse.com>
Message-ID: <20190325101404.GA20297@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> This adds tests for the ioctl request FIDEDUPERANGE
> on a btrfs device.

> These tests set the contents of two files, and checks
> if the following entities are set correctly after
> the ioctl call:

> - errno (set by ioctl)
> - number of deduplicated bytes
> - status field of the file_dedupe_range_info struct

...
> +++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + *
> + */
> +
> +/*
> + * Tests the ioctl functionality to deduplicate fileranges using
> + * btrfs filesystem.
> + *
> + * 1)	Sets the same contents for two files and deduplicates it.
> + *	Deduplicates 3 bytes and set the status to
> + *	FILE_DEDUPE_RANGE_SAME.
> + * 2)	Sets different content for two files and tries to
> + *	deduplicate it. 0 bytes get deduplicated and status is
> + *	set to FILE_DEDUPE_RANGE_DIFFERS.
> + * 3)	Sets same content for two files but sets the length to
> + *	deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
> + */
> +
LGTM, going to apply it with adding 
#include "config.h" here (that's needed for detecting HAVE_STRUCT_FILE_DEDUPE_RANGE
+ some minor comment cleanup (see complete diff below).

> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include <sys/ioctl.h>
> +#include <errno.h>
> +
> +#ifdef HAVE_STRUCT_FILE_DEDUPE_RANGE
> +#include <linux/fs.h>


Kind regards,
Petr

diff --git m4/ltp-ioctl.m4 m4/ltp-ioctl.m4
index c7e3814c5..81187867c 100644
--- m4/ltp-ioctl.m4
+++ m4/ltp-ioctl.m4
@@ -1,21 +1,6 @@
-dnl
+dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) 2019 SUSE LLC
 dnl Author: Christian Amann <camann@suse.com>
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
 
 AC_DEFUN([LTP_CHECK_FIDEDUPE],[
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
diff --git testcases/kernel/syscalls/ioctl/ioctl08.c testcases/kernel/syscalls/ioctl/ioctl08.c
index 302482dd6..8de80048c 100644
--- testcases/kernel/syscalls/ioctl/ioctl08.c
+++ testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -3,9 +3,6 @@
  * Copyright (c) 2019 SUSE LLC
  * Author: Christian Amann <camann@suse.com>
  *
- */
-
-/*
  * Tests the ioctl functionality to deduplicate fileranges using
  * btrfs filesystem.
  *
@@ -19,10 +16,11 @@
  *	deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
  */
 
+#include "config.h"
 #include <stdlib.h>
-#include "tst_test.h"
 #include <sys/ioctl.h>
 #include <errno.h>
+#include "tst_test.h"
 
 #ifdef HAVE_STRUCT_FILE_DEDUPE_RANGE
 #include <linux/fs.h>
