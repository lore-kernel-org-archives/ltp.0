From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 6 Sep 2019 13:15:20 +0800
Subject: [LTP] [PATCH v2] uevent03: Use a generic way to get sysname
In-Reply-To: <1567676787-3050-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1567676787-3050-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1567746920-3356-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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

-------------
V1->V2:
  make code non-redundant
-------------
---
 include/lapi/uinput.h               | 16 ---------
 include/tst_uinput.h                | 11 +++---
 libs/libltpuinput/tst_uinput.c      | 29 +++++++++++-----
 testcases/kernel/uevents/uevent03.c | 52 +++++++++++------------------
 4 files changed, 44 insertions(+), 64 deletions(-)
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
index dddbd9921..cf351cdfb 100644
--- a/include/tst_uinput.h
+++ b/include/tst_uinput.h
@@ -21,14 +21,13 @@ int open_uinput(void);
 void create_input_device(int fd);
 
 /**
- * Parses /proc/bus/input/devices and returns the handlers strings for our
- * virtual device, which is list of input devices that receive events from the
- * device separated by whitestpaces.
+ * Parses /proc/bus/input/devices and returns the strings for our virtual device.
+ * If passing 'H' to it, it returns HANDLERS string. If passing 'S' to it, it
+ * returns SYSFS string.
  *
- * Returns newly allocated string, list of handlers separated by whitespaces,
- * or NULL in a case of failure.
+ * Returns newly allocated string, or NULL in a case of failure.
  */
-char *get_input_handlers(void);
+char *get_input_field_value(char field);
 
 /**
  * Sets up the virtual device to appear as a mouse, this must be called before
diff --git a/libs/libltpuinput/tst_uinput.c b/libs/libltpuinput/tst_uinput.c
index 4b22fef2a..f4eee07b8 100644
--- a/libs/libltpuinput/tst_uinput.c
+++ b/libs/libltpuinput/tst_uinput.c
@@ -42,20 +42,31 @@ int open_uinput(void)
 	return -1;
 }
 
+
+#define SYSFS_PREFIX "Sysfs="
 #define HANDLERS_PREFIX "Handlers="
 
-static char *parse_handlers(char *line)
+static char *parse_field(char *line, char field)
 {
-	char *handlers;
-
-	handlers = strstr(line, HANDLERS_PREFIX) + sizeof(HANDLERS_PREFIX) - 1;
+	char *value;
+
+	switch (field) {
+	case 'H':
+		value = strstr(line, HANDLERS_PREFIX) + sizeof(HANDLERS_PREFIX) - 1;
+		break;
+	case 'S':
+		value = strstr(line, SYSFS_PREFIX) + sizeof(SYSFS_PREFIX) - 1;
+		break;
+	default:
+		return NULL;
+	}
 
-	handlers[strlen(handlers) - 1] = 0;
+	value[strlen(value) - 1] = 0;
 
-	return strdup(handlers);
+	return strdup(value);
 }
 
-char *get_input_handlers(void)
+char *get_input_field_value(char field)
 {
 	FILE *file;
 	char line[1024];
@@ -70,8 +81,8 @@ char *get_input_handlers(void)
 			flag = 1;
 
 		if (flag) {
-			if (line[0] == 'H')
-				return parse_handlers(line);
+			if (line[0] == field)
+				return parse_field(line, field);
 
 			if (line[0] == '\n')
 				flag = 0;
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index f6769849e..6eda86067 100644
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
@@ -167,19 +164,11 @@ static void verify_uevent(void)
 
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
+	sysname = get_input_field_value('S');
+	handlers = get_input_field_value('H');
 
-	handlers = get_input_handlers();
+	if (!sysname)
+		tst_brk(TBROK, "Expected /devices/virtual/input/inputN sysname!");
 
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



