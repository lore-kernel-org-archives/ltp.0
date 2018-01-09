From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  9 Jan 2018 16:30:28 +0100
Subject: [LTP] [PATCH] Add read_all01 test
Message-ID: <20180109153028.30160-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

While using a shell script I wrote which dumps some of the contents of /sys
and /proc (submitted in a separate patch) I found some minor kernel
bugs. There is already a test specifically for /proc however it is attempti=
ng
to verify the behavior of particular files, where as this test is just doing
a basic sanity check and thus can be applied more generally.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/fs                                |   4 +
 testcases/kernel/fs/read_all/.gitignore   |   1 +
 testcases/kernel/fs/read_all/Makefile     |  22 +++
 testcases/kernel/fs/read_all/read_all01.c | 288 ++++++++++++++++++++++++++=
++++
 4 files changed, 315 insertions(+)
 create mode 100644 testcases/kernel/fs/read_all/.gitignore
 create mode 100644 testcases/kernel/fs/read_all/Makefile
 create mode 100644 testcases/kernel/fs/read_all/read_all01.c

diff --git a/runtest/fs b/runtest/fs
index 3fa210a9f..b8bf54f24 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -69,6 +69,10 @@ fs_di fs_di -d $TMPDIR
 # Was not sure why it should reside in runtest/crashme and won=C2=B4t get =
tested ever
 proc01 proc01 -m 128
=20
+read_all01_dev read_all01 -d /dev
+read_all01_proc read_all01 -d /proc
+read_all01_sys read_all01
+
 #Run the File System Race Condition Check tests as well
 fs_racer fs_racer.sh -t 5
=20
diff --git a/testcases/kernel/fs/read_all/.gitignore b/testcases/kernel/fs/=
read_all/.gitignore
new file mode 100644
index 000000000..4b405760c
--- /dev/null
+++ b/testcases/kernel/fs/read_all/.gitignore
@@ -0,0 +1 @@
+read_all01
diff --git a/testcases/kernel/fs/read_all/Makefile b/testcases/kernel/fs/re=
ad_all/Makefile
new file mode 100644
index 000000000..f51fbe591
--- /dev/null
+++ b/testcases/kernel/fs/read_all/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2017 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?=3D ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+=3D -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/read_all/read_all01.c b/testcases/kernel/f=
s/read_all/read_all01.c
new file mode 100644
index 000000000..f746db33b
--- /dev/null
+++ b/testcases/kernel/fs/read_all/read_all01.c
@@ -0,0 +1,288 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
+/*
+ * Perform a small read on every file in a directory tree.
+ *
+ * Useful for testing file systems like proc, sysfs and debugfs or anything
+ * which exposes a file like API so long as it respects O_NONBLOCK. This t=
est
+ * is not concerned if a particular file in one of these file systems conf=
orms
+ * exactly to its specific documented behavior. Just whether reading from =
that
+ * file causes a serious error such as a NULL pointer dereference.
+ *
+ * It is not required to run this as root, but test coverage will be much
+ * higher with full privileges.
+ *
+ * The reads are preformed by worker processes which are given file paths =
by a
+ * single parent process. The parent process recursively scans a given
+ * directory and passes the file paths it finds to the child processes thr=
ough
+ * a pipe. The test will use a maximum of 15 processes, depending on the
+ * number of CPU cores available, under the assumption that while parallel=
ism
+ * is good we don't want to spend too much time creating processes,
+ * distributing data and waiting for locks.
+ *
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <dirent.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <fnmatch.h>
+
+#include "tst_test.h"
+#include "tst_minmax.h"
+
+#define BUFFER_SIZE 1024
+#define MAX_PATH 4096
+
+struct worker {
+	pid_t pid;
+	int in;
+	int out;
+};
+
+static char *verbose;
+static char *root_dir =3D "/sys";
+static char *exclude;
+static long worker_count;
+static struct worker *workers;
+
+static struct tst_option options[] =3D {
+	{"v", &verbose,
+	 "-v       Print information about successful reads"},
+	{"d:", &root_dir,
+	 "-d path  Path to the directory to read from, defaults to /sys"},
+	{"e:", &exclude,
+	 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(=
3)"},
+	{NULL, NULL, NULL}
+};
+
+static void read_test(const char *path)
+{
+	char buf[BUFFER_SIZE];
+	int fd;
+	ssize_t count;
+
+	if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
+		if (verbose)
+			tst_res(TINFO, "Ignoring %s", path);
+		return;
+	}
+
+	if (verbose)
+		tst_res(TINFO, "%s(%s)", __func__, path);
+
+	fd =3D open(path, O_RDONLY | O_NONBLOCK);
+	if (fd < 0) {
+		tst_res(TINFO | TERRNO, "open(%s)", path);
+		return;
+	}
+
+	count =3D read(fd, buf, sizeof(buf) - 1);
+	if (count > 0 && verbose) {
+		if (count <=3D 20) {
+			if (buf[count - 1] =3D=3D '\n')
+				buf[count - 1] =3D '\0';
+			else
+				buf[count] =3D '\0';
+		} else
+			strcpy(buf + 20, "...");
+
+		tst_res(TINFO, "read(%s, buf) =3D %ld, buf =3D %s",
+			path, count, buf);
+
+	} else if (!count && verbose)
+		tst_res(TINFO, "read(%s) =3D EOF", path);
+	else if (count < 0)
+		tst_res(TINFO | TERRNO, "read(%s)", path);
+
+	SAFE_CLOSE(fd);
+}
+
+static int worker_run(struct worker *self)
+{
+	ssize_t i, j, ret, count;
+	char buf[PIPE_BUF];
+	struct sigaction term_sa =3D {
+		.sa_handler =3D SIG_IGN,
+		.sa_flags =3D 0,
+	};
+
+	sigaction(SIGTTIN, &term_sa, NULL);
+
+	for (count =3D 0;;) {
+		ret =3D read(self->in, buf + count, sizeof(buf) - 1 - count);
+		if (ret < 0 && errno =3D=3D EINTR)
+			continue;
+		else if (ret < 0)
+			tst_res(TBROK | TERRNO,
+				"Worker can not read from pipe");
+		else if (ret =3D=3D 0)
+			break;
+
+		count +=3D ret;
+
+		for (i =3D 0, j =3D 0; i < count; i++) {
+			if (buf[i] =3D=3D '\n') {
+				buf[i] =3D '\0';
+				read_test(buf + j);
+				j =3D i + 1;
+			}
+		}
+
+		count =3D i - j;
+		memmove(buf, buf + j, count);
+		if (sizeof(buf) - 1 - count < 1)
+			tst_brk(TBROK,
+				"Worker receive buffer is too small for path");
+	}
+
+	return 0;
+}
+
+static void spawn_workers(void)
+{
+	int i, j;
+	int pipe[2];
+	struct worker *wa =3D workers;
+
+	bzero(workers, worker_count * sizeof(*workers));
+
+	for (i =3D 0; i < worker_count; i++) {
+		SAFE_PIPE(pipe);
+		wa[i].in =3D pipe[0];
+		wa[i].out =3D pipe[1];
+		wa[i].pid =3D SAFE_FORK();
+		if (!wa[i].pid) {
+			for (j =3D 0; j <=3D i; j++)
+				SAFE_CLOSE(wa[j].out);
+			exit(worker_run(wa + i));
+		} else {
+			SAFE_CLOSE(wa[i].in);
+		}
+	}
+}
+
+static void stop_workers(void)
+{
+	int i;
+
+	for (i =3D 0; workers && i < worker_count; i++) {
+		if (workers[i].out > 0)
+			SAFE_CLOSE(workers[i].out);
+	}
+}
+
+static void sched_work(const char *path)
+{
+	static long cur;
+
+	SAFE_WRITE(1, workers[cur].out, path, strlen(path));
+	cur++;
+	if (cur >=3D worker_count)
+		cur =3D 0;
+}
+
+static void setup(void)
+{
+	worker_count =3D MIN(MAX(SAFE_SYSCONF(_SC_NPROCESSORS_ONLN) - 1, 1), 15);
+	workers =3D (struct worker *)SAFE_MALLOC(worker_count * sizeof(*workers));
+}
+
+static void cleanup(void)
+{
+	stop_workers();
+
+	if (workers)
+		free(workers);
+}
+
+static void visit_dir(const char *path)
+{
+	DIR *dir;
+	struct dirent *dent;
+	struct stat dent_st;
+	char dent_path[MAX_PATH];
+
+	dir =3D opendir(path);
+	if (!dir) {
+		tst_res(TINFO | TERRNO, "opendir(%s)", path);
+		return;
+	}
+
+	for (dent =3D SAFE_READDIR(dir); dent; dent =3D SAFE_READDIR(dir)) {
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (dent->d_type !=3D DT_UNKNOWN) {
+			switch (dent->d_type) {
+			case DT_DIR:
+				snprintf(dent_path, MAX_PATH,
+					 "%s/%s", path, dent->d_name);
+				visit_dir(dent_path);
+				break;
+			case DT_LNK:
+				break;
+			default:
+				snprintf(dent_path, MAX_PATH,
+					 "%s/%s\n", path, dent->d_name);
+				sched_work(dent_path);
+			}
+		} else {
+			SAFE_LSTAT(dent_path, &dent_st);
+			switch (dent_st.st_mode & S_IFMT) {
+			case S_IFDIR:
+				snprintf(dent_path, MAX_PATH,
+					 "%s/%s", path, dent->d_name);
+				visit_dir(dent_path);
+				break;
+			case S_IFLNK:
+				break;
+			default:
+				snprintf(dent_path, MAX_PATH,
+					 "%s/%s\n", path, dent->d_name);
+				sched_work(dent_path);
+			}
+		}
+	}
+
+	SAFE_CLOSEDIR(dir);
+}
+
+static void run(void)
+{
+	spawn_workers();
+
+	visit_dir(root_dir);
+	tst_res(TPASS, "Finished scanning directory tree");
+
+	stop_workers();
+
+}
+
+static struct tst_test test =3D {
+	.options =3D options,
+	.setup =3D setup,
+	.cleanup =3D cleanup,
+	.test_all =3D run,
+	.forks_child =3D 1,
+};
+
--=20
2.15.1

