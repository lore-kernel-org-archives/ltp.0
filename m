From: Xiong Zhou <xzhou@redhat.com>
Date: Tue, 27 Mar 2018 21:38:36 +0800
Subject: [LTP] [PATCH v2] fcntl37: test posix lock across execve
In-Reply-To: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
Message-ID: <1522157916-20620-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v2:
	s/LDLIBS/CFLAGS/ in Makefile.
	No fork() and no another function when checking the lock.
	TST_NO_DEFAULT_MAIN to pass fd across execve.
	Update author info. It's from Daniel originally. I copied
from fcntl36.c for v1 patch and forgot to update it. Sorry for
missing this.

 testcases/kernel/syscalls/fcntl/Makefile  |  11 ++--
 testcases/kernel/syscalls/fcntl/fcntl37.c | 101 ++++++++++++++++++++++++++=
++++
 2 files changed, 108 insertions(+), 4 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl37.c

diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/sy=
scalls/fcntl/Makefile
index ae37214..7a215c8 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -21,11 +21,14 @@ top_srcdir		?=3D ../../../..
 fcntl33: LDLIBS+=3D-lrt
 fcntl33_64: LDLIBS+=3D-lrt
=20
-fcntl34: LDLIBS +=3D -lpthread
-fcntl34_64: LDLIBS +=3D -lpthread
+fcntl34: CFLAGS +=3D -pthread
+fcntl34_64: CFLAGS +=3D -pthread
=20
-fcntl36: LDLIBS +=3D -lpthread
-fcntl36_64: LDLIBS +=3D -lpthread
+fcntl36: CFLAGS +=3D -pthread
+fcntl36_64: CFLAGS +=3D -pthread
+
+fcntl37: CFLAGS +=3D -pthread
+fcntl37_64: CFLAGS +=3D -pthread
=20
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/s=
yscalls/fcntl/fcntl37.c
new file mode 100644
index 0000000..d847ae3
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (c) 2018 Red Hat Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
+ *
+ * This is testing for
+ *
+ *	"Record locks are not inherited by a child created via fork(2),
+ *	 but are preserved across an execve(2)."
+ *
+ * from fcntl(2) man page.
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <limits.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "lapi/fcntl.h"
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+static const char fname[] =3D "tst_lock_execve";
+
+static void *thread_fn(void *arg)
+{
+	int fd =3D *(intptr_t *)arg;
+	tst_res(TINFO, "Thread running. fd %d", fd);
+	while(1) sleep(1);
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, ret =3D 0;
+
+	if (argc =3D=3D 2) {
+		fd =3D atoi(argv[1]);
+		struct flock flck =3D {
+			.l_type =3D F_WRLCK,
+			.l_whence =3D SEEK_SET,
+			.l_start =3D 0,
+			.l_len =3D 1,
+		};
+		SAFE_FCNTL(fd, F_GETLK, &flck);
+		if (flck.l_type =3D=3D F_UNLCK)
+			tst_res(TFAIL, "Record lock gets lost after execve");
+		else
+			tst_res(TPASS, "Record lock survives execve");
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(fname);
+		exit(0);
+	}
+
+	fd =3D SAFE_OPEN(fname, O_RDWR|O_CREAT, 0755);
+	struct flock64 flck =3D {
+		.l_type =3D F_WRLCK,
+		.l_whence =3D SEEK_SET,
+		.l_start  =3D 0,
+		.l_len    =3D 1,
+	};
+	SAFE_FCNTL(fd, F_SETLK, &flck);
+
+	pthread_t th;
+	SAFE_PTHREAD_CREATE(&th, NULL, thread_fn, (void *)&fd);
+	sleep(1);
+
+	int flags=3DSAFE_FCNTL(fd, F_GETFD);
+	flags &=3D ~FD_CLOEXEC;
+	SAFE_FCNTL(fd, F_SETFD, flags);
+
+	char fdstr[10];
+	snprintf(fdstr, 10, "%d", fd);
+	char * const newargv[] =3D { argv[0], fdstr, NULL };
+	tst_res(TINFO, "execve %s with %s locked", argv[0], fname);
+	ret =3D execve(argv[0], newargv, NULL);
+	return ret;
+}
--=20
1.8.3.1

