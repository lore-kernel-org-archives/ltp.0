From: Lucas Boehm <lucas@opentech.at>
Date: Thu, 12 Oct 2017 16:45:04 +0200
Subject: [LTP] [PATCH] open_posix_testsuite/pthread_attr_init
Message-ID: <20171012144504.11569-1-lucas@opentech.at>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

new test of checking default attr of phtread_attr_init()

Linux specific implementation

Signed-off-by: Lucas Boehm <lucas@opentech.at>
---
 .../conformance/interfaces/pthread_attr_init/1-2.c | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/1-2.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/1-2.c
new file mode 100644
index 000000000..ec740e78c
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/1-2.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (c) 2017, Opentech EDV Research GmbH. All rights reserved.
+ * Created by:  lucas AT opentech DOT at
+ * This file is licensed under the GPL license.  For the full content
+ * of this license, see the COPYING file at the top level of this
+ * source tree.
+
+ * Test that pthread_attr_init()
+ *  shall initialize a thread attributes object 'attr' with the default value
+ *  for all the individual attributes used by a given implementation.
+
+ *  Detache state:
+ *  The default setting of the detach state attribute in a newly initialized 
+ *  thread attributes object is PTHREAD_CREATE_JOINABLE.
+ *  (man pthread_attr_getdetachstate)
+ *  
+ *  Scope:
+ *  Linux supports PTHREAD_SCOPE_SYSTEM, but not PTHREAD_SCOPE_PROCESS.
+ *  (man pthread_attr_setscope)
+ *  
+ *  Inherit Scheduler: 	
+ *  The default setting of the inherit-scheduler attribute in a newly 
+ *  initialized thread attributes object is PTHREAD_INHERIT_SCHED.
+ *  (man phread_attr_getinheritsched)
+ *
+ *  Scheduling Policy:
+ *  SCHED_OTHER is the standard Linux time-sharing scheduler that is
+ *  intended for all threads that do not require the special real-time 
+ *  mechanisms. 
+ *  (man sched)
+ *
+ * Scheduling Priority:
+ * For threads scheduled under one of the normal scheduling policies 
+ * (SCHED_OTHER, SCHED_IDLE, SCHED_BATCH), sched_priority is not used 
+ * in scheduling decisions (it must be specified as 0)
+ * (man sched) 
+ *
+ * Steps:
+ * 1.  Initialize a pthread_attr_t object using pthread_attr_init()
+ * 2.  Using pthread_attr_getdetachstate(), test that the default value
+ *     of the detachstate is PTHREAD_CREATE_JOINABLE (the default).
+ * 3.  Using pthread_attr_getscope(), test that the default value
+ *     of the scope is PTHREAD_SCOPE_SYSTEM (the default).
+ * 4.  Using pthread_attr_getinheritsched(), test that the default value
+ *     of the Inherit scheduler is PTHREAD_INHERIT_SCHED (the default).
+ * 5.  Using pthread_attr_getschedpolicy(), test that the default value
+ *     of the sched_policy is SCHED_OTHER (the default).
+ * 6.  Using pthread_attr_getschedparam(), test that the default value
+ *     of the sched_priority is 0 (the default).
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include "posixtest.h"
+
+
+int main(void)
+{
+	pthread_attr_t new_attr;
+	int detach_state;
+	int scope;
+	int inherit_sched;
+	int sched_policy;
+	struct sched_param sched_priority;
+
+
+	/* Initialize attribute */
+	if (pthread_attr_init(&new_attr) != 0) {
+		perror("Cannot initialize attribute object\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* The test passes if the attribute object has a detachstate of
+	 * PTHREAD_CREATE_JOINABLE, which is the default value for this
+	 * attribute. */
+	if (pthread_attr_getdetachstate(&new_attr, &detach_state) != 0) {
+		perror("Error obtaining the detachstate of the attribute\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* The test passes if the attribute object has a scope of
+	 * PTHREAD_SCOPE_SYSTEM, which is the default value for this
+	 * attribute. */
+	if (pthread_attr_getscope(&new_attr, &scope) != 0) {
+		perror("Error obtaining the scope of the attribute\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* The test passes if the attribute object has a inherit sched of
+	 * PTHREAD_INHERIT_SCHED, which is the default value for this
+	 * attribute. */
+	if (pthread_attr_getinheritsched(&new_attr, &inherit_sched) != 0) {
+		perror("Error obtaining the inherit scheduling of the attribute\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* The test passes if the attribute object has a sched policy of
+	 * SCHED_OTHER, which is the default value for this
+	 * attribute. */
+	if (pthread_attr_getschedpolicy(&new_attr, &sched_policy) != 0) {
+		perror("Error obtaining the sched policy of the attribute\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/* The test passes if the attribute object has a inherit sched of
+	 * pthread_attr_getschedparam, which is the default value for this
+	 * attribute. */
+	if (pthread_attr_getschedparam(&new_attr, &sched_priority) != 0) {
+		perror("Error obtaining the sched policy of the attribute\n");
+		return PTS_UNRESOLVED;
+	}
+
+	if (
+		detach_state == PTHREAD_CREATE_JOINABLE && \
+		scope == PTHREAD_SCOPE_SYSTEM && \
+		inherit_sched == PTHREAD_INHERIT_SCHED && \
+		sched_policy == SCHED_OTHER && \
+		sched_priority.sched_priority == 0) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
+	}
+	else {
+		printf("Test FAILED\n");
+		return PTS_FAIL;
+	}
+}
-- 
2.11.0

