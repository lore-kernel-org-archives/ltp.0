From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 Jan 2018 17:37:15 +0100
Subject: [LTP] [PATCH v2] Add read_all file systems test
Message-ID: <20180119163715.32599-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

While using a shell script I wrote, which dumps the contents of /sys and
/proc (submitted in a separate patch), I found some minor kernel bugs. There
is already a test specifically for /proc however it is attempting to verify
the behavior of particular files. This test is more general and can be appl=
ied
to any file system.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2: Use a queue structure instead of pipes for distributing work as well as
    many other small changes.

 runtest/fs                              |   4 +
 testcases/kernel/fs/read_all/.gitignore |   1 +
 testcases/kernel/fs/read_all/Makefile   |  23 ++
 testcases/kernel/fs/read_all/read_all.c | 395 ++++++++++++++++++++++++++++=
++++
 4 files changed, 423 insertions(+)
 create mode 100644 testcases/kernel/fs/read_all/.gitignore
 create mode 100644 testcases/kernel/fs/read_all/Makefile
 create mode 100644 testcases/kernel/fs/read_all/read_all.c

diff --git a/runtest/fs b/runtest/fs
index 3fa210a9f..a595edb98 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -69,6 +69,10 @@ fs_di fs_di -d $TMPDIR
 # Was not sure why it should reside in runtest/crashme and won=C2=B4t get =
tested ever
 proc01 proc01 -m 128
=20
+read_all_dev read_all -d /dev -q -r 10
+read_all_proc read_all -d /proc -q -r 10
+read_all_sys read_all -d /sys -q -r 10
+
 #Run the File System Race Condition Check tests as well
 fs_racer fs_racer.sh -t 5
=20
diff --git a/testcases/kernel/fs/read_all/.gitignore b/testcases/kernel/fs/=
read_all/.gitignore
new file mode 100644
index 000000000..ac2f6ae71
--- /dev/null
+++ b/testcases/kernel/fs/read_all/.gitignore
@@ -0,0 +1 @@
+read_all
diff --git a/testcases/kernel/fs/read_all/Makefile b/testcases/kernel/fs/re=
ad_all/Makefile
new file mode 100644
index 000000000..efb223435
--- /dev/null
+++ b/testcases/kernel/fs/read_all/Makefile
@@ -0,0 +1,23 @@
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
+LDFLAGS 		+=3D -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/=
read_all/read_all.c
new file mode 100644
index 000000000..6f3fe09cc
--- /dev/null
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -0,0 +1,395 @@
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
+ * directory and passes the file paths it finds to the child processes usi=
ng a
+ * queue structure stored in shared memory.
+ *
+ * This allows the file system and individual files to be accessed in
+ * parallel. Passing the repeat parameter (-r) will encourage this.
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
+#include <semaphore.h>
+#include <ctype.h>
+
+#include "tst_test.h"
+
+#define QUEUE_SIZE 16384
+#define BUFFER_SIZE 1024
+#define MAX_PATH 4096
+#define MAX_DISPLAY 40
+
+struct queue {
+	sem_t sem;
+	int front;
+	int back;
+	char data[QUEUE_SIZE];
+};
+
+struct worker {
+	pid_t pid;
+	struct queue *q;
+};
+
+enum dent_action {
+	DA_UNKNOWN,
+	DA_IGNORE,
+	DA_READ,
+	DA_VISIT,
+};
+
+static char *verbose;
+static char *quite;
+static char *root_dir;
+static char *exclude;
+static char *str_repeat;
+static int repeat =3D 1;
+static long worker_count;
+static struct worker *workers;
+
+static struct tst_option options[] =3D {
+	{"v", &verbose,
+	 "-v       Print information about successful reads"},
+	{"q", &quite,
+	 "-q       Don't print file read or open errors"},
+	{"d:", &root_dir,
+	 "-d path  Path to the directory to read from, defaults to /sys"},
+	{"e:", &exclude,
+	 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(=
3)"},
+	{"r:", &str_repeat,
+	 "-r count The number of times to schedule a file for reading"},
+	{NULL, NULL, NULL}
+};
+
+static int queue_pop(struct queue *q, char *buf)
+{
+	int i =3D q->front, j =3D 0;
+
+	sem_wait(&q->sem);
+
+	if (!q->data[i])
+		return 0;
+
+	while (q->data[i]) {
+		buf[j] =3D q->data[i];
+
+		if (++j >=3D BUFFER_SIZE - 1)
+			tst_brk(TBROK, "Buffer is too small for path");
+		if (++i >=3D QUEUE_SIZE)
+			i =3D 0;
+	}
+
+	buf[j] =3D '\0';
+	tst_atomic_store(i + 1, &q->front);
+
+	return 1;
+}
+
+static int queue_push(struct queue *q, const char *buf)
+{
+	int i =3D q->back, j =3D 0;
+	int front =3D tst_atomic_load(&q->front);
+
+	while (buf[j]) {
+		q->data[i] =3D buf[j];
+
+		++j;
+		if (++i >=3D QUEUE_SIZE)
+			i =3D 0;
+		if (i =3D=3D front)
+			return 0;
+	}
+	q->data[i] =3D '\0';
+
+	q->back =3D i + 1;
+	sem_post(&q->sem);
+
+	return 1;
+}
+
+static struct queue *queue_init(void)
+{
+	struct queue *q =3D SAFE_MMAP(NULL, sizeof(*q),
+				    PROT_READ | PROT_WRITE,
+				    MAP_SHARED | MAP_ANONYMOUS,
+				    0, 0);
+
+	sem_init(&q->sem, 1, 0);
+	q->front =3D 0;
+	q->back =3D 0;
+
+	return q;
+}
+
+static void queue_destroy(struct queue *q, int is_worker)
+{
+	if (is_worker)
+		sem_destroy(&q->sem);
+
+	SAFE_MUNMAP(q, sizeof(*q));
+}
+
+static void sanitize_str(char *buf, ssize_t count)
+{
+	int i;
+
+	for (i =3D 0; i < MIN(count, MAX_DISPLAY); i++)
+		if (!isprint(buf[i]))
+			buf[i] =3D ' ';
+
+	if (count <=3D MAX_DISPLAY)
+		buf[count] =3D '\0';
+	else
+		strcpy(buf + MAX_DISPLAY, "...");
+}
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
+	if (fd < 0 && !quite) {
+		tst_res(TINFO | TERRNO, "open(%s)", path);
+		return;
+	} else if (fd < 0)
+		return;
+
+	count =3D read(fd, buf, sizeof(buf) - 1);
+	if (count > 0 && verbose) {
+		sanitize_str(buf, count);
+		tst_res(TINFO, "read(%s, buf) =3D %ld, buf =3D %s",
+			path, count, buf);
+	} else if (!count && verbose)
+		tst_res(TINFO, "read(%s) =3D EOF", path);
+	else if (count < 0 && !quite)
+		tst_res(TINFO | TERRNO, "read(%s)", path);
+
+	SAFE_CLOSE(fd);
+}
+
+static int worker_run(struct worker *self)
+{
+	int ret;
+	char buf[BUFFER_SIZE];
+	struct sigaction term_sa =3D {
+		.sa_handler =3D SIG_IGN,
+		.sa_flags =3D 0,
+	};
+	struct queue *q =3D self->q;
+
+	sigaction(SIGTTIN, &term_sa, NULL);
+
+	for (ret =3D queue_pop(q, buf); ret; ret =3D queue_pop(q, buf))
+		read_test(buf);
+
+	queue_destroy(q, 1);
+	fflush(stdout);
+	return 0;
+}
+
+static void spawn_workers(void)
+{
+	int i;
+	struct worker *wa =3D workers;
+
+	bzero(workers, worker_count * sizeof(*workers));
+
+	for (i =3D 0; i < worker_count; i++) {
+		wa[i].q =3D queue_init();
+		wa[i].pid =3D SAFE_FORK();
+		if (!wa[i].pid)
+			exit(worker_run(wa + i));
+	}
+}
+
+static void stop_workers(void)
+{
+	const char stop_code[1] =3D { '\0' };
+	int i;
+
+	if (!workers)
+		return;
+
+	for (i =3D 0; i < worker_count; i++)
+		if (workers[i].q)
+			queue_push(workers[i].q, stop_code);
+
+	for (i =3D 0; i < worker_count; i++)
+		if (workers[i].q) {
+			queue_destroy(workers[i].q, 0);
+			workers[i].q =3D 0;
+		}
+}
+
+static void sched_work(const char *path)
+{
+	static int cur;
+	int push_attempts =3D 0, pushed;
+
+	while (1) {
+		pushed =3D queue_push(workers[cur].q, path);
+
+		if (++cur >=3D worker_count)
+			cur =3D 0;
+
+		if (pushed)
+			break;
+
+		if (++push_attempts > worker_count) {
+			usleep(100);
+			push_attempts =3D 0;
+		}
+	}
+}
+
+static void rep_sched_work(const char *path, int rep)
+{
+	int i;
+
+	for (i =3D 0; i < rep; i++)
+		sched_work(path);
+}
+
+static void setup(void)
+{
+	if (tst_parse_int(str_repeat, &repeat, 1, INT_MAX))
+		tst_brk(TBROK,
+			"Invalid repeat (-r) argument: '%s'", str_repeat);
+
+	if (!root_dir)
+		tst_brk(TBROK, "The directory argument (-d) is required");
+
+	worker_count =3D MIN(MAX(SAFE_SYSCONF(_SC_NPROCESSORS_ONLN) - 1, 1), 15);
+	workers =3D SAFE_MALLOC(worker_count * sizeof(*workers));
+}
+
+static void cleanup(void)
+{
+	stop_workers();
+	free(workers);
+}
+
+static void visit_dir(const char *path)
+{
+	DIR *dir;
+	struct dirent *dent;
+	struct stat dent_st;
+	char dent_path[MAX_PATH];
+	enum dent_action act;
+
+	dir =3D opendir(path);
+	if (!dir) {
+		tst_res(TINFO | TERRNO, "opendir(%s)", path);
+		return;
+	}
+
+	while (1) {
+		errno =3D 0;
+		dent =3D readdir(dir);
+		if (!dent && errno) {
+			tst_res(TINFO | TERRNO, "readdir(%s)", path);
+			break;
+		} else if (!dent)
+			break;
+
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (dent->d_type =3D=3D DT_DIR)
+			act =3D DA_VISIT;
+		else if (dent->d_type =3D=3D DT_LNK)
+			act =3D DA_IGNORE;
+		else if (dent->d_type =3D=3D DT_UNKNOWN)
+			act =3D DA_UNKNOWN;
+		else
+			act =3D DA_READ;
+
+		snprintf(dent_path, MAX_PATH,
+			 "%s/%s", path, dent->d_name);
+
+		if (act =3D=3D DA_UNKNOWN) {
+			if (lstat(dent_path, &dent_st))
+				tst_res(TINFO | TERRNO, "lstat(%s)", path);
+			else if ((dent_st.st_mode & S_IFMT) =3D=3D S_IFDIR)
+				act =3D DA_VISIT;
+			else if ((dent_st.st_mode & S_IFMT) =3D=3D S_IFLNK)
+				act =3D DA_IGNORE;
+			else
+				act =3D DA_READ;
+		}
+
+		if (act =3D=3D DA_VISIT)
+			visit_dir(dent_path);
+		else if (act =3D=3D DA_READ)
+			rep_sched_work(dent_path, repeat);
+	}
+
+	if (closedir(dir))
+		tst_res(TINFO | TERRNO, "closedir(%s)", path);
+}
+
+static void run(void)
+{
+	spawn_workers();
+	visit_dir(root_dir);
+	stop_workers();
+
+	tst_reap_children();
+	tst_res(TPASS, "Finished reading files");
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

