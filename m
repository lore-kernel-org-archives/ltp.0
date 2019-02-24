From: YourName <fedebonfi95@gmail.com>
Date: Sun, 24 Feb 2019 21:29:42 +0100
Subject: [LTP] [PATCH v1] Test ioctl syscall for NS_GET_* requests
Message-ID: <20190224202942.21740-1-email@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Federico Bonfiglio <fedebonfi95@gmail.com>

---
 runtest/syscalls                             |  9 +++
 testcases/kernel/syscalls/ioctl/.gitignore   |  8 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 87 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 63 ++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns03.c | 63 ++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 65 +++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 63 ++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 83 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns07.c | 83 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns08.c | 72 +++++++++++++++++++++++
 10 files changed, 596 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns01.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns02.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns03.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns04.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns05.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns06.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns07.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bafe7378c..b518d574a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -495,6 +495,15 @@ ioctl06      ioctl06
 
 ioctl07      ioctl07
 
+ioctl_ns01 ioctl_ns01
+ioctl_ns02 ioctl_ns02
+ioctl_ns03 ioctl_ns03
+ioctl_ns04 ioctl_ns04
+ioctl_ns05 ioctl_ns05
+ioctl_ns06 ioctl_ns06
+ioctl_ns07 ioctl_ns07
+ioctl_ns08 ioctl_ns08
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 79516a17c..f2e2301ac 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -5,3 +5,11 @@
 /ioctl05
 /ioctl06
 /ioctl07
+/ioctl_ns01
+/ioctl_ns02
+/ioctl_ns03
+/ioctl_ns04
+/ioctl_ns05
+/ioctl_ns06
+/ioctl_ns07
+/ioctl_ns08
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
new file mode 100644
index 000000000..68baafb48
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Child process has a new pid namespace, which should make the call fail
+ * with EPERM error.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_PARENT
+#define NSIO	0xb7
+#define NS_GET_PARENT   _IO(NSIO, 0x2)
+#endif
+
+static void test_ns_get_parent(void)
+{
+	int fd, parent_fd;
+	char my_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/pid");
+	fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_PARENT);
+	if (parent_fd == -1) {
+		if (errno == EPERM)
+			tst_res(TPASS, "NS_GET_PARENT fails with EPERM");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+		exit(0);
+	} else {
+		SAFE_CLOSE(parent_fd);
+	}
+	SAFE_CLOSE(fd);
+	exit(-1);
+}
+
+static void run(void)
+{
+	int res = unshare(CLONE_NEWPID);
+
+	if (res == -1) {
+		tst_res(TCONF, "unshare syscall error");
+		exit(-1);
+	}
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0)
+		test_ns_get_parent();
+	else {
+		int status;
+
+		wait(&status);
+		if (status < 0)
+			tst_res(TFAIL, "call to ioctl succeded");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
new file mode 100644
index 000000000..7feacd626
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Tries to get namespace parent for UTS namespace.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_PARENT
+#define NSIO	0xb7
+#define NS_GET_PARENT   _IO(NSIO, 0x2)
+#endif
+
+static void run(void)
+{
+	int fd, parent_fd;
+	char my_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/uts");
+	fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_PARENT);
+	if (parent_fd == -1) {
+		if (errno == EINVAL)
+			tst_res(TPASS, "NS_GET_PARENT fails with EINVAL");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+	} else {
+		tst_res(TFAIL, "call to ioctl succeded");
+		SAFE_CLOSE(parent_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
new file mode 100644
index 000000000..3d4e92872
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Tries to get parent of initial namespace.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_PARENT
+#define NSIO	0xb7
+#define NS_GET_PARENT   _IO(NSIO, 0x2)
+#endif
+
+static void run(void)
+{
+	int fd, parent_fd;
+	char my_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/pid");
+	fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_PARENT);
+	if (parent_fd == -1) {
+		if (errno == EPERM)
+			tst_res(TPASS, "NS_GET_PARENT of initial user fails");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+	} else {
+		tst_res(TFAIL, "call to ioctl succeded");
+		SAFE_CLOSE(parent_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
new file mode 100644
index 000000000..c61360611
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_OWNER_UID request.
+ *
+ * Fails attempting request for UTS namespace.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_OWNER_UID
+#define NSIO    0xb7
+#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+#endif
+
+static void run(void)
+{
+	int fd, owner_fd;
+	char my_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/uts");
+	fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	uid_t uid;
+
+	owner_fd = ioctl(fd, NS_GET_OWNER_UID, &uid);
+	if (owner_fd == -1) {
+		if (errno == EINVAL)
+			tst_res(TPASS, "NS_GET_OWNER_UID fails, UTS namespace");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+	} else {
+		tst_res(TFAIL, "call to ioctl succeded");
+		SAFE_CLOSE(owner_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.11",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
new file mode 100644
index 000000000..987012394
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_USERNS request.
+ *
+ * Fails attempting request for out of scope namespace.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_USERNS
+#define NSIO    0xb7
+#define NS_GET_USERNS	   _IO(NSIO, 0x1)
+#endif
+
+static void run(void)
+{
+	int fd, parent_fd;
+	char my_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/user");
+	fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_USERNS);
+	if (parent_fd == -1) {
+		if (errno == EPERM)
+			tst_res(TPASS, "NS_GET_USERNS fails with EPERM");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+	} else {
+		tst_res(TFAIL, "call to ioctl succeded");
+		SAFE_CLOSE(parent_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
new file mode 100644
index 000000000..9a0eb93f6
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Child process should have a new namespace.
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_PARENT
+#define NSIO	0xb7
+#define NS_GET_PARENT   _IO(NSIO, 0x2)
+#endif
+
+static void run(void)
+{
+	int res = unshare(CLONE_NEWPID);
+
+	if (res < 0) {
+		tst_res(TCONF, "unshare error");
+		exit(0);
+	}
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		exit(0);
+	} else {
+		char my_namespace[20], child_namespace[20];
+
+		sprintf(my_namespace, "/proc/self/ns/pid");
+		sprintf(child_namespace, "/proc/%i/ns/pid", pid);
+		int my_fd, child_fd, parent_fd;
+
+		my_fd = SAFE_OPEN(my_namespace, O_RDONLY);
+		child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+		parent_fd = ioctl(child_fd, NS_GET_PARENT);
+
+		struct stat my_stat, child_stat, parent_stat;
+
+		fstat(my_fd, &my_stat);
+		fstat(child_fd, &child_stat);
+		fstat(parent_fd, &parent_stat);
+		if (my_stat.st_ino != parent_stat.st_ino)
+			tst_res(TFAIL, "parents have different inodes");
+		else if (parent_stat.st_ino == child_stat.st_ino)
+			tst_res(TFAIL, "child and parent have same inode");
+		else
+			tst_res(TPASS, "child and parent are consistent");
+		SAFE_CLOSE(my_fd);
+		SAFE_CLOSE(child_fd);
+		SAFE_CLOSE(parent_fd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
new file mode 100644
index 000000000..a743bb1c8
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_USERNS request.
+ *
+ * Child process should have a new namespace.
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_USERNS
+#define NSIO	0xb7
+#define NS_GET_USERNS   _IO(NSIO, 0x1)
+#endif
+
+#define STACK_SIZE (1024 * 1024)
+
+static char child_stack[STACK_SIZE];
+
+static int child(void *arg)
+{
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid = ltp_clone(CLONE_NEWUSER, &child, 0,
+		STACK_SIZE, child_stack);
+
+	char my_namespace[20], child_namespace[20];
+
+	sprintf(my_namespace, "/proc/self/ns/user");
+	sprintf(child_namespace, "/proc/%i/ns/user", pid);
+	int my_fd, child_fd, parent_fd;
+
+	my_fd = SAFE_OPEN(my_namespace, O_RDONLY);
+	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+	parent_fd = ioctl(child_fd, NS_GET_USERNS);
+
+	struct stat my_stat, child_stat, parent_stat;
+
+	fstat(my_fd, &my_stat);
+	fstat(child_fd, &child_stat);
+	fstat(parent_fd, &parent_stat);
+	if (my_stat.st_ino != parent_stat.st_ino)
+		tst_res(TFAIL, "parents have different inodes");
+	else if (parent_stat.st_ino == child_stat.st_ino)
+		tst_res(TFAIL, "child and parent have same inode");
+	else
+		tst_res(TPASS, "child and parent are consistent");
+	SAFE_CLOSE(my_fd);
+	SAFE_CLOSE(parent_fd);
+	SAFE_CLOSE(child_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns08.c b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
new file mode 100644
index 000000000..dcb2f11f4
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_* request for file descriptors
+ * that aren't namespaces.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include "tst_test.h"
+
+#ifndef NS_GET_USERNS
+#define NSIO	0xb7
+#define NS_GET_USERNS	   _IO(NSIO, 0x1)
+#define NS_GET_PARENT	   _IO(NSIO, 0x2)
+#define NS_GET_NSTYPE	   _IO(NSIO, 0x3)
+#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+#endif
+
+static int requests[] = {NS_GET_PARENT, NS_GET_USERNS,
+	NS_GET_OWNER_UID, NS_GET_NSTYPE};
+
+static void test_request(unsigned int n)
+{
+	int request = requests[n];
+	int fd, ns_fd;
+
+	char *path = tst_get_tmpdir();
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+	ns_fd = ioctl(fd, request);
+	if (ns_fd == -1) {
+		if (errno == ENOTTY)
+			tst_res(TPASS, "request failed with ENOTTY");
+		else
+			tst_res(TFAIL, "unexpected error %u", errno);
+	} else {
+		tst_res(TFAIL, "request succes for invalid fd");
+		SAFE_CLOSE(ns_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(requests),
+	.test = test_request,
+	.needs_tmpdir = 1,
+	.min_kver = "4.11",
+};
-- 
2.11.0

