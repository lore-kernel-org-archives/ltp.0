Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F750D78301
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 996FB3DD283
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:14:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0F83DD275
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E88B763F3BA
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 882FD1F749
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQR/dioxjDi9ZeOBsCZvrT1XcZODqUF11Mui5X4Uqp0=;
 b=IObOwtzn2RNtP873WXYcldn6xWyB5Bw5Z+Sq8X8VxUVLjEh9FmMQWdQMFLJEsyJABxmh2V
 31fZz9dG/jJsLargaSv/hI0HSZoWAvuYBvBRKhEtPC+3TsZWOsrwfE2T2cxS7kCOe4Yhog
 QW9Pqc9lR5CMeuNvhX+zoCROwBnM33E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQR/dioxjDi9ZeOBsCZvrT1XcZODqUF11Mui5X4Uqp0=;
 b=2kFKl9YWrRwblQ2LCFmzl6nxfFXS7ZhMgCqd6Det9nLHvN6JFL34Qw/QwLwolYploelfD7
 B/m89Yc8nbu8OCCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQR/dioxjDi9ZeOBsCZvrT1XcZODqUF11Mui5X4Uqp0=;
 b=IObOwtzn2RNtP873WXYcldn6xWyB5Bw5Z+Sq8X8VxUVLjEh9FmMQWdQMFLJEsyJABxmh2V
 31fZz9dG/jJsLargaSv/hI0HSZoWAvuYBvBRKhEtPC+3TsZWOsrwfE2T2cxS7kCOe4Yhog
 QW9Pqc9lR5CMeuNvhX+zoCROwBnM33E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQR/dioxjDi9ZeOBsCZvrT1XcZODqUF11Mui5X4Uqp0=;
 b=2kFKl9YWrRwblQ2LCFmzl6nxfFXS7ZhMgCqd6Det9nLHvN6JFL34Qw/QwLwolYploelfD7
 B/m89Yc8nbu8OCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7301B13A40
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 10:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wGNdGiOITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 02 Dec 2024 10:12:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:51 +0100
MIME-Version: 1.0
Message-Id: <20241202-input_refactoring-v2-7-369609492896@suse.com>
References: <20241202-input_refactoring-v2-0-369609492896@suse.com>
In-Reply-To: <20241202-input_refactoring-v2-0-369609492896@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=9319;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=AbFZiAYaBhWRb6Pojk+RFtsGkfnrAtFnuhk3KJTElSE=;
 b=UJ6zto6opOBqeqWFYyKu2jfNI/SBsIGzhWe9Ele9R1MG0VyXUzuaUzWsaY9QiQvB1Ta0FXjAq
 WSgDQxJG1bIBWn2aFa9HB344cu2n/V1COsu7RbpOsDCG3D6hXg2ACK/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
Subject: [LTP] [PATCH v2 7/7] Delete depreacted input test suite helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/input/input_helper.c | 313 ----------------------------------
 testcases/kernel/input/input_helper.h |  36 ----
 2 files changed, 349 deletions(-)

diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
deleted file mode 100644
index c929de6bab64df49cd48ac6c73b44d26e8f04e96..0000000000000000000000000000000000000000
--- a/testcases/kernel/input/input_helper.c
+++ /dev/null
@@ -1,313 +0,0 @@
-/*
- * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/input.h>
-#include <linux/uinput.h>
-#include <fnmatch.h>
-#include <errno.h>
-#include <poll.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "input_helper.h"
-#include "lapi/uinput.h"
-
-#define VIRTUAL_DEVICE "virtual-device-ltp"
-
-#define VIRTUAL_DEVICE_REGEX "*virtual-device-ltp*"
-
-static int uinput_loaded;
-static int check_device(void);
-
-static int try_open_device(void)
-{
-	char path[256];
-	char name[256];
-	int ret, fd = -1;
-	unsigned int i;
-
-	for (i = 0; i < 100; i++) {
-		snprintf(path, sizeof(path), "/dev/input/event%i", i);
-
-		fd = open(path, O_RDONLY);
-
-		if (fd < 0 && errno == ENOENT)
-			continue;
-
-		if (fd < 0) {
-			tst_resm(TINFO | TERRNO, "failed to open %s", path);
-			break;
-		}
-
-		ret = ioctl(fd, EVIOCGNAME(sizeof(name)), name);
-		if (ret < 0) {
-			tst_resm(TINFO | TERRNO,
-				"ioctl(%s, EVIOCGNAME(256), ...) failed",
-				path);
-			break;
-		}
-
-		if (strcmp(name, VIRTUAL_DEVICE) == 0)
-			return fd;
-		close(fd);
-	}
-
-	return -1;
-}
-
-int open_device(void)
-{
-	int fd;
-	int retries = 10;
-
-	while (retries--) {
-		fd = try_open_device();
-		if (fd > 0)
-			return fd;
-		tst_resm(TINFO, "Device not found, retrying...");
-		usleep(10000);
-	}
-
-	tst_brkm(TBROK, NULL, "Unable to find the input device");
-}
-
-static int try_load_uinput(void)
-{
-	const char *argv[] = {"modprobe", "uinput", NULL};
-	int ret;
-
-	tst_resm(TINFO, "Trying to load uinput kernel module");
-
-	ret = tst_cmd(NULL, argv, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (ret) {
-		tst_resm(TINFO, "Failed to load the uinput module");
-		return 0;
-	}
-
-	return 1;
-}
-
-static void unload_uinput(void)
-{
-	const char *argv[] = {"modprobe", "-r", "uinput", NULL};
-	int ret;
-
-	tst_resm(TINFO, "Unloading uinput kernel module");
-
-	ret = tst_cmd(NULL, argv, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (ret)
-		tst_resm(TWARN, "Failed to unload uinput module");
-}
-
-static const char *uinput_paths[] = {
-	"/dev/input/uinput",
-	"/dev/uinput",
-};
-
-static int try_open_uinput(void)
-{
-	unsigned int i;
-	int fd;
-
-	for (i = 0; i < ARRAY_SIZE(uinput_paths); i++) {
-		fd = open(uinput_paths[i], O_WRONLY | O_NONBLOCK);
-
-		if (fd > 0) {
-			tst_resm(TINFO, "Found uinput dev at %s",
-			         uinput_paths[i]);
-			return fd;
-		}
-
-		if (fd < 0 && errno != ENOENT) {
-			tst_brkm(TBROK | TERRNO, NULL,
-			         "open(%s)", uinput_paths[i]);
-		}
-	}
-
-	return -1;
-}
-
-int open_uinput(void)
-{
-	int fd;
-	int retries = 10;
-
-	fd = try_open_uinput();
-	if (fd > 0)
-		return fd;
-
-	if (try_load_uinput()) {
-		while (retries--) {
-			fd = try_open_uinput();
-			if (fd > 0) {
-				uinput_loaded = 1;
-				return fd;
-			}
-			tst_resm(TINFO, "Uinput dev not found, retrying...");
-			usleep(10000);
-		}
-
-		unload_uinput();
-	}
-
-	tst_brkm(TCONF, NULL, "Unable to find and open uinput");
-}
-
-void send_event(int fd, int event, int code, int value)
-{
-	struct input_event ev = {
-		.type = event,
-		.code = code,
-		.value = value,
-	};
-
-	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, &ev, sizeof(ev));
-}
-
-void send_rel_move(int fd, int x, int y)
-{
-	send_event(fd, EV_REL, REL_X, x);
-	send_event(fd, EV_REL, REL_Y, y);
-	send_event(fd, EV_SYN, 0, 0);
-}
-
-static void check_ui_get_sysname_ioctl(int fd)
-{
-	char sys_name[256];
-	char dev_name[256];
-	char *path;
-
-	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
-	SAFE_ASPRINTF(NULL, &path, "/sys/devices/virtual/input/%s/name", sys_name);
-
-	if (FILE_SCANF(path, "%s", dev_name)) {
-		tst_resm(TFAIL|TERRNO, "Failed to read '%s'", path);
-		free(path);
-		return;
-	}
-
-	if (!strcmp(VIRTUAL_DEVICE, dev_name))
-		tst_resm(TPASS, "ioctl UI_GET_SYSNAME returned correct name");
-	else
-		tst_resm(TFAIL, "ioctl UI_GET_SYSNAME returned wrong name");
-
-	free(path);
-}
-
-void create_device(int fd)
-{
-	int nb;
-	struct uinput_user_dev uidev = {
-		.name = VIRTUAL_DEVICE,
-		.id = {
-			.bustype = BUS_USB,
-			.vendor = 0x1,
-			.product = 0x1,
-			.version = 1,
-		}
-	};
-
-	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, &uidev, sizeof(uidev));
-	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
-
-	for (nb = 100; nb > 0; nb--) {
-		if (check_device()) {
-			check_ui_get_sysname_ioctl(fd);
-			return;
-		}
-		usleep(10000);
-	}
-
-	destroy_device(fd);
-	tst_brkm(TBROK, NULL, "Failed to create device");
-}
-
-void setup_mouse_events(int fd)
-{
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
-	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, BTN_LEFT);
-	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_REL);
-	SAFE_IOCTL(NULL, fd, UI_SET_RELBIT, REL_X);
-	SAFE_IOCTL(NULL, fd, UI_SET_RELBIT, REL_Y);
-}
-
-void destroy_device(int fd)
-{
-	SAFE_IOCTL(NULL, fd, UI_DEV_DESTROY, NULL);
-	SAFE_CLOSE(NULL, fd);
-
-	if (uinput_loaded)
-		unload_uinput();
-}
-
-int check_event_code(struct input_event *iev, int event, int code)
-{
-	return iev->type == event && iev->code == code;
-}
-
-int check_sync_event(struct input_event *iev)
-{
-	return check_event_code(iev, EV_SYN, SYN_REPORT);
-}
-
-/*
- * the value of stray_sync_event:
- * 0: EV_SYN/SYN_REPORT events should not be received in /dev/input/eventX
- * 1: EV_SYN/SYN_REPORT events may be received in /dev/input/eventX
- * On an old kernel(before v3.7.0), EV_SYN/SYN_REPORT events are always
- * received even though we send empty moves.
- */
-int no_events_queued(int fd, int stray_sync_event)
-{
-	struct pollfd fds = {.fd = fd, .events = POLLIN};
-	int ret, res;
-	struct input_event ev;
-
-	ret = poll(&fds, 1, 30);
-
-	if (ret > 0) {
-		res = read(fd, &ev, sizeof(ev));
-
-		if (res == sizeof(ev)) {
-			tst_resm(TINFO,
-				"Unexpected ev type=%i code=%i value=%i",
-				ev.type, ev.code, ev.value);
-		}
-	}
-
-	return ret == 0;
-}
-
-static int check_device(void)
-{
-	FILE *file;
-	char line[256];
-
-	file = fopen("/proc/bus/input/devices", "r");
-	if (!file)
-		return 0;
-
-	while (fgets(line, 256, file)) {
-		if (fnmatch(VIRTUAL_DEVICE_REGEX, line, 0) == 0)
-			return 1;
-	}
-
-	fclose(file);
-
-	return 0;
-}
diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
deleted file mode 100644
index 7f61be1e9a4a647ff0887aa14a89a48bd2e882a9..0000000000000000000000000000000000000000
--- a/testcases/kernel/input/input_helper.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef INPUT_HELPER_H
-#define INPUT_HELPER_H
-
-#include <sys/types.h>
-#include <dirent.h>
-
-int open_device(void);
-void send_rel_move(int fd, int x, int y);
-void send_event(int fd, int event, int code, int value);
-int open_uinput(void);
-void create_device(int fd);
-void setup_mouse_events(int fd);
-void destroy_device(int fd);
-int check_event_code(struct input_event *iev, int event, int code);
-int check_sync_event(struct input_event *iev);
-int no_events_queued(int fd, int stray_sync_event);
-
-#endif /* INPUT_HELPER_H */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
