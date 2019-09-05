From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 5 Sep 2019 17:46:27 +0800
Subject: [LTP] [PATCH] uevent03: Use a generic way to get sysname
Message-ID: <1567676787-3050-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

UI_GET_NAME was introduced since 3.15, this ioctl is used
to get sysname. For better compatibility, we can use a generic
way to get sysname by parsing /proc/bus/input/devices.
So this case can also run on old kernel.

Also remove useless lapi/uinput.h.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/uinput.h               | 16 ---------
 include/tst_uinput.h                |  8 +++++
 libs/libltpuinput/tst_uinput.c      | 40 ++++++++++++++++++++++
 testcases/kernel/uevents/uevent03.c | 52 +++++++++++------------------
 4 files changed, 67 insertions(+), 49 deletions(-)
 delete mode 100644 include/lapi/uinput.h

diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
deleted file mode 100644
index 87e338497..000000000
--- a/include/lapi/uinput.h
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
- */
-
-#ifndef __LAPI_UINPUT_H_
-#define __LAPI_UINPUT_H_
-
-#include <linux/uinput.h>
-
-#ifndef UI_GET_SYSNAME
-#define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
-#endif
-
-#endif /* __LAPI_UINPUT_H_ */
diff --git a/include/tst_uinput.h b/include/tst_uinput.h
index dddbd9921..47e36cd7f 100644
--- a/include/tst_uinput.h
+++ b/include/tst_uinput.h
@@ -20,6 +20,14 @@ int open_uinput(void);
  */
 void create_input_device(int fd);
 
+/**
+ * Parses /proc/bus/input/devices and returns the sysfs strings for our
+ * virtual device, which is the path of input devices.
+ *
+ * Returns newly allocated string, or NULL in a case of failure.
+ */
+char *get_input_sysfs(void);
+
 /**
  * Parses /proc/bus/input/devices and returns the handlers strings for our
  * virtual device, which is list of input devices that receive events from the
diff --git a/libs/libltpuinput/tst_uinput.c b/libs/libltpuinput/tst_uinput.c
index 4b22fef2a..a2691030b 100644
--- a/libs/libltpuinput/tst_uinput.c
+++ b/libs/libltpuinput/tst_uinput.c
@@ -42,8 +42,21 @@ int open_uinput(void)
 	return -1;
 }
 
+
+#define SYSFS_PREFIX "Sysfs="
 #define HANDLERS_PREFIX "Handlers="
 
+static char *parse_sysfs(char *line)
+{
+	char *sysfs;
+
+	sysfs = strstr(line, SYSFS_PREFIX) + sizeof(SYSFS_PREFIX) - 1;
+
+	sysfs[strlen(sysfs) - 1] = 0;
+
+	return strdup(sysfs);
+}
+
 static char *parse_handlers(char *line)
 {
 	char *handlers;
@@ -55,6 +68,33 @@ static char *parse_handlers(char *line)
 	return strdup(handlers);
 }
 
+char *get_input_sysfs(void)
+{
+	FILE *file;
+	char line[1024];
+	int flag = 0;
+
+	file = fopen("/proc/bus/input/devices", "r");
+	if (!file)
+		return NULL;
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "N: Name=\""VIRTUAL_DEVICE"\""))
+			flag = 1;
+
+		if (flag) {
+			if (line[0] == 'S')
+				return parse_sysfs(line);
+
+			if (line[0] == '\n')
+				flag = 0;
+		}
+	}
+
+	fclose(file);
+	return NULL;
+}
+
 char *get_input_handlers(void)
 {
 	FILE *file;
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index f6769849e..f87160b7f 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -15,11 +15,10 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include <sys/sysmacros.h>
-
+#include <linux/uinput.h>
 #include "tst_test.h"
 #include "tst_uinput.h"
 #include "uevent.h"
-#include "lapi/uinput.h"
 
 static int mouse_fd;
 
@@ -52,8 +51,7 @@ static void get_minor_major(char *device, char *minor, char *major, size_t buf_s
 
 static void verify_uevent(void)
 {
-	int pid, fd, ret;
-	char sysname[64];
+	int pid, fd;
 	char add_msg[1024];
 	char rem_msg[1024];
 	char dev_path[1024];
@@ -71,8 +69,7 @@ static void verify_uevent(void)
 	char major_event1[MINOR_MAJOR_SIZE];
 	char major_event2[MINOR_MAJOR_SIZE];
 
-	char *handlers, *handler1, *handler2;
-
+	char *handlers, *handler1, *handler2, *sysname;
 	struct uevent_desc add = {
 		.msg = add_msg,
 		.value_cnt = 7,
@@ -167,20 +164,12 @@ static void verify_uevent(void)
 
 	create_uinput_mouse();
 
-	ret = ioctl(mouse_fd, UI_GET_SYSNAME(sizeof(sysname)), sysname);
-	if (ret < 0) {
-		if (errno == EINVAL) {
-			tst_brk(TCONF,
-				"kernel does not support UI_GET_SYSNAME");
-		} else {
-			tst_brk(TBROK,
-				"ioctl(%d, %s,...) failed",
-				mouse_fd, "UI_GET_SYSNAME");
-		}
-	}
-
+	sysname = get_input_sysfs();
 	handlers = get_input_handlers();
 
+	if (!sysname)
+		tst_brk(TBROK, "Expected /devices/virtual/input/inputN sysname!");
+
 	tst_res(TINFO, "Sysname: %s", sysname);
 	tst_res(TINFO, "Handlers: %s", handlers);
 
@@ -198,41 +187,38 @@ static void verify_uevent(void)
 
 	destroy_uinput_mouse();
 
-	snprintf(add_msg, sizeof(add_msg),
-	         "add@/devices/virtual/input/%s", sysname);
-
-	snprintf(rem_msg, sizeof(rem_msg),
-	         "remove@/devices/virtual/input/%s", sysname);
+	snprintf(add_msg, sizeof(add_msg), "add@%s", sysname);
 
-	snprintf(dev_path, sizeof(dev_path),
-	         "DEVPATH=/devices/virtual/input/%s", sysname);
+	snprintf(rem_msg, sizeof(rem_msg), "remove@%s", sysname);
 
+	snprintf(dev_path, sizeof(dev_path), "DEVPATH=%s", sysname);
 
 	snprintf(add_msg_event1, sizeof(add_msg_event1),
-	         "add@/devices/virtual/input/%s/%s", sysname, handler1);
+		"add@%s/%s", sysname, handler1);
 
 	snprintf(rem_msg_event1, sizeof(rem_msg_event1),
-	         "remove@/devices/virtual/input/%s/%s", sysname, handler1);
+		"remove@%s/%s", sysname, handler1);
 
 	snprintf(dev_path_event1, sizeof(dev_path_event1),
-	         "DEVPATH=/devices/virtual/input/%s/%s", sysname, handler1);
+		"DEVPATH=%s/%s", sysname, handler1);
 
 	snprintf(dev_name1, sizeof(dev_name1),
-	         "DEVNAME=input/%s", handler1);
+		"DEVNAME=input/%s", handler1);
 
 
 	snprintf(add_msg_event2, sizeof(add_msg_event2),
-	         "add@/devices/virtual/input/%s/%s", sysname, handler2);
+		"add@%s/%s", sysname, handler2);
 
 	snprintf(rem_msg_event2, sizeof(rem_msg_event2),
-	         "remove@/devices/virtual/input/%s/%s", sysname, handler2);
+		"remove@%s/%s", sysname, handler2);
 
 	snprintf(dev_path_event2, sizeof(dev_path_event2),
-	         "DEVPATH=/devices/virtual/input/%s/%s", sysname, handler2);
+		"DEVPATH=%s/%s", sysname, handler2);
 
 	snprintf(dev_name2, sizeof(dev_name2),
-	         "DEVNAME=input/%s", handler2);
+		"DEVNAME=input/%s", handler2);
 
+	free(sysname);
 	free(handlers);
 
 	pid = SAFE_FORK();
-- 
2.18.1



