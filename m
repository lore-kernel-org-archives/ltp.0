Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nm127@freemail.hu>) id 1MBiP1-0001Nb-BD
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 04:48:39 +0000
Received: from mail01a.mail.t-online.hu ([84.2.40.6])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MBiOy-0002z5-Pg
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2009 04:48:39 +0000
Message-ID: <4A260018.6060706@freemail.hu>
Date: Wed, 03 Jun 2009 06:46:16 +0200
From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090401060601040901070407"
Subject: [LTP] [PATCH] v4l-test 0.15 for LTP
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090401060601040901070407
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

this is the v4l-test 0.15 patch for LTP.

Changes:
Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS
and VIDIOC_TRY_EXT_CTRLS

Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>

Regards,

	M=E1rton N=E9meth

---
v4l-test project home page: http://v4l-test.sourceforge.net/

--------------090401060601040901070407
Content-Type: text/x-diff;
 name="v4l-test-0.15_for_ltp.patch"
Content-Disposition: inline;
 filename="v4l-test-0.15_for_ltp.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/in=
dex.html ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l	2009-06-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.html	200=
9-05-25 08:08:17.000000000 +0200
@@ -95,7 +95,7 @@ a USB video device or ask the user if a=20
 not.
 </p>
 <p>
-The following table gives an overview about the current state of
+The following tables give an overview about the current state of
 implemented test cases.</p>
=20
 <table border=3D"1" cellpadding=3D"2"
@@ -235,17 +235,17 @@ implemented test cases.</p>
     </tr>
     <tr>
       <td>ioctl <a href=3D"spec/r10386.htm">VIDIOC_G_EXT_CTRLS</a></td>
-      <td>no</td>
+      <td>yes, only when STREAM_OFF, currently only zero and one item</t=
d>
       <td>Opt.</td>
     </tr>
     <tr>
       <td>ioctl <a href=3D"spec/r10386.htm">VIDIOC_S_EXT_CTRLS</a></td>
-      <td>no</td>
+      <td>yes, only when STREAM_OFF, only with zero item</td>
       <td>Opt.</td>
     </tr>
     <tr>
       <td>ioctl <a href=3D"spec/r10386.htm">VIDIOC_TRY_EXT_CTRLS</a></td=
>
-      <td>no</td>
+      <td>yes, only when STREAM_OFF, only with zero item</td>
       <td>Opt.</td>
     </tr>
     <tr>
@@ -474,6 +474,46 @@ Enum.: enumeration, will return EINVAL f
 Exp.: experimental, may change in future
 </p>
=20
+<p>The following actions are not part of the V4L2 API but they might hav=
e
+influence on the V4L2 API functions:</p>
+
+<table border=3D"1" cellpadding=3D"2"
+ cellspacing=3D"0">
+  <thead>
+    <tr>
+      <td><b>Action</b></td>
+      <td><b>Covered?</b></td>
+    </tr>
+  </thead>
+  <tbody>
+    <tr>
+      <td>Load kernel module</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>Unload kernel module</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>USB connect event (in case of USB webcams)</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>USB disconnect event (in case of USB webcams)</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>Suspend</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>Resume</td>
+      <td>no</td>
+    </tr>
+  </tbody>
+</table>
+
+
 <h2><a name=3D"others">Similar projects</a></h2>
 <p>
 There migth be similar projects which also tries to test the V4L2 API.
@@ -520,7 +560,7 @@ The following documents and articles are
 <p>Any feedbacks, comments, ideas, etc. are welcome at the author's emai=
l address.</p>
 <hr style=3D"width: 100%; height: 2px;">
 <p>Last changed:
-Thu May  7 22:51:07 CEST 2009
+Mon May 25 08:08:11 CEST 2009
 </p>
 <p>
   <a href=3D"http://validator.w3.org/check?uri=3Dreferer"><img
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/re=
sults.html ltp/testcases/kernel/device-drivers/v4l/user_space/doc/results=
.html
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/results.h=
tml	2009-06-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/doc/results.html	2=
009-05-25 07:39:12.000000000 +0200
@@ -55,6 +55,12 @@ project or during developing it.
 	</li>
=20
 	<li>
+	<a href=3D"http://bugzilla.kernel.org/show_bug.cgi?id=3D13357">
+	Bug 13357 -  uvcvideo: VIDIOC_G_EXT_CTRLS does not handle NULL pointer =
correctly
+	</a>
+	</li>
+
+	<li>
 	<a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D124103154820106&a=
mp;w=3D2">
 	[PATCH] v4l2: modify return value of VIDIOC_REQBUFS ioctl
 	</a>
@@ -94,7 +100,7 @@ the following problems were identified w
=20
 <hr style=3D"width: 100%; height: 2px;">
 <p>Last changed:
-Wed Apr 29 21:21:38 CEST 2009
+Mon May 25 07:38:56 CEST 2009
 </p>
 <p>
   <a href=3D"http://validator.w3.org/check?uri=3Dreferer"><img
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefi=
le ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009=
-06-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009-05-1=
9 21:32:10.000000000 +0200
@@ -1,6 +1,7 @@
 #
 # v4l-test: Test environment for Video For Linux Two API
 #
+# 19 May 2009  0.17 test_VIDIOC_EXT_CTRLS.c added
 #  7 May 2009  0.16 v4l2_show.c added
 #  5 May 2009  0.15 test_VIDIOC_QUERYBUF.c added
 # 25 Apr 2009  0.14 test_VIDIOC_REQBUFS.c added
@@ -61,6 +62,7 @@ OBJS =3D dev_video.o \
        test_VIDIOC_AUDIO.o \
        test_VIDIOC_AUDOUT.o \
        test_VIDIOC_CTRL.o \
+       test_VIDIOC_EXT_CTRLS.o \
        test_VIDIOC_PARM.o \
        test_VIDIOC_FMT.o \
        test_VIDIOC_REQBUFS.o \
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README=
 ltp/testcases/kernel/device-drivers/v4l/user_space/README
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README	2009-0=
6-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/README	2009-05-25 =
08:02:06.000000000 +0200
@@ -3,6 +3,8 @@
=20
 Release History
 ---------------
+25 May 2009  0.15 Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_=
CTRLS
+                  and VIDIOC_TRY_EXT_CTRLS
  7 May 2009  0.14 Test cases added for VIDIOC_QUERYBUF;
                   Debug functions separated
 29 Apr 2009  0.13 Added string content validation;
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_CTRL.c ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDI=
OC_CTRL.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_C=
TRL.c	2009-06-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_CTRL.c=
	2009-05-24 19:45:47.000000000 +0200
@@ -31,7 +31,7 @@
=20
 #include "test_VIDIOC_CTRL.h"
=20
-int do_get_control(__u32 id) {
+static int do_get_control(__u32 id) {
 	int ret_query, errno_query;
 	int ret_get, errno_get;
 	struct v4l2_queryctrl queryctrl;
@@ -103,7 +103,7 @@ int do_get_control(__u32 id) {
 		case V4L2_CTRL_TYPE_CTRL_CLASS:
 		default:
 			CU_ASSERT_EQUAL(ret_get, -1);
-			CU_ASSERT_EQUAL(errno_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
 		}
 	} else {
 		CU_ASSERT_EQUAL(ret_query, -1);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_EXT_CTRLS.c ltp/testcases/kernel/device-drivers/v4l/user_space/test=
_VIDIOC_EXT_CTRLS.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_E=
XT_CTRLS.c	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_EXT_CT=
RLS.c	2009-05-24 22:46:42.000000000 +0200
@@ -0,0 +1,673 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 19 May 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+/*
+ * Note: V4L2_CID_LASTP1 !=3D V4L2_CID_BASE_LASTP1
+ */
+
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <string.h>
+
+#include <linux/videodev2.h>
+#include <linux/errno.h>
+
+#include <CUnit/CUnit.h>
+
+#include "v4l2_test.h"
+#include "dev_video.h"
+#include "video_limits.h"
+
+#include "test_VIDIOC_EXT_CTRLS.h"
+
+void test_VIDIOC_G_EXT_CTRLS_zero() {
+	struct v4l2_ext_controls controls;
+	int ret_get, errno_get;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls);
+	errno_get =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, ret_get=3D%i, errno_get=3D%i\n",
+		__FILE__, __LINE__, ret_get, errno_get);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+
+		CU_ASSERT_EQUAL(controls.ctrl_class, V4L2_CTRL_CLASS_USER);
+		CU_ASSERT_EQUAL(controls.count, 0);
+		// The value of controls.error_idx is not defined when ret_get =3D=3D =
0
+		CU_ASSERT_EQUAL(controls.reserved[0], 0);
+		CU_ASSERT_EQUAL(controls.reserved[1], 0);
+		CU_ASSERT_EQUAL(controls.controls, NULL);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+	}
+}
+
+void test_VIDIOC_G_EXT_CTRLS_zero_invalid_count() {
+	struct v4l2_ext_controls controls;
+	int ret_get, errno_get;
+	int ret_get_invalid, errno_get_invalid;
+	__u32 count;
+
+	count =3D 0;
+	memset(&controls, 0, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls);
+	errno_get =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, count=3D0%x, ret_get=3D%i, errno_=
get=3D%i\n",
+		__FILE__, __LINE__, count, ret_get, errno_get);
+
+	count =3D 1;
+	/* Note: this loop also covers ((__u32)S32_MAX)+1 =3D 0x80000000 */
+	do {
+		memset(&controls, 0xff, sizeof(controls));
+		controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+		controls.count =3D count;
+		controls.controls =3D NULL;
+
+		ret_get_invalid =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &control=
s);
+		errno_get_invalid =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, count=3D0x%x, ret_get_invalid=3D=
%i, errno_get_invalid=3D%i\n",
+			__FILE__, __LINE__, count, ret_get_invalid, errno_get_invalid);
+
+		if (ret_get =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_get, 0);
+
+			/* if the VIDIOC_G_EXT_CTRLS is supported by the driver
+			 * it shall complain about the NULL pointer at
+			 * cotrols.controls because this does not match the
+			 * controls.count value
+			 */
+			CU_ASSERT_EQUAL(ret_get_invalid, -1);
+			CU_ASSERT(errno_get_invalid =3D=3D EFAULT || errno_get_invalid =3D=3D=
 ENOMEM);
+
+		} else {
+			CU_ASSERT_EQUAL(ret_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
+
+			CU_ASSERT_EQUAL(ret_get_invalid, -1);
+			CU_ASSERT_EQUAL(errno_get_invalid, EINVAL);
+		}
+		count <<=3D 1;
+	} while (count !=3D 0);
+
+	count =3D (__u32)S32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_get_invalid =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls=
);
+	errno_get_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, count=3D0x%x, ret_get_invalid=3D%=
i, errno_get_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_get_invalid, errno_get_invalid);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+
+		CU_ASSERT_EQUAL(ret_get_invalid, -1);
+		CU_ASSERT(errno_get_invalid =3D=3D EFAULT || errno_get_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_get_invalid, -1);
+		CU_ASSERT_EQUAL(errno_get_invalid, EINVAL);
+	}
+
+	count =3D U32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_get_invalid =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls=
);
+	errno_get_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, count=3D0x%x, ret_get_invalid=3D%=
i, errno_get_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_get_invalid, errno_get_invalid);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+
+		CU_ASSERT_EQUAL(ret_get_invalid, -1);
+		CU_ASSERT(errno_get_invalid =3D=3D EFAULT || errno_get_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_get_invalid, -1);
+		CU_ASSERT_EQUAL(errno_get_invalid, EINVAL);
+	}
+
+}
+
+static int do_get_ext_control_one(__u32 ctrl_class, __u32 id) {
+	int ret_query, errno_query;
+	int ret_get, errno_get;
+	struct v4l2_queryctrl queryctrl;
+	struct v4l2_ext_controls controls;
+	struct v4l2_ext_control control;
+
+	/* The expected return value of VIDIOC_G_EXT_CTRLS depens on the value
+	 * reported by VIDIOC_QUERYCTRL
+	 */
+
+	memset(&queryctrl, 0, sizeof(queryctrl));
+	queryctrl.id =3D id;
+	ret_query =3D ioctl(get_video_fd(), VIDIOC_QUERYCTRL, &queryctrl);
+	errno_query =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_QUERYCTRL, id=3D%u (V4L2_CID_BASE+%i), ret_que=
ry=3D%i, errno_query=3D%i\n",
+		__FILE__, __LINE__, id, id-V4L2_CID_BASE, ret_query, errno_query);
+	if (ret_query =3D=3D 0) {
+		dprintf("\t%s:%u: queryctrl =3D {.id=3D%u, .type=3D%i, .name=3D\"%s\",=
 "
+		".minimum=3D%i, .maximum=3D%i, .step=3D%i, "
+		".default_value=3D%i, "
+		".flags=3D0x%X, "
+		".reserved[]=3D{ 0x%X, 0x%X } }\n",
+		__FILE__, __LINE__,
+		queryctrl.id,
+		queryctrl.type,
+		queryctrl.name,
+		queryctrl.minimum,
+		queryctrl.maximum,
+		queryctrl.step,
+		queryctrl.default_value,
+		queryctrl.flags,
+		queryctrl.reserved[0],
+		queryctrl.reserved[1]
+		);
+	}
+
+	memset(&control, 0xff, sizeof(control));
+	control.id =3D id;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D ctrl_class;
+	controls.count =3D 1;
+	controls.controls =3D &control;
+
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls);
+	errno_get =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, id=3D%u (V4L2_CID_BASE+%i), ret_g=
et=3D%i, errno_get=3D%i\n",
+		__FILE__, __LINE__,
+		id, id-V4L2_CID_BASE, ret_get, errno_get);
+
+	if (ret_query =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_query, 0);
+
+		switch (queryctrl.type) {
+		case V4L2_CTRL_TYPE_INTEGER:
+		case V4L2_CTRL_TYPE_BOOLEAN:
+		case V4L2_CTRL_TYPE_MENU:
+			if (ret_get =3D=3D 0) {
+				CU_ASSERT_EQUAL(ret_get, 0);
+
+				CU_ASSERT(queryctrl.minimum <=3D control.value);
+				CU_ASSERT(control.value <=3D queryctrl.maximum);
+			} else {
+				/* This is the case when VIDIOC_G_CTRLS is not
+				 * supported at all.
+				 */
+				CU_ASSERT_EQUAL(ret_get, -1);
+				CU_ASSERT_EQUAL(errno_get, EINVAL);
+			}
+			break;
+
+		case V4L2_CTRL_TYPE_BUTTON:
+			/* This control only performs an action, does not have
+			 * any value
+			 */
+			CU_ASSERT_EQUAL(ret_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
+			break;
+
+		case V4L2_CTRL_TYPE_INTEGER64: /* TODO: what about this case? */
+		case V4L2_CTRL_TYPE_CTRL_CLASS:
+		default:
+			CU_ASSERT_EQUAL(ret_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
+		}
+	} else {
+		CU_ASSERT_EQUAL(ret_query, -1);
+		CU_ASSERT_EQUAL(errno_query, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+
+	}
+
+	return ret_query;
+}
+
+void test_VIDIOC_G_EXT_CTRLS_one() {
+	int ret1;
+	__u32 i;
+
+	for (i =3D V4L2_CID_BASE; i < V4L2_CID_LASTP1; i++) {
+		ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, i);
+	}
+
+	ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, V4L2_CID_BASE-1);
+	ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, V4L2_CID_LASTP1);
+	ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, V4L2_CID_PRIVATE_=
BASE-1);
+
+	i =3D V4L2_CID_PRIVATE_BASE;
+	do {
+		ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, i);
+		i++;
+	} while (ret1 =3D=3D 0);
+
+	ret1 =3D do_get_ext_control_one(V4L2_CTRL_CLASS_USER, i);
+}
+
+void test_VIDIOC_G_EXT_CTRLS_NULL() {
+	struct v4l2_ext_controls controls;
+	int ret_get, errno_get;
+	int ret_null, errno_null;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, &controls);
+	errno_get =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, ret_get=3D%i, errno_get=3D%i\n",
+		__FILE__, __LINE__, ret_get, errno_get);
+
+	ret_null =3D ioctl(get_video_fd(), VIDIOC_G_EXT_CTRLS, NULL);
+	errno_null =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_G_EXT_CTRLS, ret_null=3D%i, errno_null=3D%i\n"=
,
+		__FILE__, __LINE__, ret_null, errno_null);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EINVAL);
+	}
+}
+
+void test_VIDIOC_S_EXT_CTRLS_zero() {
+	struct v4l2_ext_controls controls;
+	int ret_set, errno_set;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_set =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &controls);
+	errno_set =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, ret_set=3D%i, errno_set=3D%i\n",
+		__FILE__, __LINE__, ret_set, errno_set);
+
+	if (ret_set =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_set, 0);
+
+		CU_ASSERT_EQUAL(controls.ctrl_class, V4L2_CTRL_CLASS_USER);
+		CU_ASSERT_EQUAL(controls.count, 0);
+		// The value of controls.error_idx is not defined when ret_set =3D=3D =
0
+		CU_ASSERT_EQUAL(controls.reserved[0], 0);
+		CU_ASSERT_EQUAL(controls.reserved[1], 0);
+		CU_ASSERT_EQUAL(controls.controls, NULL);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_set, -1);
+		CU_ASSERT_EQUAL(errno_set, EINVAL);
+	}
+}
+
+void test_VIDIOC_S_EXT_CTRLS_zero_invalid_count() {
+	struct v4l2_ext_controls controls;
+	int ret_set, errno_set;
+	int ret_set_invalid, errno_set_invalid;
+	__u32 count;
+
+	count =3D 0;
+	memset(&controls, 0, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_set =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &controls);
+	errno_set =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, count=3D0%x, ret_set=3D%i, errno_=
set=3D%i\n",
+		__FILE__, __LINE__, count, ret_set, errno_set);
+
+	count =3D 1;
+	/* Note: this loop also covers ((__u32)S32_MAX)+1 =3D 0x80000000 */
+	do {
+		memset(&controls, 0xff, sizeof(controls));
+		controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+		controls.count =3D count;
+		controls.controls =3D NULL;
+
+		ret_set_invalid =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &control=
s);
+		errno_set_invalid =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, count=3D0x%x, ret_set_invalid=3D=
%i, errno_set_invalid=3D%i\n",
+			__FILE__, __LINE__, count, ret_set_invalid, errno_set_invalid);
+
+		if (ret_set =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_set, 0);
+
+			/* if the VIDIOC_S_EXT_CTRLS is supported by the driver
+			 * it shall complain about the NULL pointer at
+			 * cotrols.controls because this does not match the
+			 * controls.count value
+			 */
+			CU_ASSERT_EQUAL(ret_set_invalid, -1);
+			CU_ASSERT(errno_set_invalid =3D=3D EFAULT || errno_set_invalid =3D=3D=
 ENOMEM);
+
+		} else {
+			CU_ASSERT_EQUAL(ret_set, -1);
+			CU_ASSERT_EQUAL(errno_set, EINVAL);
+
+			CU_ASSERT_EQUAL(ret_set_invalid, -1);
+			CU_ASSERT_EQUAL(errno_set_invalid, EINVAL);
+		}
+		count <<=3D 1;
+	} while (count !=3D 0);
+
+	count =3D (__u32)S32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_set_invalid =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &controls=
);
+	errno_set_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, count=3D0x%x, ret_set_invalid=3D%=
i, errno_set_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_set_invalid, errno_set_invalid);
+
+	if (ret_set =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_set, 0);
+
+		CU_ASSERT_EQUAL(ret_set_invalid, -1);
+		CU_ASSERT(errno_set_invalid =3D=3D EFAULT || errno_set_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_set, -1);
+		CU_ASSERT_EQUAL(errno_set, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_set_invalid, -1);
+		CU_ASSERT_EQUAL(errno_set_invalid, EINVAL);
+	}
+
+	count =3D U32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_set_invalid =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &controls=
);
+	errno_set_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, count=3D0x%x, ret_set_invalid=3D%=
i, errno_set_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_set_invalid, errno_set_invalid);
+
+	if (ret_set =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_set, 0);
+
+		CU_ASSERT_EQUAL(ret_set_invalid, -1);
+		CU_ASSERT(errno_set_invalid =3D=3D EFAULT || errno_set_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_set, -1);
+		CU_ASSERT_EQUAL(errno_set, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_set_invalid, -1);
+		CU_ASSERT_EQUAL(errno_set_invalid, EINVAL);
+	}
+
+}
+
+void test_VIDIOC_S_EXT_CTRLS_NULL() {
+	struct v4l2_ext_controls controls;
+	int ret_set, errno_set;
+	int ret_null, errno_null;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_set =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, &controls);
+	errno_set =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, ret_set=3D%i, errno_set=3D%i\n",
+		__FILE__, __LINE__, ret_set, errno_set);
+
+	ret_null =3D ioctl(get_video_fd(), VIDIOC_S_EXT_CTRLS, NULL);
+	errno_null =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_S_EXT_CTRLS, ret_null=3D%i, errno_null=3D%i\n"=
,
+		__FILE__, __LINE__, ret_null, errno_null);
+
+	if (ret_set =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_set, 0);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_set, -1);
+		CU_ASSERT_EQUAL(errno_set, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EINVAL);
+	}
+}
+
+void test_VIDIOC_TRY_EXT_CTRLS_zero() {
+	struct v4l2_ext_controls controls;
+	int ret_try, errno_try;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_try =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &controls);
+	errno_try =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, ret_try=3D%i, errno_try=3D%i\n"=
,
+		__FILE__, __LINE__, ret_try, errno_try);
+
+	if (ret_try =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_try, 0);
+
+		CU_ASSERT_EQUAL(controls.ctrl_class, V4L2_CTRL_CLASS_USER);
+		CU_ASSERT_EQUAL(controls.count, 0);
+		// The value of controls.error_idx is not defined when ret_try =3D=3D =
0
+		CU_ASSERT_EQUAL(controls.reserved[0], 0);
+		CU_ASSERT_EQUAL(controls.reserved[1], 0);
+		CU_ASSERT_EQUAL(controls.controls, NULL);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_try, -1);
+		CU_ASSERT_EQUAL(errno_try, EINVAL);
+	}
+}
+
+void test_VIDIOC_TRY_EXT_CTRLS_zero_invalid_count() {
+	struct v4l2_ext_controls controls;
+	int ret_try, errno_try;
+	int ret_try_invalid, errno_try_invalid;
+	__u32 count;
+
+	count =3D 0;
+	memset(&controls, 0, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_try =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &controls);
+	errno_try =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, count=3D0x%x, ret_try=3D%i, err=
no_try=3D%i\n",
+		__FILE__, __LINE__, count, ret_try, errno_try);
+
+	count =3D 1;
+	/* Note: this loop also covers ((__u32)S32_MAX)+1 =3D 0x80000000 */
+	do {
+		memset(&controls, 0xff, sizeof(controls));
+		controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+		controls.count =3D count;
+		controls.controls =3D NULL;
+
+		ret_try_invalid =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &contr=
ols);
+		errno_try_invalid =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, count=3D0x%x, ret_try_invalid=3D=
%i, errno_try_invalid=3D%i\n",
+			__FILE__, __LINE__, count, ret_try_invalid, errno_try_invalid);
+
+		if (ret_try =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_try, 0);
+
+			/* if the VIDIOC_TRY_EXT_CTRLS is supported by the driver
+			 * it shall complain about the NULL pointer at
+			 * cotrols.controls because this does not match the
+			 * controls.count value
+			 */
+			CU_ASSERT_EQUAL(ret_try_invalid, -1);
+			CU_ASSERT(errno_try_invalid =3D=3D EFAULT || errno_try_invalid =3D=3D=
 ENOMEM);
+
+		} else {
+			CU_ASSERT_EQUAL(ret_try, -1);
+			CU_ASSERT_EQUAL(errno_try, EINVAL);
+
+			CU_ASSERT_EQUAL(ret_try_invalid, -1);
+			CU_ASSERT_EQUAL(errno_try_invalid, EINVAL);
+		}
+		count <<=3D 1;
+	} while (count !=3D 0);
+
+	count =3D (__u32)S32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_try_invalid =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &contro=
ls);
+	errno_try_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, count=3D0x%x, ret_try_invalid=3D=
%i, errno_try_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_try_invalid, errno_try_invalid);
+
+	if (ret_try =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_try, 0);
+
+		CU_ASSERT_EQUAL(ret_try_invalid, -1);
+		CU_ASSERT(errno_try_invalid =3D=3D EFAULT || errno_try_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_try, -1);
+		CU_ASSERT_EQUAL(errno_try, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_try_invalid, -1);
+		CU_ASSERT_EQUAL(errno_try_invalid, EINVAL);
+	}
+
+	count =3D U32_MAX;
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D count;
+	controls.controls =3D NULL;
+
+	ret_try_invalid =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &contro=
ls);
+	errno_try_invalid =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, count=3D0x%x, ret_try_invalid=3D=
%i, errno_try_invalid=3D%i\n",
+		__FILE__, __LINE__, count, ret_try_invalid, errno_try_invalid);
+
+	if (ret_try =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_try, 0);
+
+		CU_ASSERT_EQUAL(ret_try_invalid, -1);
+		CU_ASSERT(errno_try_invalid =3D=3D EFAULT || errno_try_invalid =3D=3D =
ENOMEM);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_try, -1);
+		CU_ASSERT_EQUAL(errno_try, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_try_invalid, -1);
+		CU_ASSERT_EQUAL(errno_try_invalid, EINVAL);
+	}
+
+}
+
+void test_VIDIOC_TRY_EXT_CTRLS_NULL() {
+	struct v4l2_ext_controls controls;
+	int ret_try, errno_try;
+	int ret_null, errno_null;
+
+	memset(&controls, 0xff, sizeof(controls));
+	controls.ctrl_class =3D V4L2_CTRL_CLASS_USER;
+	controls.count =3D 0;
+	controls.controls =3D NULL;
+
+	ret_try =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, &controls);
+	errno_try =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, ret_try=3D%i, errno_try=3D%i\n"=
,
+		__FILE__, __LINE__, ret_try, errno_try);
+
+	ret_null =3D ioctl(get_video_fd(), VIDIOC_TRY_EXT_CTRLS, NULL);
+	errno_null =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_TRY_EXT_CTRLS, ret_null=3D%i, errno_null=3D%i\=
n",
+		__FILE__, __LINE__, ret_null, errno_null);
+
+	if (ret_try =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_try, 0);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_try, -1);
+		CU_ASSERT_EQUAL(errno_try, EINVAL);
+
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EINVAL);
+	}
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_EXT_CTRLS.h ltp/testcases/kernel/device-drivers/v4l/user_space/test=
_VIDIOC_EXT_CTRLS.h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_E=
XT_CTRLS.h	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_EXT_CT=
RLS.h	2009-05-23 15:55:01.000000000 +0200
@@ -0,0 +1,21 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 19 May 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+void test_VIDIOC_G_EXT_CTRLS_zero(void);
+void test_VIDIOC_G_EXT_CTRLS_zero_invalid_count(void);
+void test_VIDIOC_G_EXT_CTRLS_one(void);
+void test_VIDIOC_G_EXT_CTRLS_NULL(void);
+
+void test_VIDIOC_S_EXT_CTRLS_zero(void);
+void test_VIDIOC_S_EXT_CTRLS_zero_invalid_count(void);
+void test_VIDIOC_S_EXT_CTRLS_NULL(void);
+
+void test_VIDIOC_TRY_EXT_CTRLS_zero(void);
+void test_VIDIOC_TRY_EXT_CTRLS_zero_invalid_count(void);
+void test_VIDIOC_TRY_EXT_CTRLS_NULL(void);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_t=
est.c ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c	2=
009-06-03 06:38:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c	2009-0=
5-25 07:40:19.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ * 23 May 2009  0.23 Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_E=
XT_CTRLS
  *  5 May 2009  0.22 Test cases added for VIDIOC_QUERYBUF
  * 29 Apr 2009  0.21 Test cases added for VIDIOC_REQBUFS
  * 18 Apr 2009  0.20 NULL parameter test suite split to read only, write=
 only
@@ -80,6 +81,7 @@
 #include "test_VIDIOC_AUDOUT.h"
 #include "test_VIDIOC_CROP.h"
 #include "test_VIDIOC_CTRL.h"
+#include "test_VIDIOC_EXT_CTRLS.h"
 #include "test_VIDIOC_PARM.h"
 #include "test_VIDIOC_FMT.h"
=20
@@ -221,6 +223,19 @@ static CU_TestInfo suite_get_set_try[] =3D
   { "VIDIOC_S_CTRL, gain control", test_VIDIOC_S_CTRL_gain },
   { "VIDIOC_S_CTRL, gain control with invalid value parameter", test_VID=
IOC_S_CTRL_gain_invalid },
=20
+  { "VIDIOC_G_EXT_CTRLS with zero items to get", test_VIDIOC_G_EXT_CTRLS=
_zero },
+  { "VIDIOC_G_EXT_CTRLS with zero items to get, but with invalid count v=
alues",=20
+	test_VIDIOC_G_EXT_CTRLS_zero_invalid_count },
+  { "VIDIOC_G_EXT_CTRLS with only one item to get", test_VIDIOC_G_EXT_CT=
RLS_one },
+
+  { "VIDIOC_S_EXT_CTRLS with zero items to set", test_VIDIOC_S_EXT_CTRLS=
_zero },
+  { "VIDIOC_S_EXT_CTRLS with zero items to set, but with invalid count v=
alues",=20
+	test_VIDIOC_S_EXT_CTRLS_zero_invalid_count },
+
+  { "VIDIOC_TRY_EXT_CTRLS with zero items to try", test_VIDIOC_TRY_EXT_C=
TRLS_zero },
+  { "VIDIOC_TRY_EXT_CTRLS with zero items to try, but with invalid count=
 values",=20
+	test_VIDIOC_TRY_EXT_CTRLS_zero_invalid_count },
+
   { "VIDIOC_G_PARM", test_VIDIOC_G_PARM },
   { "VIDIOC_G_PARM with invalid type parameter", test_VIDIOC_G_PARM_inva=
lid },
=20
@@ -327,9 +342,9 @@ static CU_TestInfo suite_null_writeread[
   { "VIDIOC_ENUMAUDIO with NULL parameter", test_VIDIOC_ENUMAUDIO_NULL }=
,
   { "VIDIOC_ENUMAUDOUT with NULL parameter", test_VIDIOC_ENUMAUDOUT_NULL=
 },
   { "VIDIOC_G_SLICED_VBI_CAP with NULL parameter", test_VIDIOC_G_SLICED_=
VBI_CAP_NULL },
-  /* { "VIDIOC_G_EXT_CTRLS with NULL parameter", }, */
-  /* { "VIDIOC_S_EXT_CTRLS with NULL parameter", }, */
-  /* { "VIDIOC_TRY_EXT_CTRLS with NULL parameter", }, */
+  { "VIDIOC_G_EXT_CTRLS with NULL parameter", test_VIDIOC_G_EXT_CTRLS_NU=
LL },
+  { "VIDIOC_S_EXT_CTRLS with NULL parameter", test_VIDIOC_S_EXT_CTRLS_NU=
LL },
+  { "VIDIOC_TRY_EXT_CTRLS with NULL parameter", test_VIDIOC_TRY_EXT_CTRL=
S_NULL },
   /* { "VIDIOC_ENUM_FRAMESIZES with NULL parameter", }, */
   /* { "VIDIOC_ENUM_FRAMEINTERVALS with NULL parameter", }, */
   /* { "VIDIOC_ENCODER_CMD with NULL parameter", }, */

--------------090401060601040901070407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--------------090401060601040901070407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090401060601040901070407--

