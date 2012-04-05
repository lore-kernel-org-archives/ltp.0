Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFbc3-0002v8-9G
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:35:47 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFbc2-0005cq-3A
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:35:47 +0000
Received: by dadz9 with SMTP id z9so1101253dad.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 18:35:40 -0700 (PDT)
Date: Wed, 4 Apr 2012 18:31:46 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204041743120.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="967339439-310651799-1333589507=:25027"
Subject: [LTP] [PATCH] Add a functional test for the IN_DELETE_SELF event
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--967339439-310651799-1333589507=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Add a functional test for the IN_DELETE_SELF event

This tests that IN_DELETE_SELF functions for both files and directories by 
creating a temporary file and directory, ensuring the inotify(7) events 
are relayed properly, watchpoints are removed, etc.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  testcases/kernel/syscalls/inotify/inotify04.c |  276 +++++++++++++++++++++++++
  1 files changed, 276 insertions(+), 0 deletions(-)
  create mode 100644 testcases/kernel/syscalls/inotify/inotify04.c


diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
new file mode 100644
index 0000000..69a8d21
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -0,0 +1,273 @@
+/*
+ * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Garrett Cooper, April 2012
+ */
+
+/****************************************************************************
+ * NAME
+ *     inotify04
+ *
+ * DESCRIPTION
+ *     verify that IN_DELETE_SELF functions as expected
+ *
+ * ALGORITHM
+ *     Create a temporary directory, then add watches to a predefined file and
+ *     directory, and delete the file and directory to ensure that the
+ *     IN_DELETE_SELF event is captured properly.
+ *
+ *     Because of how the inotify(7) API is designed, we also need to catch the
+ *     IN_ATTRIB and IN_IGNORED events.
+ *
+ * HISTORY
+ *
+ * ***************************************************************************/
+
+#include "config.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+#endif
+#include <errno.h>
+#include <string.h>
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "inotify.h"
+#include "safe_macros.h"
+
+char *TCID = "inotify04";
+
+#if defined(HAVE_SYS_INOTIFY_H)
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof(struct inotify_event))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))
+
+int TST_TOTAL = 4;
+
+#define BUF_SIZE 256
+
+struct event_t {
+	char name[BUF_SIZE];
+	int mask;
+	size_t len;
+};
+
+#define	TEST_DIR	"test_dir"
+#define	TEST_FILE	"test_file"
+
+struct event_t event_set[EVENT_MAX];
+
+char event_buf[EVENT_BUF_LEN];
+
+int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;
+
+static void cleanup(void)
+{
+
+	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
+		tst_resm(TWARN,
+		    "inotify_rm_watch(%d, %d) [1] failed", fd_notify, wd_dir);
+
+	if (reap_wd_file && myinotify_rm_watch(fd_notify, wd_file) == -1)
+		tst_resm(TWARN,
+		    "inotify_rm_watch(%d, %d) [2] failed", fd_notify, wd_file);
+
+	if (close(fd_notify) == -1)
+		tst_resm(TWARN, "close(%d) [1] failed", fd_notify);
+
+	if (close(wd_dir) == -1)
+		tst_resm(TWARN, "close(%d) [2] failed", wd_dir);
+
+	if (close(wd_file) == -1)
+		tst_resm(TWARN, "close(%d) [3] failed", wd_file);
+
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	fd_notify = myinotify_init();
+	if (fd_notify == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "inotify_init() failed");
+
+	SAFE_MKDIR(cleanup, TEST_DIR, 00700);
+
+	close(SAFE_CREAT(cleanup, TEST_FILE, 00600));
+
+	wd_dir = myinotify_add_watch(fd_notify, TEST_DIR, IN_ALL_EVENTS);
+	if (wd_dir == -1) {
+		tst_brkm(TBROK|TERRNO, cleanup,
+		    "inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [1] failed",
+		    fd_notify, TEST_DIR);
+	}
+	reap_wd_dir = 1;
+
+	wd_file = myinotify_add_watch(fd_notify, TEST_FILE, IN_ALL_EVENTS);
+	if (wd_file == -1)
+		tst_brkm(TBROK|TERRNO, cleanup,
+		    "inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [2] failed",
+		    fd_notify, TEST_FILE);
+	reap_wd_file = 1;
+}
+
+int
+main(int argc, char **argv)
+{
+	char *msg;
+	size_t len;
+	int i, test_num;
+
+	i = 0;
+	test_num = 0;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	Tst_count = 0;
+
+	rmdir(TEST_DIR);
+	event_set[Tst_count].mask = IN_DELETE_SELF;
+	strcpy(event_set[Tst_count].name, "");
+	Tst_count++;
+	event_set[Tst_count].mask = IN_IGNORED;
+	strcpy(event_set[Tst_count].name, "");
+	Tst_count++;
+
+	unlink(TEST_FILE);
+	/*
+	 * When a file is unlinked, the link count is reduced by 1, and when it
+	 * hits 0 the file is removed.
+	 *
+	 * This isn't well documented in inotify(7), but it's intuitive if you
+	 * understand how Unix works.
+	 */
+	if (0 <= tst_kvercmp(2, 6, 25)) {
+		event_set[Tst_count].mask = IN_ATTRIB;
+		strcpy(event_set[Tst_count].name, "");
+		Tst_count++;
+		TST_TOTAL++;
+	}
+	event_set[Tst_count].mask = IN_DELETE_SELF;
+	strcpy(event_set[Tst_count].name, TEST_FILE);
+	Tst_count++;
+	event_set[Tst_count].mask = IN_IGNORED;
+	strcpy(event_set[Tst_count].name, "");
+	Tst_count++;
+
+	if (Tst_count != TST_TOTAL)
+		tst_brkm(TBROK, cleanup,
+			 "Tst_count and TST_TOTAL are not equal");
+
+	Tst_count = 0;
+
+	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
+	if (len == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read failed");
+
+	reap_wd_dir = 0;
+	reap_wd_file = 0;
+
+	while (i < len) {
+		struct inotify_event *event;
+		event = (struct inotify_event *)&event_buf[i];
+		if (test_num >= TST_TOTAL) {
+			if (tst_kvercmp(2, 6, 25) < 0
+			    && event_set[TST_TOTAL - 1].mask ==
+			    event->mask)
+				tst_resm(TWARN,
+					 "This may be kernel bug. "
+					 "Before kernel 2.6.25, a kernel bug "
+					 "meant that the kernel code that was "
+					 "intended to coalesce successive identical "
+					 "events (i.e., the two most recent "
+					 "events could potentially be coalesced "
+					 "if the older had not yet been read) "
+					 "instead checked if the most recent event "
+					 "could be coalesced with the oldest "
+					 "unread event. This has been fixed by commit"
+					 "1c17d18e3775485bf1e0ce79575eb637a94494a2.");
+			tst_resm(TFAIL,
+				 "got unnecessary event: "
+				 "wd=%d mask=%x cookie=%u len=%u "
+				 "name=\"%s\"", event->wd, event->mask,
+				 event->cookie, event->len,
+				 event->name);
+
+		} else if ((event_set[test_num].mask == event->mask)
+			   &&
+			   (!strncmp
+			    (event_set[test_num].name, event->name,
+			     event->len))) {
+			tst_resm(TPASS,
+				 "got event: wd=%d mask=%x "
+				 "cookie=%u len=%u name=\"%s\"",
+				 event->wd, event->mask, event->cookie,
+				 event->len, event->name);
+
+		} else {
+			tst_resm(TFAIL, "got event: wd=%d mask=%x "
+				 "(expected %x) cookie=%u len=%u "
+				 "name=\"%s\" (expected \"%s\") %d",
+				 event->wd, event->mask,
+				 event_set[test_num].mask,
+				 event->cookie, event->len, event->name,
+				 event_set[test_num].name,
+				 strcmp(event_set[test_num].name,
+					event->name));
+		}
+		test_num++;
+		i += EVENT_SIZE + event->len;
+	}
+
+	for (; test_num < TST_TOTAL; test_num++) {
+		tst_resm(TFAIL, "didn't get event: mask=%x ",
+			 event_set[test_num].mask);
+	}
+
+	cleanup();
+	tst_exit();
+}
+#else
+
+int TST_TOTAL;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
+}
+#endif /* defined(HAVE_SYS_INOTIFY_H) */

--967339439-310651799-1333589507=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0001-Add-a-functional-test-for-the-IN_DELETE_SELF-event.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204041831460.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0001-Add-a-functional-test-for-the-IN_DELETE_SELF-event.patch

RnJvbSBmMWRkNTA1NTA1YWM1ZTZmNjUzZWNjNzhiZDQ4MzcyOGJiNzZlZmJh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFdlZCwgNCBBcHIgMjAx
MiAxODoyNjozNCAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBBZGQgYSBmdW5j
dGlvbmFsIHRlc3QgZm9yIHRoZSBJTl9ERUxFVEVfU0VMRiBldmVudA0KTUlN
RS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L21peGVk
OyBib3VuZGFyeT0iLS0tLS0tLS0tLS0tMS43LjIuNSINCg0KVGhpcyBpcyBh
IG11bHRpLXBhcnQgbWVzc2FnZSBpbiBNSU1FIGZvcm1hdC4NCi0tLS0tLS0t
LS0tLS0tMS43LjIuNQ0KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFy
c2V0PVVURi04OyBmb3JtYXQ9Zml4ZWQNCkNvbnRlbnQtVHJhbnNmZXItRW5j
b2Rpbmc6IDhiaXQNCg0KDQpTaWduZWQtb2ZmLWJ5OiBHYXJyZXR0IENvb3Bl
ciA8eWFuZWdvbWlAZ21haWwuY29tPg0KLS0tDQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkwNC5jIHwgIDI3NiArKysrKysr
KysrKysrKysrKysrKysrKysrDQogMSBmaWxlcyBjaGFuZ2VkLCAyNzYgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkw
NC5jDQoNCg0KLS0tLS0tLS0tLS0tLS0xLjcuMi41DQpDb250ZW50LVR5cGU6
IHRleHQveC1wYXRjaDsgbmFtZT0iMDAwMS1BZGQtYS1mdW5jdGlvbmFsLXRl
c3QtZm9yLXRoZS1JTl9ERUxFVEVfU0VMRi1ldmVudC5wYXRjaCINCkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCkNvbnRlbnQtRGlzcG9zaXRp
b246IGF0dGFjaG1lbnQ7IGZpbGVuYW1lPSIwMDAxLUFkZC1hLWZ1bmN0aW9u
YWwtdGVzdC1mb3ItdGhlLUlOX0RFTEVURV9TRUxGLWV2ZW50LnBhdGNoIg0K
DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90
aWZ5L2lub3RpZnkwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
bm90aWZ5L2lub3RpZnkwNC5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5k
ZXggMDAwMDAwMC4uNjlhOGQyMQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkwNC5jDQpA
QCAtMCwwICsxLDI3MyBAQA0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDEy
IExpbnV4IFRlc3QgUHJvamVjdC4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQor
ICoNCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeSBpdA0KKyAqIHVuZGVy
IHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzDQorICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24uDQorICoNCisgKiBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2Vm
dWwsIGJ1dA0KKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2
ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCisgKiBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuDQorICoN
CisgKiBGdXJ0aGVyLCB0aGlzIHNvZnR3YXJlIGlzIGRpc3RyaWJ1dGVkIHdp
dGhvdXQgYW55IHdhcnJhbnR5IHRoYXQgaXQgaXMNCisgKiBmcmVlIG9mIHRo
ZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGlu
ZyBpbmZyaW5nZW1lbnQNCisgKiBvciB0aGUgbGlrZS4gIEFueSBsaWNlbnNl
IHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlciBpbXBsaWVkIG9yDQorICogb3Ro
ZXJ3aXNlLCBhcHBsaWVzIG9ubHkgdG8gdGhpcyBzb2Z0d2FyZSBmaWxlLiAg
UGF0ZW50IGxpY2Vuc2VzLCBpZg0KKyAqIGFueSwgcHJvdmlkZWQgaGVyZWlu
IGRvIG5vdCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YgdGhpcyBwcm9ncmFt
IHdpdGgNCisgKiBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90aGVyIHByb2R1
Y3Qgd2hhdHNvZXZlci4NCisgKg0KKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFsb25nDQorICogd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwgNTkNCisgKiBU
ZW1wbGUgUGxhY2UgLSBTdWl0ZSAzMzAsIEJvc3RvbiBNQSAwMjExMS0xMzA3
LCBVU0EuDQorICoNCisgKiBHYXJyZXR0IENvb3BlciwgQXByaWwgMjAxMg0K
KyAqLw0KKw0KKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQor
ICogTkFNRQ0KKyAqICAgICBpbm90aWZ5MDQNCisgKg0KKyAqIERFU0NSSVBU
SU9ODQorICogICAgIHZlcmlmeSB0aGF0IElOX0RFTEVURV9TRUxGIGZ1bmN0
aW9ucyBhcyBleHBlY3RlZA0KKyAqDQorICogQUxHT1JJVEhNDQorICogICAg
IENyZWF0ZSBhIHRlbXBvcmFyeSBkaXJlY3RvcnksIHRoZW4gYWRkIHdhdGNo
ZXMgdG8gYSBwcmVkZWZpbmVkIGZpbGUgYW5kDQorICogICAgIGRpcmVjdG9y
eSwgYW5kIGRlbGV0ZSB0aGUgZmlsZSBhbmQgZGlyZWN0b3J5IHRvIGVuc3Vy
ZSB0aGF0IHRoZQ0KKyAqICAgICBJTl9ERUxFVEVfU0VMRiBldmVudCBpcyBj
YXB0dXJlZCBwcm9wZXJseS4NCisgKg0KKyAqICAgICBCZWNhdXNlIG9mIGhv
dyB0aGUgaW5vdGlmeSg3KSBBUEkgaXMgZGVzaWduZWQsIHdlIGFsc28gbmVl
ZCB0byBjYXRjaCB0aGUNCisgKiAgICAgSU5fQVRUUklCIGFuZCBJTl9JR05P
UkVEIGV2ZW50cy4NCisgKg0KKyAqIEhJU1RPUlkNCisgKg0KKyAqICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKi8NCisNCisjaW5jbHVkZSAiY29u
ZmlnLmgiDQorDQorI2lmIGRlZmluZWQoSEFWRV9TWVNfSU5PVElGWV9IKQ0K
KyNpbmNsdWRlIDxzeXMvaW5vdGlmeS5oPg0KKyNlbmRpZg0KKyNpbmNsdWRl
IDxlcnJuby5oPg0KKyNpbmNsdWRlIDxzdHJpbmcuaD4NCisjaW5jbHVkZSAi
dGVzdC5oIg0KKyNpbmNsdWRlICJ1c2N0ZXN0LmgiDQorI2luY2x1ZGUgImxp
bnV4X3N5c2NhbGxfbnVtYmVycy5oIg0KKyNpbmNsdWRlICJpbm90aWZ5Lmgi
DQorI2luY2x1ZGUgInNhZmVfbWFjcm9zLmgiDQorDQorY2hhciAqVENJRCA9
ICJpbm90aWZ5MDQiOw0KKw0KKyNpZiBkZWZpbmVkKEhBVkVfU1lTX0lOT1RJ
RllfSCkNCisNCisjZGVmaW5lIEVWRU5UX01BWCAxMDI0DQorLyogc2l6ZSBv
ZiB0aGUgZXZlbnQgc3RydWN0dXJlLCBub3QgY291bnRpbmcgbmFtZSAqLw0K
KyNkZWZpbmUgRVZFTlRfU0laRSAgKHNpemVvZihzdHJ1Y3QgaW5vdGlmeV9l
dmVudCkpDQorLyogcmVhc29uYWJsZSBndWVzcyBhcyB0byBzaXplIG9mIDEw
MjQgZXZlbnRzICovDQorI2RlZmluZSBFVkVOVF9CVUZfTEVOICAgICAgICAo
RVZFTlRfTUFYICogKEVWRU5UX1NJWkUgKyAxNikpDQorDQoraW50IFRTVF9U
T1RBTCA9IDQ7DQorDQorI2RlZmluZSBCVUZfU0laRSAyNTYNCisNCitzdHJ1
Y3QgZXZlbnRfdCB7DQorCWNoYXIgbmFtZVtCVUZfU0laRV07DQorCWludCBt
YXNrOw0KKwlzaXplX3QgbGVuOw0KK307DQorDQorI2RlZmluZQlURVNUX0RJ
UgkidGVzdF9kaXIiDQorI2RlZmluZQlURVNUX0ZJTEUJInRlc3RfZmlsZSIN
CisNCitzdHJ1Y3QgZXZlbnRfdCBldmVudF9zZXRbRVZFTlRfTUFYXTsNCisN
CitjaGFyIGV2ZW50X2J1ZltFVkVOVF9CVUZfTEVOXTsNCisNCitpbnQgZmRf
bm90aWZ5LCByZWFwX3dkX2ZpbGUsIHJlYXBfd2RfZGlyLCB3ZF9kaXIsIHdk
X2ZpbGU7DQorDQorc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQ0KK3sNCisN
CisJaWYgKHJlYXBfd2RfZGlyICYmIG15aW5vdGlmeV9ybV93YXRjaChmZF9u
b3RpZnksIHdkX2RpcikgPT0gLTEpDQorCQl0c3RfcmVzbShUV0FSTiwNCisJ
CSAgICAiaW5vdGlmeV9ybV93YXRjaCglZCwgJWQpIFsxXSBmYWlsZWQiLCBm
ZF9ub3RpZnksIHdkX2Rpcik7DQorDQorCWlmIChyZWFwX3dkX2ZpbGUgJiYg
bXlpbm90aWZ5X3JtX3dhdGNoKGZkX25vdGlmeSwgd2RfZmlsZSkgPT0gLTEp
DQorCQl0c3RfcmVzbShUV0FSTiwNCisJCSAgICAiaW5vdGlmeV9ybV93YXRj
aCglZCwgJWQpIFsyXSBmYWlsZWQiLCBmZF9ub3RpZnksIHdkX2ZpbGUpOw0K
Kw0KKwlpZiAoY2xvc2UoZmRfbm90aWZ5KSA9PSAtMSkNCisJCXRzdF9yZXNt
KFRXQVJOLCAiY2xvc2UoJWQpIFsxXSBmYWlsZWQiLCBmZF9ub3RpZnkpOw0K
Kw0KKwlpZiAoY2xvc2Uod2RfZGlyKSA9PSAtMSkNCisJCXRzdF9yZXNtKFRX
QVJOLCAiY2xvc2UoJWQpIFsyXSBmYWlsZWQiLCB3ZF9kaXIpOw0KKw0KKwlp
ZiAoY2xvc2Uod2RfZmlsZSkgPT0gLTEpDQorCQl0c3RfcmVzbShUV0FSTiwg
ImNsb3NlKCVkKSBbM10gZmFpbGVkIiwgd2RfZmlsZSk7DQorDQorCVRFU1Rf
Q0xFQU5VUDsNCisNCisJdHN0X3JtZGlyKCk7DQorfQ0KKw0KK3N0YXRpYyB2
b2lkIHNldHVwKHZvaWQpDQorew0KKw0KKwl0c3Rfc2lnKE5PRk9SSywgREVG
X0hBTkRMRVIsIGNsZWFudXApOw0KKw0KKwlURVNUX1BBVVNFOw0KKw0KKwl0
c3RfdG1wZGlyKCk7DQorDQorCWZkX25vdGlmeSA9IG15aW5vdGlmeV9pbml0
KCk7DQorCWlmIChmZF9ub3RpZnkgPT0gLTEpDQorCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJpbm90aWZ5X2luaXQoKSBmYWlsZWQiKTsN
CisNCisJU0FGRV9NS0RJUihjbGVhbnVwLCBURVNUX0RJUiwgMDA3MDApOw0K
Kw0KKwljbG9zZShTQUZFX0NSRUFUKGNsZWFudXAsIFRFU1RfRklMRSwgMDA2
MDApKTsNCisNCisJd2RfZGlyID0gbXlpbm90aWZ5X2FkZF93YXRjaChmZF9u
b3RpZnksIFRFU1RfRElSLCBJTl9BTExfRVZFTlRTKTsNCisJaWYgKHdkX2Rp
ciA9PSAtMSkgew0KKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVw
LA0KKwkJICAgICJpbm90aWZ5X2FkZF93YXRjaCglZCwgXCIlc1wiLCBJTl9B
TExfRVZFTlRTKSBbMV0gZmFpbGVkIiwNCisJCSAgICBmZF9ub3RpZnksIFRF
U1RfRElSKTsNCisJfQ0KKwlyZWFwX3dkX2RpciA9IDE7DQorDQorCXdkX2Zp
bGUgPSBteWlub3RpZnlfYWRkX3dhdGNoKGZkX25vdGlmeSwgVEVTVF9GSUxF
LCBJTl9BTExfRVZFTlRTKTsNCisJaWYgKHdkX2ZpbGUgPT0gLTEpDQorCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsDQorCQkgICAgImlub3Rp
ZnlfYWRkX3dhdGNoKCVkLCBcIiVzXCIsIElOX0FMTF9FVkVOVFMpIFsyXSBm
YWlsZWQiLA0KKwkJICAgIGZkX25vdGlmeSwgVEVTVF9GSUxFKTsNCisJcmVh
cF93ZF9maWxlID0gMTsNCit9DQorDQoraW50DQorbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpDQorew0KKwljaGFyICptc2c7DQorCXNpemVfdCBsZW47
DQorCWludCBpLCB0ZXN0X251bTsNCisNCisJaSA9IDA7DQorCXRlc3RfbnVt
ID0gMDsNCisNCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxM
LCBOVUxMKTsNCisJaWYgKG1zZyAhPSBOVUxMKQ0KKwkJdHN0X2Jya20oVEJS
T0ssIE5VTEwsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsN
CisNCisJc2V0dXAoKTsNCisNCisJVHN0X2NvdW50ID0gMDsNCisNCisJcm1k
aXIoVEVTVF9ESVIpOw0KKwlldmVudF9zZXRbVHN0X2NvdW50XS5tYXNrID0g
SU5fREVMRVRFX1NFTEY7DQorCXN0cmNweShldmVudF9zZXRbVHN0X2NvdW50
XS5uYW1lLCAiIik7DQorCVRzdF9jb3VudCsrOw0KKwlldmVudF9zZXRbVHN0
X2NvdW50XS5tYXNrID0gSU5fSUdOT1JFRDsNCisJc3RyY3B5KGV2ZW50X3Nl
dFtUc3RfY291bnRdLm5hbWUsICIiKTsNCisJVHN0X2NvdW50Kys7DQorDQor
CXVubGluayhURVNUX0ZJTEUpOw0KKwkvKg0KKwkgKiBXaGVuIGEgZmlsZSBp
cyB1bmxpbmtlZCwgdGhlIGxpbmsgY291bnQgaXMgcmVkdWNlZCBieSAxLCBh
bmQgd2hlbiBpdA0KKwkgKiBoaXRzIDAgdGhlIGZpbGUgaXMgcmVtb3ZlZC4N
CisJICoNCisJICogVGhpcyBpc24ndCB3ZWxsIGRvY3VtZW50ZWQgaW4gaW5v
dGlmeSg3KSwgYnV0IGl0J3MgaW50dWl0aXZlIGlmIHlvdQ0KKwkgKiB1bmRl
cnN0YW5kIGhvdyBVbml4IHdvcmtzLg0KKwkgKi8NCisJaWYgKDAgPD0gdHN0
X2t2ZXJjbXAoMiwgNiwgMjUpKSB7DQorCQlldmVudF9zZXRbVHN0X2NvdW50
XS5tYXNrID0gSU5fQVRUUklCOw0KKwkJc3RyY3B5KGV2ZW50X3NldFtUc3Rf
Y291bnRdLm5hbWUsICIiKTsNCisJCVRzdF9jb3VudCsrOw0KKwkJVFNUX1RP
VEFMKys7DQorCX0NCisJZXZlbnRfc2V0W1RzdF9jb3VudF0ubWFzayA9IElO
X0RFTEVURV9TRUxGOw0KKwlzdHJjcHkoZXZlbnRfc2V0W1RzdF9jb3VudF0u
bmFtZSwgVEVTVF9GSUxFKTsNCisJVHN0X2NvdW50Kys7DQorCWV2ZW50X3Nl
dFtUc3RfY291bnRdLm1hc2sgPSBJTl9JR05PUkVEOw0KKwlzdHJjcHkoZXZl
bnRfc2V0W1RzdF9jb3VudF0ubmFtZSwgIiIpOw0KKwlUc3RfY291bnQrKzsN
CisNCisJaWYgKFRzdF9jb3VudCAhPSBUU1RfVE9UQUwpDQorCQl0c3RfYnJr
bShUQlJPSywgY2xlYW51cCwNCisJCQkgIlRzdF9jb3VudCBhbmQgVFNUX1RP
VEFMIGFyZSBub3QgZXF1YWwiKTsNCisNCisJVHN0X2NvdW50ID0gMDsNCisN
CisJbGVuID0gcmVhZChmZF9ub3RpZnksIGV2ZW50X2J1ZiwgRVZFTlRfQlVG
X0xFTik7DQorCWlmIChsZW4gPT0gLTEpDQorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJyZWFkIGZhaWxlZCIpOw0KKw0KKwlyZWFwX3dk
X2RpciA9IDA7DQorCXJlYXBfd2RfZmlsZSA9IDA7DQorDQorCXdoaWxlIChp
IDwgbGVuKSB7DQorCQlzdHJ1Y3QgaW5vdGlmeV9ldmVudCAqZXZlbnQ7DQor
CQlldmVudCA9IChzdHJ1Y3QgaW5vdGlmeV9ldmVudCAqKSZldmVudF9idWZb
aV07DQorCQlpZiAodGVzdF9udW0gPj0gVFNUX1RPVEFMKSB7DQorCQkJaWYg
KHRzdF9rdmVyY21wKDIsIDYsIDI1KSA8IDANCisJCQkgICAgJiYgZXZlbnRf
c2V0W1RTVF9UT1RBTCAtIDFdLm1hc2sgPT0NCisJCQkgICAgZXZlbnQtPm1h
c2spDQorCQkJCXRzdF9yZXNtKFRXQVJOLA0KKwkJCQkJICJUaGlzIG1heSBi
ZSBrZXJuZWwgYnVnLiAiDQorCQkJCQkgIkJlZm9yZSBrZXJuZWwgMi42LjI1
LCBhIGtlcm5lbCBidWcgIg0KKwkJCQkJICJtZWFudCB0aGF0IHRoZSBrZXJu
ZWwgY29kZSB0aGF0IHdhcyAiDQorCQkJCQkgImludGVuZGVkIHRvIGNvYWxl
c2NlIHN1Y2Nlc3NpdmUgaWRlbnRpY2FsICINCisJCQkJCSAiZXZlbnRzIChp
LmUuLCB0aGUgdHdvIG1vc3QgcmVjZW50ICINCisJCQkJCSAiZXZlbnRzIGNv
dWxkIHBvdGVudGlhbGx5IGJlIGNvYWxlc2NlZCAiDQorCQkJCQkgImlmIHRo
ZSBvbGRlciBoYWQgbm90IHlldCBiZWVuIHJlYWQpICINCisJCQkJCSAiaW5z
dGVhZCBjaGVja2VkIGlmIHRoZSBtb3N0IHJlY2VudCBldmVudCAiDQorCQkJ
CQkgImNvdWxkIGJlIGNvYWxlc2NlZCB3aXRoIHRoZSBvbGRlc3QgIg0KKwkJ
CQkJICJ1bnJlYWQgZXZlbnQuIFRoaXMgaGFzIGJlZW4gZml4ZWQgYnkgY29t
bWl0Ig0KKwkJCQkJICIxYzE3ZDE4ZTM3NzU0ODViZjFlMGNlNzk1NzVlYjYz
N2E5NDQ5NGEyLiIpOw0KKwkJCXRzdF9yZXNtKFRGQUlMLA0KKwkJCQkgImdv
dCB1bm5lY2Vzc2FyeSBldmVudDogIg0KKwkJCQkgIndkPSVkIG1hc2s9JXgg
Y29va2llPSV1IGxlbj0ldSAiDQorCQkJCSAibmFtZT1cIiVzXCIiLCBldmVu
dC0+d2QsIGV2ZW50LT5tYXNrLA0KKwkJCQkgZXZlbnQtPmNvb2tpZSwgZXZl
bnQtPmxlbiwNCisJCQkJIGV2ZW50LT5uYW1lKTsNCisNCisJCX0gZWxzZSBp
ZiAoKGV2ZW50X3NldFt0ZXN0X251bV0ubWFzayA9PSBldmVudC0+bWFzaykN
CisJCQkgICAmJg0KKwkJCSAgICghc3RybmNtcA0KKwkJCSAgICAoZXZlbnRf
c2V0W3Rlc3RfbnVtXS5uYW1lLCBldmVudC0+bmFtZSwNCisJCQkgICAgIGV2
ZW50LT5sZW4pKSkgew0KKwkJCXRzdF9yZXNtKFRQQVNTLA0KKwkJCQkgImdv
dCBldmVudDogd2Q9JWQgbWFzaz0leCAiDQorCQkJCSAiY29va2llPSV1IGxl
bj0ldSBuYW1lPVwiJXNcIiIsDQorCQkJCSBldmVudC0+d2QsIGV2ZW50LT5t
YXNrLCBldmVudC0+Y29va2llLA0KKwkJCQkgZXZlbnQtPmxlbiwgZXZlbnQt
Pm5hbWUpOw0KKw0KKwkJfSBlbHNlIHsNCisJCQl0c3RfcmVzbShURkFJTCwg
ImdvdCBldmVudDogd2Q9JWQgbWFzaz0leCAiDQorCQkJCSAiKGV4cGVjdGVk
ICV4KSBjb29raWU9JXUgbGVuPSV1ICINCisJCQkJICJuYW1lPVwiJXNcIiAo
ZXhwZWN0ZWQgXCIlc1wiKSAlZCIsDQorCQkJCSBldmVudC0+d2QsIGV2ZW50
LT5tYXNrLA0KKwkJCQkgZXZlbnRfc2V0W3Rlc3RfbnVtXS5tYXNrLA0KKwkJ
CQkgZXZlbnQtPmNvb2tpZSwgZXZlbnQtPmxlbiwgZXZlbnQtPm5hbWUsDQor
CQkJCSBldmVudF9zZXRbdGVzdF9udW1dLm5hbWUsDQorCQkJCSBzdHJjbXAo
ZXZlbnRfc2V0W3Rlc3RfbnVtXS5uYW1lLA0KKwkJCQkJZXZlbnQtPm5hbWUp
KTsNCisJCX0NCisJCXRlc3RfbnVtKys7DQorCQlpICs9IEVWRU5UX1NJWkUg
KyBldmVudC0+bGVuOw0KKwl9DQorDQorCWZvciAoOyB0ZXN0X251bSA8IFRT
VF9UT1RBTDsgdGVzdF9udW0rKykgew0KKwkJdHN0X3Jlc20oVEZBSUwsICJk
aWRuJ3QgZ2V0IGV2ZW50OiBtYXNrPSV4ICIsDQorCQkJIGV2ZW50X3NldFt0
ZXN0X251bV0ubWFzayk7DQorCX0NCisNCisJY2xlYW51cCgpOw0KKwl0c3Rf
ZXhpdCgpOw0KK30NCisjZWxzZQ0KKw0KK2ludCBUU1RfVE9UQUw7DQorDQor
aW50IG1haW4odm9pZCkNCit7DQorCXRzdF9icmttKFRDT05GLCBOVUxMLCAi
c3lzdGVtIGRvZXNuJ3QgaGF2ZSByZXF1aXJlZCBpbm90aWZ5IHN1cHBvcnQi
KTsNCit9DQorI2VuZGlmIC8qIGRlZmluZWQoSEFWRV9TWVNfSU5PVElGWV9I
KSAqLw0KDQotLS0tLS0tLS0tLS0tLTEuNy4yLjUtLQ0KDQoNCg==

--967339439-310651799-1333589507=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-310651799-1333589507=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-310651799-1333589507=:25027--

