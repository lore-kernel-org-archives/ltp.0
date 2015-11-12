From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Nov 2015 13:45:47 +0100
Subject: [LTP] [PATCH] open_posix_testsuite: add set_affinity_single()
Message-ID: <46ff3d4f262abe122b1579681c0e568857c3f9dc.1447332053.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Couple testcases rely on set_affinity(), to limit usage of CPUs
to a single one. However they hardcode CPU number to "0", which
is causing problems on systems where CPU0 is not available (for
example it's offline, etc.)

This patch adds set_affinity_single() (which sets affinity to
first single present CPU) and replaces all calls to set_affinity(0).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |  4 +-
 .../conformance/interfaces/pthread_create/1-6.c    |  2 +-
 .../conformance/interfaces/sched_setparam/2-1.c    |  2 +-
 .../conformance/interfaces/sched_setparam/2-2.c    |  2 +-
 .../conformance/interfaces/sched_setparam/9-1.c    |  2 +-
 .../conformance/interfaces/sched_yield/1-1.c       |  4 +-
 testcases/open_posix_testsuite/include/affinity.h  | 54 ++++++++++++++++++++++
 7 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 426988b44eb6..3c4cec77277f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -150,9 +150,9 @@ int main(void)
 	status = PTS_UNRESOLVED;
 
 
-	rc = set_affinity(0);
+	rc = set_affinity_single();
 	if (rc)
-		FAIL_AND_EXIT("set_affinity", errno);
+		FAIL_AND_EXIT("set_affinity_single", errno);
 
 	sp.sched_priority = PRIO_MAIN;
 	rc = pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
index 11654dfc00bf..03c266a4adc9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
@@ -238,7 +238,7 @@ int main(void)
 	int ret;
 	unsigned int i;
 
-	ret = set_affinity(0);
+	ret = set_affinity_single();
 	if (ret) {
 		n_threads = get_ncpu();
 		if (n_threads == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index 10de0afe5e90..86cf3a726893 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -93,7 +93,7 @@ int main(void)
 	   There is no guarantee that the LOOP of the child
 	   can be certainly big enough on any device at any time.
 	 */
-	int rc = set_affinity(0);
+	int rc = set_affinity_single();
 	if (rc) {
 		nb_child = get_ncpu();
 		if (nb_child == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 4b14691d9200..746f9a107217 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -94,7 +94,7 @@ int main(void)
 	   There is no guarantee that the LOOP of the child
 	   can be certainly big enough on any device at any time.
 	 */
-	int rc = set_affinity(0);
+	int rc = set_affinity_single();
 	if (rc) {
 		nb_child = get_ncpu();
 		if (nb_child == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
index c3e4f1c113c3..32f3e5be4501 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
@@ -109,7 +109,7 @@ int main(void)
 	int *child_pid, oldcount, newcount, shm_id, i;
 	struct sched_param param;
 	key_t key;
-	int rc = set_affinity(0);
+	int rc = set_affinity_single();
 	if (rc) {
 		nb_cpu = get_ncpu();
 		if (nb_cpu == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
index 621b9deaaf3d..602733e608ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
@@ -85,9 +85,9 @@ int main(void)
 	}
 
 	/* Must only use a single CPU */
-	rc = set_affinity(0);
+	rc = set_affinity_single();
 	if (rc) {
-		ERR_LOG("set_affinity", rc);
+		ERR_LOG("set_affinity_single", rc);
 		return status;
 	}
 
diff --git a/testcases/open_posix_testsuite/include/affinity.h b/testcases/open_posix_testsuite/include/affinity.h
index 64be34d04e55..f89101645cb5 100644
--- a/testcases/open_posix_testsuite/include/affinity.h
+++ b/testcases/open_posix_testsuite/include/affinity.h
@@ -27,6 +27,7 @@
 # define _GNU_SOURCE
 # define AFFINITY_NEEDS_GNU_SOURCE 1
 # include <sched.h>
+# include <stdio.h>
 
 static int set_affinity(int cpu)
 {
@@ -37,6 +38,59 @@ static int set_affinity(int cpu)
 
 	return (sched_setaffinity(0, sizeof(cpu_set_t), &mask));
 }
+
+static int get_present_cpu_from_sysfs(void)
+{
+	FILE *f;
+	int cpu = -1;
+
+	f = fopen("/sys/devices/system/cpu/present", "r");
+	if (!f)
+		return -1;
+	fscanf(f, "%d", &cpu);
+	fclose(f);
+
+	return cpu;
+}
+
+static int get_present_cpu_from_cpuinfo(void)
+{
+	FILE *f;
+	int cpu = -1;
+	char line[4096];
+
+	f = fopen("/proc/cpuinfo", "r");
+	if (!f)
+		return -1;
+
+	while (!feof(f)) {
+		if (!fgets(line, sizeof(line), f))
+			return -1;
+		/*
+		 * cpuinfo output is not consistent across all archictures,
+		 * it can be "processor        : N", but for example on s390
+		 * it's: "processor N: ...", so ignore any non-number
+		 * after "processor"
+		 */
+		if (sscanf(line, "processor%*[^0123456789]%d", &cpu) == 1)
+			break;
+	}
+	fclose(f);
+
+	return cpu;
+}
+
+static int set_affinity_single(void)
+{
+	int cpu;
+
+	cpu = get_present_cpu_from_sysfs();
+	if (cpu < 0)
+		cpu = get_present_cpu_from_cpuinfo();
+
+	return set_affinity(cpu);
+}
+
 #else
 static int set_affinity(int cpu)
 {
-- 
1.8.3.1

