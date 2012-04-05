Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFamW-00056f-9C
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:42:32 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFamV-0005FQ-9A
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:42:32 +0000
Received: by dadz9 with SMTP id z9so1046004dad.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 17:42:25 -0700 (PDT)
Date: Wed, 4 Apr 2012 17:38:31 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="967339439-513108690-1333586313=:25027"
Subject: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
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

--967339439-513108690-1333586313=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Clean up inotify(7) wrappers

As a side-effect this also fixes the return code passed back
by the wrappers as the value should be an integer, not longs
[this fixes compile errors on platforms where
sizeof(int) != sizeof(long)].

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  testcases/kernel/syscalls/inotify/inotify.h   |   45 +++++++++++++++++++++++++
  testcases/kernel/syscalls/inotify/inotify01.c |   16 +--------
  testcases/kernel/syscalls/inotify/inotify02.c |   16 +--------
  testcases/kernel/syscalls/inotify/inotify03.c |   16 +--------
  4 files changed, 48 insertions(+), 45 deletions(-)
  create mode 100644 testcases/kernel/syscalls/inotify/inotify.h


--------------1.7.2.5
Content-Type: text/x-patch; name="0001-Clean-up-inotify-7-wrappers.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Clean-up-inotify-7-wrappers.patch"

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
new file mode 100644
index 0000000..ab7f812
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -0,0 +1,45 @@
+/*
+ * inotify testcase common definitions.
+ *
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
+#ifndef	_INOTIFY_H
+#define	_INOTIFY_H
+
+/* inotify(7) wrappers */
+
+/*
+ * ``junk`` is needed to make the macro function like a void argument
+ * function.
+ */
+#define	myinotify_init(junk)	syscall(__NR_inotify_init)
+
+#define	myinotify_add_watch(fd, pathname, mask)	\
+	syscall(__NR_inotify_add_watch, fd, pathname, mask)
+
+#define	myinotify_rm_watch(fd, wd) \
+	syscall(__NR_inotify_rm_watch, fd, wd)
+
+#endif /* _INOTIFY_H */
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 4168c0e..8205f82 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -50,6 +50,7 @@
  #include "test.h"
  #include "usctest.h"
  #include "linux_syscall_numbers.h"
+#include "inotify.h"

  #if defined(HAVE_SYS_INOTIFY_H)
  #include <sys/inotify.h>
@@ -76,21 +77,6 @@ int event_set[EVENT_MAX];

  char event_buf[EVENT_BUF_LEN];

-static long myinotify_init()
-{
-	return syscall(__NR_inotify_init);
-}
-
-static long myinotify_add_watch(int fd, const char *pathname, int mask)
-{
-	return syscall(__NR_inotify_add_watch, fd, pathname, mask);
-}
-
-static long myinotify_rm_watch(int fd, int wd)
-{
-	return syscall(__NR_inotify_rm_watch, fd, wd);
-}
-
  int main(int ac, char **av)
  {
  	int lc;			/* loop counter */
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 4ffc00c..59f83ba 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -54,6 +54,7 @@
  #include "test.h"
  #include "usctest.h"
  #include "linux_syscall_numbers.h"
+#include "inotify.h"

  #if defined(HAVE_SYS_INOTIFY_H)
  #include <sys/inotify.h>
@@ -92,21 +93,6 @@ struct event_t event_set[EVENT_MAX];

  char event_buf[EVENT_BUF_LEN];

-static long myinotify_init()
-{
-	return syscall(__NR_inotify_init);
-}
-
-static long myinotify_add_watch(int fd, const char *pathname, int mask)
-{
-	return syscall(__NR_inotify_add_watch, fd, pathname, mask);
-}
-
-static long myinotify_rm_watch(int fd, int wd)
-{
-	return syscall(__NR_inotify_rm_watch, fd, wd);
-}
-
  int main(int ac, char **av)
  {
  	int lc;			/* loop counter */
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index d3c3e7b..d8caa83 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -49,6 +49,7 @@
  #include "test.h"
  #include "usctest.h"
  #include "linux_syscall_numbers.h"
+#include "inotify.h"

  #if defined(HAVE_SYS_INOTIFY_H)
  #include <sys/inotify.h>
@@ -76,21 +77,6 @@ int event_set[EVENT_MAX];

  char event_buf[EVENT_BUF_LEN];

-static long myinotify_init()
-{
-	return syscall(__NR_inotify_init);
-}
-
-static long myinotify_add_watch(int fd, const char *pathname, int mask)
-{
-	return syscall(__NR_inotify_add_watch, fd, pathname, mask);
-}
-
-static long myinotify_rm_watch(int fd, int wd)
-{
-	return syscall(__NR_inotify_rm_watch, fd, wd);
-}
-
  #define DEFAULT_FSTYPE	"ext2"
  #define DIR_MODE	S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP

--967339439-513108690-1333586313=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0001-Clean-up-inotify-7-wrappers.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204041738310.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0001-Clean-up-inotify-7-wrappers.patch

RnJvbSBiZjQ5YjVhODNlNTU0ODI5MjJkZDRjOTI4MDMzYTY0NzBhODAwMjhi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFdlZCwgNCBBcHIgMjAx
MiAxMjo1MjowNyAtMDcwMA0KU3ViamVjdDogW1BBVENIIDEvMl0gQ2xlYW4g
dXAgaW5vdGlmeSg3KSB3cmFwcGVycw0KTUlNRS1WZXJzaW9uOiAxLjANCkNv
bnRlbnQtVHlwZTogbXVsdGlwYXJ0L21peGVkOyBib3VuZGFyeT0iLS0tLS0t
LS0tLS0tMS43LjIuNSINCg0KVGhpcyBpcyBhIG11bHRpLXBhcnQgbWVzc2Fn
ZSBpbiBNSU1FIGZvcm1hdC4NCi0tLS0tLS0tLS0tLS0tMS43LjIuNQ0KQ29u
dGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04OyBmb3JtYXQ9
Zml4ZWQNCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCg0KDQpB
cyBhIHNpZGUtZWZmZWN0IHRoaXMgYWxzbyBmaXhlcyB0aGUgcmV0dXJuIGNv
ZGUgcGFzc2VkIGJhY2sNCmJ5IHRoZSB3cmFwcGVycyBhcyB0aGUgdmFsdWUg
c2hvdWxkIGJlIGFuIGludGVnZXIsIG5vdCBsb25ncw0KW3RoaXMgZml4ZXMg
Y29tcGlsZSBlcnJvcnMgb24gcGxhdGZvcm1zIHdoZXJlDQpzaXplb2YoaW50
KSAhPSBzaXplb2YobG9uZyldLg0KDQpTaWduZWQtb2ZmLWJ5OiBHYXJyZXR0
IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPg0KLS0tDQogdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkuaCAgIHwgICA0NSAr
KysrKysrKysrKysrKysrKysrKysrKysrDQogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9pbm90aWZ5L2lub3RpZnkwMS5jIHwgICAxNiArLS0tLS0tLS0N
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lub3RpZnkvaW5vdGlmeTAy
LmMgfCAgIDE2ICstLS0tLS0tLQ0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW5vdGlmeS9pbm90aWZ5MDMuYyB8ICAgMTYgKy0tLS0tLS0tDQogNCBm
aWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA0NSBkZWxldGlvbnMo
LSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9pbm90aWZ5L2lub3RpZnkuaA0KDQoNCi0tLS0tLS0tLS0tLS0tMS43
LjIuNQ0KQ29udGVudC1UeXBlOiB0ZXh0L3gtcGF0Y2g7IG5hbWU9IjAwMDEt
Q2xlYW4tdXAtaW5vdGlmeS03LXdyYXBwZXJzLnBhdGNoIg0KQ29udGVudC1U
cmFuc2Zlci1FbmNvZGluZzogOGJpdA0KQ29udGVudC1EaXNwb3NpdGlvbjog
YXR0YWNobWVudDsgZmlsZW5hbWU9IjAwMDEtQ2xlYW4tdXAtaW5vdGlmeS03
LXdyYXBwZXJzLnBhdGNoIg0KDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkuaCBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5LmgNCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5hYjdmODEyDQotLS0gL2Rldi9u
dWxsDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lub3RpZnkv
aW5vdGlmeS5oDQpAQCAtMCwwICsxLDQ1IEBADQorLyoNCisgKiBpbm90aWZ5
IHRlc3RjYXNlIGNvbW1vbiBkZWZpbml0aW9ucy4NCisgKg0KKyAqIENvcHly
aWdodCAoYykgMjAxMiBMaW51eCBUZXN0IFByb2plY3QuICBBbGwgUmlnaHRz
IFJlc2VydmVkLg0KKyAqDQorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQNCisgKiB1bmRlciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcw0KKyAqIHB1Ymxpc2hlZCBi
eSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KKyAqDQorICogVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d291bGQgYmUgdXNlZnVsLCBidXQNCisgKiBXSVRIT1VUIEFOWSBXQVJSQU5U
WTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQorICog
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQ
VVJQT1NFLg0KKyAqDQorICogRnVydGhlciwgdGhpcyBzb2Z0d2FyZSBpcyBk
aXN0cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50eSB0aGF0IGl0IGlzDQor
ICogZnJlZSBvZiB0aGUgcmlnaHRmdWwgY2xhaW0gb2YgYW55IHRoaXJkIHBl
cnNvbiByZWdhcmRpbmcgaW5mcmluZ2VtZW50DQorICogb3IgdGhlIGxpa2Uu
ICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4sIHdoZXRoZXIgaW1wbGll
ZCBvcg0KKyAqIG90aGVyd2lzZSwgYXBwbGllcyBvbmx5IHRvIHRoaXMgc29m
dHdhcmUgZmlsZS4gIFBhdGVudCBsaWNlbnNlcywgaWYNCisgKiBhbnksIHBy
b3ZpZGVkIGhlcmVpbiBkbyBub3QgYXBwbHkgdG8gY29tYmluYXRpb25zIG9m
IHRoaXMgcHJvZ3JhbSB3aXRoDQorICogb3RoZXIgc29mdHdhcmUsIG9yIGFu
eSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuDQorICoNCisgKiBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBhbG9uZw0KKyAqIHdpdGggdGhpcyBwcm9ncmFtOyBp
ZiBub3QsIHdyaXRlIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIElu
Yy4sIDU5DQorICogVGVtcGxlIFBsYWNlIC0gU3VpdGUgMzMwLCBCb3N0b24g
TUEgMDIxMTEtMTMwNywgVVNBLg0KKyAqDQorICogR2FycmV0dCBDb29wZXIs
IEFwcmlsIDIwMTINCisgKi8NCisNCisjaWZuZGVmCV9JTk9USUZZX0gNCisj
ZGVmaW5lCV9JTk9USUZZX0gNCisNCisvKiBpbm90aWZ5KDcpIHdyYXBwZXJz
ICovDQorDQorLyoNCisgKiBgYGp1bmtgYCBpcyBuZWVkZWQgdG8gbWFrZSB0
aGUgbWFjcm8gZnVuY3Rpb24gbGlrZSBhIHZvaWQgYXJndW1lbnQNCisgKiBm
dW5jdGlvbi4NCisgKi8NCisjZGVmaW5lCW15aW5vdGlmeV9pbml0KGp1bmsp
CXN5c2NhbGwoX19OUl9pbm90aWZ5X2luaXQpDQorDQorI2RlZmluZQlteWlu
b3RpZnlfYWRkX3dhdGNoKGZkLCBwYXRobmFtZSwgbWFzaykJXA0KKwlzeXNj
YWxsKF9fTlJfaW5vdGlmeV9hZGRfd2F0Y2gsIGZkLCBwYXRobmFtZSwgbWFz
aykNCisNCisjZGVmaW5lCW15aW5vdGlmeV9ybV93YXRjaChmZCwgd2QpIFwN
CisJc3lzY2FsbChfX05SX2lub3RpZnlfcm1fd2F0Y2gsIGZkLCB3ZCkNCisN
CisjZW5kaWYgLyogX0lOT1RJRllfSCAqLw0KZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5MDEuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5MDEuYw0K
aW5kZXggNDE2OGMwZS4uODIwNWY4MiAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5MDEuYw0KKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3RpZnkwMS5j
DQpAQCAtNTAsNiArNTAsNyBAQA0KICNpbmNsdWRlICJ0ZXN0LmgiDQogI2lu
Y2x1ZGUgInVzY3Rlc3QuaCINCiAjaW5jbHVkZSAibGludXhfc3lzY2FsbF9u
dW1iZXJzLmgiDQorI2luY2x1ZGUgImlub3RpZnkuaCINCiANCiAjaWYgZGVm
aW5lZChIQVZFX1NZU19JTk9USUZZX0gpDQogI2luY2x1ZGUgPHN5cy9pbm90
aWZ5Lmg+DQpAQCAtNzYsMjEgKzc3LDYgQEAgaW50IGV2ZW50X3NldFtFVkVO
VF9NQVhdOw0KIA0KIGNoYXIgZXZlbnRfYnVmW0VWRU5UX0JVRl9MRU5dOw0K
IA0KLXN0YXRpYyBsb25nIG15aW5vdGlmeV9pbml0KCkNCi17DQotCXJldHVy
biBzeXNjYWxsKF9fTlJfaW5vdGlmeV9pbml0KTsNCi19DQotDQotc3RhdGlj
IGxvbmcgbXlpbm90aWZ5X2FkZF93YXRjaChpbnQgZmQsIGNvbnN0IGNoYXIg
KnBhdGhuYW1lLCBpbnQgbWFzaykNCi17DQotCXJldHVybiBzeXNjYWxsKF9f
TlJfaW5vdGlmeV9hZGRfd2F0Y2gsIGZkLCBwYXRobmFtZSwgbWFzayk7DQot
fQ0KLQ0KLXN0YXRpYyBsb25nIG15aW5vdGlmeV9ybV93YXRjaChpbnQgZmQs
IGludCB3ZCkNCi17DQotCXJldHVybiBzeXNjYWxsKF9fTlJfaW5vdGlmeV9y
bV93YXRjaCwgZmQsIHdkKTsNCi19DQotDQogaW50IG1haW4oaW50IGFjLCBj
aGFyICoqYXYpDQogew0KIAlpbnQgbGM7CQkJLyogbG9vcCBjb3VudGVyICov
DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90
aWZ5L2lub3RpZnkwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
bm90aWZ5L2lub3RpZnkwMi5jDQppbmRleCA0ZmZjMDBjLi41OWY4M2JhIDEw
MDY0NA0KLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5
L2lub3RpZnkwMi5jDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2lub3RpZnkvaW5vdGlmeTAyLmMNCkBAIC01NCw2ICs1NCw3IEBADQogI2lu
Y2x1ZGUgInRlc3QuaCINCiAjaW5jbHVkZSAidXNjdGVzdC5oIg0KICNpbmNs
dWRlICJsaW51eF9zeXNjYWxsX251bWJlcnMuaCINCisjaW5jbHVkZSAiaW5v
dGlmeS5oIg0KIA0KICNpZiBkZWZpbmVkKEhBVkVfU1lTX0lOT1RJRllfSCkN
CiAjaW5jbHVkZSA8c3lzL2lub3RpZnkuaD4NCkBAIC05MiwyMSArOTMsNiBA
QCBzdHJ1Y3QgZXZlbnRfdCBldmVudF9zZXRbRVZFTlRfTUFYXTsNCiANCiBj
aGFyIGV2ZW50X2J1ZltFVkVOVF9CVUZfTEVOXTsNCiANCi1zdGF0aWMgbG9u
ZyBteWlub3RpZnlfaW5pdCgpDQotew0KLQlyZXR1cm4gc3lzY2FsbChfX05S
X2lub3RpZnlfaW5pdCk7DQotfQ0KLQ0KLXN0YXRpYyBsb25nIG15aW5vdGlm
eV9hZGRfd2F0Y2goaW50IGZkLCBjb25zdCBjaGFyICpwYXRobmFtZSwgaW50
IG1hc2spDQotew0KLQlyZXR1cm4gc3lzY2FsbChfX05SX2lub3RpZnlfYWRk
X3dhdGNoLCBmZCwgcGF0aG5hbWUsIG1hc2spOw0KLX0NCi0NCi1zdGF0aWMg
bG9uZyBteWlub3RpZnlfcm1fd2F0Y2goaW50IGZkLCBpbnQgd2QpDQotew0K
LQlyZXR1cm4gc3lzY2FsbChfX05SX2lub3RpZnlfcm1fd2F0Y2gsIGZkLCB3
ZCk7DQotfQ0KLQ0KIGludCBtYWluKGludCBhYywgY2hhciAqKmF2KQ0KIHsN
CiAJaW50IGxjOwkJCS8qIGxvb3AgY291bnRlciAqLw0KZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5MDMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5
MDMuYw0KaW5kZXggZDNjM2U3Yi4uZDhjYWE4MyAxMDA2NDQNCi0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5vdGlmeS9pbm90aWZ5MDMuYw0K
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbm90aWZ5L2lub3Rp
ZnkwMy5jDQpAQCAtNDksNiArNDksNyBAQA0KICNpbmNsdWRlICJ0ZXN0Lmgi
DQogI2luY2x1ZGUgInVzY3Rlc3QuaCINCiAjaW5jbHVkZSAibGludXhfc3lz
Y2FsbF9udW1iZXJzLmgiDQorI2luY2x1ZGUgImlub3RpZnkuaCINCiANCiAj
aWYgZGVmaW5lZChIQVZFX1NZU19JTk9USUZZX0gpDQogI2luY2x1ZGUgPHN5
cy9pbm90aWZ5Lmg+DQpAQCAtNzYsMjEgKzc3LDYgQEAgaW50IGV2ZW50X3Nl
dFtFVkVOVF9NQVhdOw0KIA0KIGNoYXIgZXZlbnRfYnVmW0VWRU5UX0JVRl9M
RU5dOw0KIA0KLXN0YXRpYyBsb25nIG15aW5vdGlmeV9pbml0KCkNCi17DQot
CXJldHVybiBzeXNjYWxsKF9fTlJfaW5vdGlmeV9pbml0KTsNCi19DQotDQot
c3RhdGljIGxvbmcgbXlpbm90aWZ5X2FkZF93YXRjaChpbnQgZmQsIGNvbnN0
IGNoYXIgKnBhdGhuYW1lLCBpbnQgbWFzaykNCi17DQotCXJldHVybiBzeXNj
YWxsKF9fTlJfaW5vdGlmeV9hZGRfd2F0Y2gsIGZkLCBwYXRobmFtZSwgbWFz
ayk7DQotfQ0KLQ0KLXN0YXRpYyBsb25nIG15aW5vdGlmeV9ybV93YXRjaChp
bnQgZmQsIGludCB3ZCkNCi17DQotCXJldHVybiBzeXNjYWxsKF9fTlJfaW5v
dGlmeV9ybV93YXRjaCwgZmQsIHdkKTsNCi19DQotDQogI2RlZmluZSBERUZB
VUxUX0ZTVFlQRQkiZXh0MiINCiAjZGVmaW5lIERJUl9NT0RFCVNfSVJXWFUg
fCBTX0lSVVNSIHwgU19JWFVTUiB8IFNfSVJHUlAgfCBTX0lYR1JQDQogDQoN
Ci0tLS0tLS0tLS0tLS0tMS43LjIuNS0tDQoNCg0K

--967339439-513108690-1333586313=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-513108690-1333586313=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-513108690-1333586313=:25027--

