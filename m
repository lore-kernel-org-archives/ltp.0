From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 15 May 2018 13:00:42 +0200
Subject: [LTP] [PATCH v2] read_all: Drop privileges
In-Reply-To: <20180515103042.GB7220@rei>
References: <20180515103042.GB7220@rei>
Message-ID: <20180515110042.27180-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

The LTP is usually run as root, which allows read_all_dev to read files whi=
ch
are usually protected from being read at random. This patch introduces the =
-p
switch to read_all which is used to drop privileges (switch to the nobody
user) for the read_all_dev test.

If -p is set, but the current user does not have the capabilities to change
the uid and gid, then the test will continue under the current user. This
allows the most common scenarios to work as expected, but may cause
difficulties for someone running the LTP under a semi-privileged user.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/fs                              |  2 +-
 testcases/kernel/fs/read_all/read_all.c | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 42a9bfcbf..a66948a43 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -69,7 +69,7 @@ fs_di fs_di -d $TMPDIR
 # Was not sure why it should reside in runtest/crashme and won=C2=B4t get =
tested ever
 proc01 proc01 -m 128
=20
-read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
+read_all_dev read_all -d /dev -p -q -r 10
 read_all_proc read_all -d /proc -q -r 10
 read_all_sys read_all -d /sys -q -r 10
=20
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/=
read_all/read_all.c
index add3651c8..a8e161129 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -50,6 +50,7 @@
 #include <fnmatch.h>
 #include <semaphore.h>
 #include <ctype.h>
+#include <pwd.h>
=20
 #include "tst_test.h"
=20
@@ -88,6 +89,7 @@ static long worker_count;
 static char *str_max_workers;
 static long max_workers =3D 15;
 static struct worker *workers;
+static char *drop_privs;
=20
 static struct tst_option options[] =3D {
 	{"v", &verbose,
@@ -104,6 +106,8 @@ static struct tst_option options[] =3D {
 	 "-w count Set the worker count limit, the default is 15."},
 	{"W:", &str_worker_count,
 	 "-W count Override the worker count. Ignores (-w) and the processor coun=
t."},
+	{"p", &drop_privs,
+	 "-p       Drop privileges; switch to the nobody user."},
 	{NULL, NULL, NULL}
 };
=20
@@ -247,6 +251,24 @@ static int worker_run(struct worker *self)
 	return 0;
 }
=20
+static void maybe_drop_privs(void)
+{
+	struct passwd *nobody;
+
+	if (!drop_privs)
+		return;
+
+	nobody =3D SAFE_GETPWNAM("nobody");
+
+	TEST(setgid(nobody->pw_gid));
+	if (TEST_RETURN < 0 && TEST_ERRNO !=3D EPERM)
+		tst_brk(TBROK | TTERRNO, "Failed to use nobody gid");
+
+	TEST(setuid(nobody->pw_uid));
+	if (TEST_RETURN < 0 && TEST_ERRNO !=3D EPERM)
+		tst_brk(TBROK | TTERRNO, "Failed to use nobody uid");
+}
+
 static void spawn_workers(void)
 {
 	int i;
@@ -257,8 +279,10 @@ static void spawn_workers(void)
 	for (i =3D 0; i < worker_count; i++) {
 		wa[i].q =3D queue_init();
 		wa[i].pid =3D SAFE_FORK();
-		if (!wa[i].pid)
+		if (!wa[i].pid) {
+			maybe_drop_privs();
 			exit(worker_run(wa + i));
+		}
 	}
 }
=20
--=20
2.16.3

