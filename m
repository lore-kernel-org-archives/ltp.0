From: Cedric Hnyda <chnyda@suse.com>
Date: Tue, 24 Nov 2015 16:41:04 +0100
Subject: [LTP]  [PATCH] kernel/input: add tests
Message-ID: <1448379664-13775-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add testcases to test the kernel input stack
1) Create a virtual mouse and write in /dev/uinput and
check that the data is well received in /dev/input/eventX
2) Create a virtual mouse, write in /dev/uinput, grab the
device and check that the data are not received in other
proccess.
3) Create a virtual mouse and check that the data are well
received in /dev/input/mice
4) Create a virtual mouse and send empty moves: check that
nothing is received in /dev/input/mice
5) Create a virtual mouse and send events which cannot be
sent and check that they are not received in eventX

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/input                         |   5 +
 testcases/kernel/Makefile             |   1 +
 testcases/kernel/input/.gitignore     |   5 +
 testcases/kernel/input/Makefile       |  27 +++++
 testcases/kernel/input/input01.c      | 201 ++++++++++++++++++++++++++++++++++
 testcases/kernel/input/input02.c      | 166 ++++++++++++++++++++++++++++
 testcases/kernel/input/input03.c      | 186 +++++++++++++++++++++++++++++++
 testcases/kernel/input/input04.c      | 179 ++++++++++++++++++++++++++++++
 testcases/kernel/input/input05.c      | 174 +++++++++++++++++++++++++++++
 testcases/kernel/input/input_helper.c |  91 +++++++++++++++
 testcases/kernel/input/input_helper.h |  30 +++++
 11 files changed, 1065 insertions(+)
 create mode 100644 runtest/input
 create mode 100644 testcases/kernel/input/.gitignore
 create mode 100644 testcases/kernel/input/Makefile
 create mode 100644 testcases/kernel/input/input01.c
 create mode 100644 testcases/kernel/input/input02.c
 create mode 100644 testcases/kernel/input/input03.c
 create mode 100644 testcases/kernel/input/input04.c
 create mode 100644 testcases/kernel/input/input05.c
 create mode 100644 testcases/kernel/input/input_helper.c
 create mode 100644 testcases/kernel/input/input_helper.h

diff --git a/runtest/input b/runtest/input
new file mode 100644
index 0000000..c4e330c
--- /dev/null
+++ b/runtest/input
@@ -0,0 +1,5 @@
+input01 input01
+input02 input02
+input03 input03
+input04 input04
+input05 input05
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 50a12fa..453eae6 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -42,6 +42,7 @@ SUBDIRS			+= connectors \
 			   firmware \
 			   fs \
 			   hotplug \
+			   input \
 			   io \
 			   ipc \
 			   logging \
diff --git a/testcases/kernel/input/.gitignore b/testcases/kernel/input/.gitignore
new file mode 100644
index 0000000..c9eb168
--- /dev/null
+++ b/testcases/kernel/input/.gitignore
@@ -0,0 +1,5 @@
+/input01
+/input02
+/input03
+/input04
+/input05
diff --git a/testcases/kernel/input/Makefile b/testcases/kernel/input/Makefile
new file mode 100644
index 0000000..5f1db93
--- /dev/null
+++ b/testcases/kernel/input/Makefile
@@ -0,0 +1,27 @@
+#
+#  Copyright (c) SUSE 2015
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+top_srcdir			?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+FILTER_OUT_MAKE_TARGETS		:= input_helper
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o input_helper.o
diff --git a/testcases/kernel/input/input01.c b/testcases/kernel/input/input01.c
new file mode 100644
index 0000000..dcce215
--- /dev/null
+++ b/testcases/kernel/input/input01.c
@@ -0,0 +1,201 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+ /*
+ * AUTHOR   : Cedric Hnyda
+ * DATE STARTED : 10/21/2015
+ *
+ *  Create a virtual device (mouse), send events to /dev/uinput
+ *  and check that the events are well received in /dev/input/eventX
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+
+#include "input_helper.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+#define NB_TEST 100
+
+static void setup(void);
+static void send_information(void);
+static int verify_data(struct input_event iev, int *nb);
+static int check_information(void);
+static void cleanup(void);
+
+static int fd;
+static int fd2;
+
+char *TCID = "uinput01";
+
+int main(int ac, char **av)
+{
+	int lc;
+	int pid;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
+
+		setup();
+		pid = tst_fork();
+
+		if (!pid)
+			send_information();
+		else {
+			fd2 = setup_read();
+			if (check_information())
+				tst_resm(TFAIL,
+					"Wrong data received in eventX");
+			else
+				tst_resm(TPASS, "Data received in eventX");
+		}
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct uinput_user_dev uidev;
+
+	tst_require_root();
+
+	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0 && errno == ENOENT)
+		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0)
+		tst_brkm(TCONF, NULL, "unable to find and open uinput");
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "open failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_X) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_Y) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	memset(&uidev, 0, sizeof(uidev));
+	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
+	uidev.id.bustype = BUS_USB;
+	uidev.id.vendor  = 0x1;
+	uidev.id.product = 0x1;
+	uidev.id.version = 1;
+
+	if (write(fd, &uidev, sizeof(uidev)) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	sleep(1);
+}
+
+static void send_information(void)
+{
+	struct input_event ev;
+	int nb;
+
+	sleep(1);
+
+	for (nb = 0; nb < NB_TEST; ++nb) {
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_X;
+		ev.value = 10;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_Y;
+		ev.value = 1;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_SYN;
+		ev.code = 0;
+		ev.value = 0;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+		usleep(100);
+
+	}
+
+	cleanup();
+}
+
+static int check_information(void)
+{
+	int nb;
+	int fail;
+	int rd;
+	uint i;
+	struct input_event iev[64];
+
+	fail = 0;
+	nb = 0;
+
+	while (nb < NB_TEST * 3 && !fail) {
+		rd = read(fd2, iev, sizeof(struct input_event) * 64);
+
+		if (rd < (int) sizeof(struct input_event))
+			fail = 1;
+
+		for (i = 0; i < rd / sizeof(struct input_event) && !fail; i++)
+			fail = verify_data(iev[i], &nb);
+	}
+
+	SAFE_CLOSE(NULL, fd2);
+	return fail;
+}
+
+static int verify_data(struct input_event iev, int *nb)
+{
+	if (iev.type == EV_REL && *nb % 3 == 0
+		&& iev.value == 10 && iev.code == REL_X)
+		(*nb)++;
+	else if (iev.type == EV_REL && *nb % 3 == 1
+		&& iev.value == 1 && iev.code == REL_Y)
+		(*nb)++;
+	else if (iev.type == EV_SYN && *nb % 3 == 2
+		&& iev.code == 0)
+		(*nb)++;
+	else
+		return 1;
+	return 0;
+}
+
+static void cleanup(void)
+{
+	if (ioctl(fd, UI_DEV_DESTROY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	SAFE_CLOSE(NULL, fd);
+}
diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
new file mode 100644
index 0000000..5b9d90b
--- /dev/null
+++ b/testcases/kernel/input/input02.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+ /*
+ * AUTHOR   : Cedric Hnyda
+ * DATE STARTED : 10/21/2015
+ *
+ *  Create a virtual device (mouse), send events to /dev/uinput
+ *  and check that the events are not received in /dev/input/eventX
+ *  because the device is grabbed by another process
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "input_helper.h"
+
+#define NB_TEST 100
+
+static void setup(void);
+static void send_information(void);
+static int check_information(void);
+static void cleanup(void);
+
+static int fd;
+static int fd2;
+
+char *TCID = "uinput02";
+
+int main(int ac, char **av)
+{
+	int lc;
+	int pid;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
+
+		setup();
+		pid = tst_fork();
+		fd2 = setup_read();
+
+		if (!pid)
+			send_information();
+		else {
+			if (check_information())
+				tst_resm(TFAIL, "Data received in eventX");
+			else
+				tst_resm(TPASS, "No data received in eventX");
+		}
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct uinput_user_dev uidev;
+
+	tst_require_root();
+
+	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0 && errno == ENOENT)
+		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0)
+		tst_brkm(TCONF, NULL, "unable to find and open uinput");
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "open failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_X) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_Y) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	memset(&uidev, 0, sizeof(uidev));
+	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
+	uidev.id.bustype = BUS_USB;
+	uidev.id.vendor  = 0x1;
+	uidev.id.product = 0x1;
+	uidev.id.version = 1;
+
+	if (write(fd, &uidev, sizeof(uidev)) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	sleep(1);
+}
+
+static void send_information(void)
+{
+	int nb;
+	struct input_event ev;
+
+	if (ioctl(fd2, EVIOCGRAB, 1))
+		tst_brkm(TBROK, cleanup, "ioctl failed");
+	tst_resm(TINFO, "The virtual device was grabbed");
+
+	sleep(1);
+
+	for (nb = 0; nb < NB_TEST; ++nb) {
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_SYN;
+		ev.code = 0;
+		ev.value = 0;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+		usleep(100);
+	}
+
+	cleanup();
+}
+
+static int check_information(void)
+{
+	int nb;
+	int rd;
+	struct input_event iev[64];
+
+	nb = 0;
+
+	while (nb == 0) {
+		rd = read(fd2, iev, sizeof(struct input_event) * 64);
+		if (rd == 0)
+			break;
+		nb++;
+	}
+
+	SAFE_CLOSE(NULL, fd2);
+	return nb == 0;
+}
+
+static void cleanup(void)
+{
+	if (ioctl(fd, UI_DEV_DESTROY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	SAFE_CLOSE(NULL, fd);
+}
diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
new file mode 100644
index 0000000..922866e
--- /dev/null
+++ b/testcases/kernel/input/input03.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+ /*
+ * AUTHOR   : Cedric Hnyda
+ * DATE STARTED : 10/21/2015
+ *
+ *  Create a virtual device (mouse), send events to /dev/uinput
+ *  and check that the events are well received in /dev/input/mice
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "input_helper.h"
+
+#define NB_TEST 100
+#define X_VALUE 10
+#define Y_VALUE 10
+
+static void setup(void);
+static void send_information(void);
+static int check_information(void);
+static void cleanup(void);
+
+static int fd;
+static int fd2;
+
+char *TCID = "uinput03";
+
+int main(int ac, char **av)
+{
+	int lc;
+	int pid;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
+
+		setup();
+		pid = tst_fork();
+
+		if (!pid)
+			send_information();
+		else {
+			if (check_information())
+				tst_resm(TFAIL, "Wrong data received");
+			else
+				tst_resm(TPASS,
+					"Data received in /dev/input/mice");
+		}
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct uinput_user_dev uidev;
+
+	tst_require_root();
+
+	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0 && errno == ENOENT)
+		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0)
+		tst_brkm(TCONF, NULL, "unable to find and open uinput");
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "open failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_X) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_Y) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	memset(&uidev, 0, sizeof(uidev));
+	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
+	uidev.id.bustype = BUS_USB;
+	uidev.id.vendor  = 0x1;
+	uidev.id.product = 0x1;
+	uidev.id.version = 1;
+
+	if (write(fd, &uidev, sizeof(uidev)) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	sleep(1);
+}
+
+static void send_information(void)
+{
+	int nb;
+	struct input_event ev;
+
+	sleep(1);
+
+	for (nb = 0; nb < NB_TEST; ++nb) {
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_X;
+		ev.value = X_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_Y;
+		ev.value = Y_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_SYN;
+		ev.code = 0;
+		ev.value = 0;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+		usleep(100);
+
+	}
+
+	cleanup();
+}
+
+static int check_information(void)
+{
+	int nb;
+	int fail;
+	int rd;
+	char buf[3];
+
+	fd2 = SAFE_OPEN(NULL, "/dev/input/mice", O_RDONLY);
+	fail = 0;
+	nb = 0;
+
+	while (nb < NB_TEST && !fail) {
+		memset(buf, 0, sizeof(char) * 3);
+		rd = read(fd2, buf, sizeof(char) * 3);
+
+		if (rd < (int) sizeof(char) * 3)
+			fail = 1;
+		if (buf[1] != X_VALUE || buf[2] != -Y_VALUE || buf[0] != 40)
+			fail = 1;
+		nb++;
+	}
+
+	SAFE_CLOSE(NULL, fd2);
+	return fail;
+}
+
+static void cleanup(void)
+{
+	if (ioctl(fd, UI_DEV_DESTROY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	SAFE_CLOSE(NULL, fd);
+}
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
new file mode 100644
index 0000000..8bd0af5
--- /dev/null
+++ b/testcases/kernel/input/input04.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+ /*
+ * AUTHOR   : Cedric Hnyda
+ * DATE STARTED : 11/13/2015
+ *
+ *  Create a virtual device (mouse), send empty events to /dev/uinput
+ *  and check that the events are not received in /dev/input/mice
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "input_helper.h"
+
+#define NB_TEST 100
+#define X_VALUE 0
+#define Y_VALUE 0
+
+static void setup(void);
+static void send_information(void);
+static int check_information(void);
+static void cleanup(void);
+
+static int fd;
+static int fd2;
+
+char *TCID = "uinput04";
+
+int main(int ac, char **av)
+{
+	int lc;
+	int pid;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
+
+		setup();
+		pid = tst_fork();
+
+		if (!pid)
+			send_information();
+		else {
+			if (check_information())
+				tst_resm(TPASS,
+					"No data received in /dev/input/mice");
+			else
+				tst_resm(TFAIL,
+					"Data received /dev/input/mice");
+		}
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct uinput_user_dev uidev;
+
+	tst_require_root();
+
+	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0 && errno == ENOENT)
+		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0)
+		tst_brkm(TCONF, NULL, "unable to find and open uinput");
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "open failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_X) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_RELBIT, REL_Y) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	memset(&uidev, 0, sizeof(uidev));
+	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
+	uidev.id.bustype = BUS_USB;
+	uidev.id.vendor  = 0x1;
+	uidev.id.product = 0x1;
+	uidev.id.version = 1;
+
+	if (write(fd, &uidev, sizeof(uidev)) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	sleep(1);
+}
+
+static void send_information(void)
+{
+	struct input_event ev;
+	int nb;
+
+	sleep(1);
+
+	for (nb = 0; nb < NB_TEST; ++nb) {
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_X;
+		ev.value = X_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_Y;
+		ev.value = Y_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_SYN;
+		ev.code = 0;
+		ev.value = 0;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+		usleep(100);
+
+	}
+
+	cleanup();
+}
+
+static int check_information(void)
+{
+	int rv;
+	struct timeval timeout;
+	fd_set set;
+
+	fd2 = SAFE_OPEN(NULL, "/dev/input/mice", O_RDWR);
+	FD_ZERO(&set);
+	FD_SET(fd2, &set);
+	timeout.tv_sec = 0;
+	timeout.tv_usec = 10000;
+	rv = select(fd2 + 1, &set, NULL, NULL, &timeout);
+	if (rv < 0)
+		tst_brkm(TBROK, NULL, "select failed");
+	SAFE_CLOSE(NULL, fd2);
+	return rv == 0;
+}
+
+static void cleanup(void)
+{
+	if (ioctl(fd, UI_DEV_DESTROY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	SAFE_CLOSE(NULL, fd);
+}
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
new file mode 100644
index 0000000..6c5b759
--- /dev/null
+++ b/testcases/kernel/input/input05.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+ /*
+ * AUTHOR   : Cedric Hnyda
+ * DATE STARTED : 11/16/2015
+ *
+ *  Create a virtual device (mouse), send events to /dev/uinput
+ *  and check that the events are not received in /dev/input/eventX
+ *  because it is not possible to sent such events
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "input_helper.h"
+
+#define X_VALUE 10
+#define Y_VALUE 10
+
+#define NB_TEST 100
+
+static void setup(void);
+static void send_information(void);
+static int check_information(void);
+static void cleanup(void);
+
+static int fd;
+static int fd2;
+
+char *TCID = "uinput05";
+
+int main(int ac, char **av)
+{
+	int lc;
+	int pid;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
+
+		setup();
+		pid = tst_fork();
+		fd2 = setup_read();
+
+		if (!pid)
+			send_information();
+		else {
+			if (check_information())
+				tst_resm(TFAIL, "Data received in eventX");
+			else
+				tst_resm(TPASS, "No data received in eventX");
+		}
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct uinput_user_dev uidev;
+
+	tst_require_root();
+
+	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0 && errno == ENOENT)
+		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+
+	if (fd < 0)
+		tst_brkm(TCONF, NULL, "unable to find and open uinput");
+	else if (fd < 0)
+		tst_brkm(TBROK, NULL, "open failed");
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	if (ioctl(fd, UI_SET_KEYBIT, BTN_LEFT) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	memset(&uidev, 0, sizeof(uidev));
+	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
+	uidev.id.bustype = BUS_USB;
+	uidev.id.vendor  = 0x1;
+	uidev.id.product = 0x1;
+	uidev.id.version = 1;
+
+	if (write(fd, &uidev, sizeof(uidev)) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	sleep(1);
+}
+
+static void send_information(void)
+{
+	int nb;
+	struct input_event ev;
+
+	sleep(1);
+
+	for (nb = 0; nb < NB_TEST; ++nb) {
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_X;
+		ev.value = X_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_REL;
+		ev.code = REL_Y;
+		ev.value = Y_VALUE;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+
+		memset(&ev, 0, sizeof(struct input_event));
+		ev.type = EV_SYN;
+		ev.code = 0;
+		ev.value = 0;
+		if (write(fd, &ev, sizeof(struct input_event)) < 0)
+			tst_brkm(TBROK, cleanup, "write failed");
+		usleep(100);
+
+	}
+
+	cleanup();
+}
+
+static int check_information(void)
+{
+	int nb;
+	int rd;
+	struct input_event iev[64];
+
+	nb = 0;
+
+	while (nb == 0) {
+		rd = read(fd2, iev, sizeof(struct input_event) * 64);
+		if (rd == 0)
+			break;
+		nb++;
+	}
+
+	SAFE_CLOSE(NULL, fd2);
+	return nb == 0;
+}
+
+static void cleanup(void)
+{
+	if (ioctl(fd, UI_DEV_DESTROY) < 0)
+		tst_brkm(TBROK, NULL, "ioctl failed");
+	SAFE_CLOSE(NULL, fd);
+}
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
new file mode 100644
index 0000000..7ba7c60
--- /dev/null
+++ b/testcases/kernel/input/input_helper.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <fnmatch.h>
+#include "test.h"
+#include "safe_macros.h"
+#include "input_helper.h"
+
+int setup_read(void)
+{
+	DIR *d;
+	char namedir1[1024];
+	char *event;
+	struct dirent *dp;
+	int fd2;
+
+	event = NULL;
+
+	d = opendir("/sys/devices/virtual/input/");
+	while ((dp = readdir(d))) {
+		if (!fnmatch("input[0-9]*", dp->d_name, 0)) {
+			memset(namedir1, 0, sizeof(namedir1));
+			strcat(namedir1, "/sys/devices/virtual/input/");
+			strcat(namedir1, dp->d_name);
+			if (closedir(d) < 0)
+				tst_brkm(TBROK, NULL, "closedir failed");
+			d = opendir(namedir1);
+			event = find_event(d, namedir1);
+			if (event)
+				break;
+		}
+	}
+
+	closedir(d);
+	fd2 = SAFE_OPEN(NULL, event, O_RDONLY);
+	free(event);
+	return fd2;
+}
+
+char *find_event(DIR *d, char *namedir1)
+{
+	char namedir2[1024];
+	char buf[256];
+	char *event;
+	struct dirent *dp;
+	int fd3;
+	int nb;
+
+	event = malloc(sizeof(char) * 256);
+
+	while ((dp = readdir(d))) {
+		if (!fnmatch("event*", dp->d_name, 0)) {
+			memset(namedir2, 0, sizeof(namedir2));
+			strcpy(namedir2, namedir1);
+			strcat(namedir2, "/name");
+			fd3 = open(namedir2, O_RDONLY);
+			if (fd3 > 0) {
+				nb = read(fd3, &buf, sizeof(VIRTUAL_DEVICE));
+				if (nb < 0)
+					tst_brkm(TBROK, NULL, "read failed");
+				close(fd3);
+				if (!strncmp(buf, VIRTUAL_DEVICE,
+					strlen(VIRTUAL_DEVICE))) {
+					memset(event, 0, 256);
+					strcat(event, "/dev/input/");
+					strcat(event, dp->d_name);
+					return event;
+				}
+			}
+		}
+	}
+	free(event);
+	return NULL;
+}
diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
new file mode 100644
index 0000000..0b62e71
--- /dev/null
+++ b/testcases/kernel/input/input_helper.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef INPUT_HELPER_H
+#define INPUT_HELPER_H
+
+#define VIRTUAL_DEVICE "virtual-device-ltp"
+
+#include <sys/types.h>
+#include <dirent.h>
+
+char *find_event(DIR *d, char *namedir1);
+int setup_read(void);
+
+#endif /* INPUT_HELPER_H */
-- 
2.1.4

