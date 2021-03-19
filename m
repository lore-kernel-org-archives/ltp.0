From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 14:04:07 +0100
Subject: [LTP] [PATCH 0/8] fanotify tests for v5.13
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <YFShR2Qd7Ubve1wi@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Hi Petr,

> Following tests were used for development of the two features
> queued for v5.13 (in linux-next):
> - Performance improvements for events merge [1]
> - Unprivileged fanotify listener [2]

As these are features not fixes, I suppose nothing from these already merged 2
patchsets in next tree can be added with struct tst_tag to document it.
I wonder if any of these are could be at least noted in the tests / commit
messages.

> All test cases of fanotify05 pass on upstream, but their runtime
> on linux-next is reduced by more than half.

> Only the first test case of fanotify17 pass on upstream.
> The rest of the test cases as well as fanotify18 and fanotify19
> tests exit with TCONF on upstream. They all pass on linux-next.

Thanks! LGTM, thanks for testing them on both mainline and next tree.

To whole patchset:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'll apply it with following tiny fixes to fix compilation on very old kernels
(2.6.x) and to use our documentation format [3] [4].
(+ later I'll fix documentation format for the rest of the tests)

Kind regards,
Petr

> Thanks,
> Amir.

> [1] https://lore.kernel.org/linux-fsdevel/20210304104826.3993892-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/linux-fsdevel/20210304112921.3996419-1-amir73il@gmail.com/

[3] https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.pdf
[4] https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.html

diff --git testcases/kernel/syscalls/fanotify/fanotify17.c testcases/kernel/syscalls/fanotify/fanotify17.c
index ee242a441..98355a7b4 100644
--- testcases/kernel/syscalls/fanotify/fanotify17.c
+++ testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -7,13 +7,15 @@
  * Forked from getxattr05.c by Amir Goldstein <amir73il@gmail.com>
  */
 
-/*
- * DESCRIPTION
- *     Check that fanotify groups and marks limits are enforced correctly.
- *     If user ns is supported, verify that global limit and per user ns
- *     limits are both enforced.
- *     Otherwise, we only check that global groups limit is enforced.
+/*\
+ * [Description]
+ *
+ * Check that fanotify groups and marks limits are enforced correctly.
+ * If user ns is supported, verify that global limit and per user ns
+ * limits are both enforced.
+ * Otherwise, we only check that global groups limit is enforced.
  */
+
 #define _GNU_SOURCE
 #include "config.h"
 #include <errno.h>
diff --git testcases/kernel/syscalls/fanotify/fanotify18.c testcases/kernel/syscalls/fanotify/fanotify18.c
index 1acd23ce2..318245efc 100644
--- testcases/kernel/syscalls/fanotify/fanotify18.c
+++ testcases/kernel/syscalls/fanotify/fanotify18.c
@@ -3,13 +3,17 @@
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  *
  * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
+ */
+
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	This set of tests is to ensure that the unprivileged listener feature of
- *	fanotify is functioning as expected. The objective this test case file
- *	is to validate whether any forbidden flags that are passed by an
- *	unprivileged user return the correct error result.
+ * This set of tests is to ensure that the unprivileged listener feature of
+ * fanotify is functioning as expected. The objective this test case file
+ * is to validate whether any forbidden flags that are passed by an
+ * unprivileged user return the correct error result.
  */
+
 #define _GNU_SOURCE
 #include "config.h"
 
@@ -17,10 +21,9 @@
 #include <stdio.h>
 #include <errno.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 /*
  * This is a set of intialization flags that are not permitted to be used by an
@@ -194,5 +197,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_CONF("System does not have required fanotify support");
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git testcases/kernel/syscalls/fanotify/fanotify19.c testcases/kernel/syscalls/fanotify/fanotify19.c
index 83a9aaa98..92ed45e49 100644
--- testcases/kernel/syscalls/fanotify/fanotify19.c
+++ testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -3,14 +3,18 @@
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
  *
  * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
+ */
+
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	This set of tests is to ensure that the unprivileged listener feature of
- *	fanotify is functioning as expected. The objective of this test file is
- *	to generate a sequence of events and ensure that the returned events
- *	contain the limited values that an unprivileged listener is expected
- *	to receive.
+ * This set of tests is to ensure that the unprivileged listener feature of
+ * fanotify is functioning as expected. The objective of this test file is
+ * to generate a sequence of events and ensure that the returned events
+ * contain the limited values that an unprivileged listener is expected
+ * to receive.
  */
+
 #define _GNU_SOURCE
 #include "config.h"
 
@@ -21,10 +25,9 @@
 #include <sys/wait.h>
 
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 #define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
@@ -249,5 +252,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_CONF("System does not have required fanotify support");
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
