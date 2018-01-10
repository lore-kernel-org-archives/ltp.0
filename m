From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 10 Jan 2018 12:59:41 +0100
Subject: [LTP] [PATCH] Remove pthread_barrier_wait_6-1 because it is
	unreliable
Message-ID: <20180110115941.6715-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test is trying assert that an uninitialised argument is handled gracefully
however the behavior of the interface is undefined when the argument has not
been initialised. This test suite is supposed to verify that any given
implementation conforms to the POSIX specification which by definition does
not include undefined behavior.

The test is currently failing on Linux with glibc because the process is
aborting for some reason other than a seg fault.

Due to security concerns, in some cases it is reasonable to assert that some
forms of behavior, such as a NULL pointer dereference, are not acceptable even
if the specification allows it. However, in order for the test to run reliably
across all implementations, we need to be able to handle any other behavior an
implementation is likely to choose. In this case the type of the argument is
opaque and so we can't make any reasonable assumptions about how it will be
handled. So then we have to handle all possible behavior and detect the
scenarios we consider unacceptable.

We feel this is too much complication for a test which is testing something
slightly outside of the test suites purpose.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../interfaces/pthread_barrier_wait/6-1.c          | 66 ----------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/6-1.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/6-1.c
deleted file mode 100644
index fa61360b3..000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/6-1.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * pthread_barrier_wait()
- *
- * The pthread_barrier_wait() function may fail if:
- * [EINVAL] The value specified by barrier does not refer to an initialized barrier object.
- *
- * This case will always pass.
- */
-
-#define _XOPEN_SOURCE 600
-#include <pthread.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <signal.h>
-#include <errno.h>
-#include <string.h>
-#include "posixtest.h"
-
-int rc;
-
-void sig_handler()
-{
-	printf
-	    ("main: blocked on barrier wait with an un-initializied barrier object.\n");
-	printf
-	    ("Test PASSED: Note*: Expected EINVAL when calling this funtion with an un-initialized barrier object, but standard says 'may' fail.\n");
-	exit(PTS_PASS);
-}
-
-int main(void)
-{
-	pthread_barrier_t barrier;
-	struct sigaction act;
-
-	/* Set up main thread to handle SIGALRM */
-	act.sa_flags = 0;
-	act.sa_handler = sig_handler;
-	sigfillset(&act.sa_mask);
-	sigaction(SIGALRM, &act, 0);
-
-	/* Intialize return code */
-	rc = 1;
-
-	/* Call pthread_barrier_wait while refering to an un-initialized barrier object */
-
-	/* Just in case we are blocked, send a SIGALRM after 2 sec. */
-	alarm(2);
-
-	rc = pthread_barrier_wait(&barrier);
-
-	if (rc == EINVAL) {
-		printf("Test PASSED\n");
-	} else {
-		printf("return code : %d, %s\n", rc, strerror(rc));
-		printf
-		    ("Test PASSED: Note*: Expected EINVAL when calling this funtion with an un-initialized barrier object, but standard says 'may' fail.\n");
-	}
-
-	return PTS_PASS;
-}
-- 
2.15.1

