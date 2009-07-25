Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nm127@freemail.hu>) id 1MUaeG-0000vr-13
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 06:22:24 +0000
Received: from mail00a.mail.t-online.hu ([84.2.40.5])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUaeC-00068Y-Rn
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 06:22:23 +0000
Message-ID: <4A6AA0E6.6000105@freemail.hu>
Date: Sat, 25 Jul 2009 08:06:30 +0200
From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090603080201060804070208"
Subject: [LTP] [PATCH] v4l-test 0.17 for LTP
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090603080201060804070208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is v4l-test 0.17 for LTP.

Changes:
Test cases added for VIDIOC_ENUM_FRAMESIZES and VIDIOC_G_JPEGCOMP.
New V4L2_PIX_FMT_* formats also used in test cases.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

Regards,

	M=C3=A1rton N=C3=A9meth

--------------090603080201060804070208
Content-Type: text/x-diff;
 name="v4l-test-0.17_for_ltp.patch"
Content-Disposition: inline;
 filename="v4l-test-0.17_for_ltp.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/in=
dex.html ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l	2009-07-08 19:35:12.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.html	200=
9-07-23 06:48:26.000000000 +0200
@@ -160,7 +160,7 @@ implemented test cases.</p>
     </tr>
     <tr>
       <td>ioctl <a href=3D"spec/r8494.htm">VIDIOC_ENUM_FRAMESIZES</a></t=
d>
-      <td>no</td>
+      <td>yes, only when STREAM_OFF</td>
       <td><a href=3D"spec/x16453.htm">Exp.</a> Enum.</td>
     </tr>
     <tr>
@@ -295,7 +295,7 @@ implemented test cases.</p>
     </tr>
     <tr>
       <td>ioctl <a href=3D"spec/r11285.htm">VIDIOC_G_JPEGCOMP</a></td>
-      <td>no</td>
+      <td>yes, only when STREAM_OFF</td>
       <td>Opt.</td>
     </tr>
     <tr>
@@ -603,7 +603,7 @@ And what else can we read if we are look
 You can find the email address in the source package in the README file.=
</p>
 <hr style=3D"width: 100%; height: 2px;">
 <p>Last changed:
-Wed Jun  3 08:35:10 CEST 2009
+Thu Jul 23 06:47:49 CEST 2009
 </p>
 <p>
   <a href=3D"http://validator.w3.org/check?uri=3Dreferer"><img
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/re=
sults.html ltp/testcases/kernel/device-drivers/v4l/user_space/doc/results=
.html
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/results.h=
tml	2009-06-04 11:01:16.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/doc/results.html	2=
009-07-08 08:38:07.000000000 +0200
@@ -72,6 +72,17 @@ project or during developing it.
 	</a>
 	</li>
=20
+	<li>
+	<a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D124694769813949&a=
mp;w=3D2">
+	[PATCH 1/2] v4l2: modify the webcam video standard handling
+	</a>
+	</li>
+
+	<li>
+	<a href=3D"http://marc.info/?l=3Dlinux-kernel&amp;m=3D124694772913969&a=
mp;w=3D2">
+	[PATCH 2/2] v4l2: remove unnecessary vidioc_s_std() from gspca
+	</a>
+	</li>
 </ul>
=20
 <p>In the out-of-tree <a href=3D"http://mcentral.de/hg/~mrec/em28xx-new"=
>em28xx-new driver</a>
@@ -100,7 +111,7 @@ the following problems were identified w
=20
 <hr style=3D"width: 100%; height: 2px;">
 <p>Last changed:
-Mon May 25 07:38:56 CEST 2009
+Wed Jul  8 08:38:00 CEST 2009
 </p>
 <p>
   <a href=3D"http://validator.w3.org/check?uri=3Dreferer"><img
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefi=
le ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009=
-07-08 19:35:12.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009-07-2=
3 06:47:17.000000000 +0200
@@ -1,6 +1,8 @@
 #
 # v4l-test: Test environment for Video For Linux Two API
 #
+# 16 Jul 2009  0.19 test_VIDIOC_JPEGCOMP.c and
+#                   test_VIDIOC_ENUM_FRAMESIZES.c added
 #  5 Jul 2009  0.18 v4l2_foreach.c added
 # 19 May 2009  0.17 test_VIDIOC_EXT_CTRLS.c added
 #  7 May 2009  0.16 v4l2_show.c added
@@ -44,9 +46,11 @@ OBJS =3D dev_video.o \
        test_VIDIOC_ENUMAUDIO.o \
        test_VIDIOC_ENUMAUDOUT.o \
        test_VIDIOC_ENUM_FMT.o \
+       test_VIDIOC_JPEGCOMP.o \
        test_VIDIOC_ENUMINPUT.o \
        test_VIDIOC_ENUMOUTPUT.o \
        test_VIDIOC_ENUMSTD.o \
+       test_VIDIOC_ENUM_FRAMESIZES.o \
        test_VIDIOC_LOG_STATUS.o \
        test_VIDIOC_CROPCAP.o \
        test_VIDIOC_G_SLICED_VBI_CAP.o \
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README=
 ltp/testcases/kernel/device-drivers/v4l/user_space/README
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README	2009-0=
7-08 19:35:12.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/README	2009-07-23 =
07:12:32.000000000 +0200
@@ -3,6 +3,9 @@
=20
 Release History
 ---------------
+23 Jul 2009  0.17 Test cases added for VIDIOC_ENUM_FRAMESIZES and
+                  VIDIOC_G_JPEGCOMP. New V4L2_PIX_FMT_* formats also
+                  used in test cases.
  6 Jul 2009  0.16 Iterate through all available inputs in VIDIOC_G_STD a=
nd
                   VIDIOC_S_STD test cases
 25 May 2009  0.15 Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_=
CTRLS
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_ENUM_FRAMESIZES.c ltp/testcases/kernel/device-drivers/v4l/user_spac=
e/test_VIDIOC_ENUM_FRAMESIZES.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_E=
NUM_FRAMESIZES.c	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUM_F=
RAMESIZES.c	2009-07-22 22:55:13.000000000 +0200
@@ -0,0 +1,588 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 16 Jun 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
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
+#include "v4l2_validator.h"
+#include "v4l2_foreach.h"
+#include "v4l2_show.h"
+
+#include "test_VIDIOC_ENUM_FRAMESIZES.h"
+
+static int valid_framesize_type(__u32 type) {
+	int valid =3D 0;
+
+	if ( (type =3D=3D V4L2_FRMSIZE_TYPE_DISCRETE) ||
+	     (type =3D=3D V4L2_FRMSIZE_TYPE_CONTINUOUS) ||
+	     (type =3D=3D V4L2_FRMSIZE_TYPE_STEPWISE) ) {
+		valid =3D 1;
+	} else {
+		valid =3D 0;
+	}
+	return valid;
+}
+
+static void do_test_VIDIOC_ENUM_FRAMESIZES(__u32 fmt) {
+	struct v4l2_frmsizeenum framesize;
+	int ret_frame, errno_frame;
+	__u32 i;
+	__u32 first_type;
+
+	i =3D 0;
+	first_type =3D 0;
+	do {
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D%u, pixel_format=3D0=
x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		if (i !=3D 0 && first_type !=3D V4L2_FRMSIZE_TYPE_DISCRETE) {
+			CU_ASSERT_EQUAL(ret_frame, -1);
+			CU_ASSERT_EQUAL(errno_frame, EINVAL);
+		}
+
+		if (ret_frame =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_frame, 0);
+			CU_ASSERT_EQUAL(framesize.index, i);
+			CU_ASSERT_EQUAL(framesize.pixel_format, fmt);
+			CU_ASSERT(valid_framesize_type(framesize.type));
+
+			if (i =3D=3D 0) {
+				first_type =3D framesize.type;
+			} else {
+				CU_ASSERT_EQUAL(framesize.type, first_type);
+			}
+
+			switch (framesize.type) {
+				case V4L2_FRMSIZE_TYPE_DISCRETE:
+					CU_ASSERT(0 < framesize.discrete.width);
+					CU_ASSERT(0 < framesize.discrete.height);
+					break;
+
+				case V4L2_FRMSIZE_TYPE_CONTINUOUS:
+					CU_ASSERT(0 < framesize.stepwise.min_width);
+					CU_ASSERT(0 < framesize.stepwise.max_width);
+					CU_ASSERT_EQUAL(framesize.stepwise.step_width, 1);
+
+					CU_ASSERT(framesize.stepwise.min_width < framesize.stepwise.max_wid=
th);
+
+					CU_ASSERT(0 < framesize.stepwise.min_height);
+					CU_ASSERT(0 < framesize.stepwise.max_height);
+					CU_ASSERT_EQUAL(framesize.stepwise.step_height, 1);
+
+					CU_ASSERT(framesize.stepwise.min_height < framesize.stepwise.max_he=
ight);
+					break;
+
+				case V4L2_FRMSIZE_TYPE_STEPWISE:
+					CU_ASSERT(0 < framesize.stepwise.min_width);
+					CU_ASSERT(0 < framesize.stepwise.max_width);
+					CU_ASSERT(0 < framesize.stepwise.step_width);
+
+					CU_ASSERT(framesize.stepwise.min_width < framesize.stepwise.max_wid=
th);
+
+					/* check if the given step is unambigous: min + n * step =3D max */
+					if (framesize.stepwise.step_width !=3D 0) {
+						CU_ASSERT_EQUAL( (framesize.stepwise.max_width-framesize.stepwise.=
min_width) % framesize.stepwise.step_width, 0);
+					}
+
+					CU_ASSERT(0 < framesize.stepwise.min_height);
+					CU_ASSERT(0 < framesize.stepwise.max_height);
+					CU_ASSERT(0 < framesize.stepwise.step_height);
+
+					CU_ASSERT(framesize.stepwise.min_height < framesize.stepwise.max_he=
ight);
+
+					/* check if the given step is unambigous: min + n * step =3D max */
+					if (framesize.stepwise.step_height !=3D 0) {
+						CU_ASSERT_EQUAL( (framesize.stepwise.max_height-framesize.stepwise=
.min_height) % framesize.stepwise.step_height, 0);
+					}
+
+					break;
+			}
+
+			CU_ASSERT_EQUAL(framesize.reserved[0], 0);
+			CU_ASSERT_EQUAL(framesize.reserved[1], 0);
+
+			show_v4l2_frmsizeenum(&framesize);
+
+		} else {
+			CU_ASSERT_EQUAL(ret_frame, -1);
+			CU_ASSERT_EQUAL(errno_frame, EINVAL);
+		}
+		i++;
+	} while (ret_frame =3D=3D 0 && i !=3D 0);
+
+}
+
+static void do_test_VIDIOC_ENUM_FRAMESIZES_type(enum v4l2_buf_type type)=
 {
+	int ret_enum, errno_enum;
+	struct v4l2_fmtdesc format;
+	__u32 i;
+
+	i =3D 0;
+	do {
+		memset(&format, 0xff, sizeof(format));
+		format.index =3D i;
+		format.type =3D type;
+
+		ret_enum =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format);
+		errno_enum =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_enum=3D%=
i, errno_enum=3D%i\n",
+			__FILE__, __LINE__, i, format.type, ret_enum, errno_enum);
+
+		/* Ensure that VIDIOC_ENUM_FRAMESIZES is called at least once
+		 * even if VIDIOC_ENUM_FMT returns error
+		 */
+		do_test_VIDIOC_ENUM_FRAMESIZES(format.pixelformat);
+
+		i++;
+	} while (ret_enum =3D=3D 0 && i !=3D 0);
+
+}
+
+void test_VIDIOC_ENUM_FRAMESIZES() {
+	do_test_VIDIOC_ENUM_FRAMESIZES_type(V4L2_BUF_TYPE_VIDEO_CAPTURE);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type(V4L2_BUF_TYPE_VIDEO_OUTPUT);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type(V4L2_BUF_TYPE_VIDEO_OVERLAY);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type(V4L2_BUF_TYPE_PRIVATE);
+}
+
+static void do_test_VIDIOC_ENUM_FRAMESIZES_invalid_index(__u32 fmt) {
+	struct v4l2_frmsizeenum framesize;
+	int ret_frame, errno_frame;
+	__u32 i;
+	__u32 max_index;
+
+	i =3D 0;
+	do {
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D%u, pixel_format=3D0=
x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		i++;
+	} while (ret_frame =3D=3D 0 && i !=3D 0);
+
+	max_index =3D i-1;
+
+	i =3D max_index+1;
+	memset(&framesize, 0xff, sizeof(framesize));
+	framesize.index =3D i;
+	framesize.pixel_format =3D fmt;
+	ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize)=
;
+	errno_frame =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D%u, pixel_format=3D0x=
%x, ret_frame=3D%i, errno_frame=3D%i\n",
+		__FILE__, __LINE__,
+		i, fmt,
+		ret_frame, errno_frame);
+
+	CU_ASSERT_EQUAL(ret_frame, -1);
+	CU_ASSERT_EQUAL(errno_frame, EINVAL);
+
+	i =3D (__u32)S32_MIN;
+	if (max_index < i) {
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D0x%x, pixel_format=3D=
0x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		CU_ASSERT_EQUAL(ret_frame, -1);
+		CU_ASSERT_EQUAL(errno_frame, EINVAL);
+	}
+
+	i =3D (__u32)S32_MAX;
+	if (max_index < i) {
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D0x%x, pixel_format=3D=
0x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		CU_ASSERT_EQUAL(ret_frame, -1);
+		CU_ASSERT_EQUAL(errno_frame, EINVAL);
+	}
+
+	i =3D (__u32)U32_MAX;
+	if (max_index < i) {
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D0x%x, pixel_format=3D=
0x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		CU_ASSERT_EQUAL(ret_frame, -1);
+		CU_ASSERT_EQUAL(errno_frame, EINVAL);
+	}
+
+}
+
+static void do_test_VIDIOC_ENUM_FRAMESIZES_type_invalid_index(enum v4l2_=
buf_type type) {
+	int ret_enum, errno_enum;
+	struct v4l2_fmtdesc format;
+	__u32 i;
+
+	i =3D 0;
+	do {
+		memset(&format, 0xff, sizeof(format));
+		format.index =3D i;
+		format.type =3D type;
+
+		ret_enum =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format);
+		errno_enum =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_enum=3D%=
i, errno_enum=3D%i\n",
+			__FILE__, __LINE__, i, format.type, ret_enum, errno_enum);
+
+		/* Ensure that VIDIOC_ENUM_FRAMESIZES is called at least once
+		 * even if VIDIOC_ENUM_FMT returns error
+		 */
+		do_test_VIDIOC_ENUM_FRAMESIZES_invalid_index(format.pixelformat);
+
+		i++;
+	} while (ret_enum =3D=3D 0 && i !=3D 0);
+
+}
+
+
+void test_VIDIOC_ENUM_FRAMESIZES_invalid_index() {
+	do_test_VIDIOC_ENUM_FRAMESIZES_type_invalid_index(V4L2_BUF_TYPE_VIDEO_C=
APTURE);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type_invalid_index(V4L2_BUF_TYPE_VIDEO_O=
UTPUT);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type_invalid_index(V4L2_BUF_TYPE_VIDEO_O=
VERLAY);
+	do_test_VIDIOC_ENUM_FRAMESIZES_type_invalid_index(V4L2_BUF_TYPE_PRIVATE=
);
+}
+
+static int supported_pixel_format_type(enum v4l2_buf_type type, __u32 pi=
xel_format) {
+	int ret_enum, errno_enum;
+	struct v4l2_fmtdesc format;
+	__u32 i;
+	int supported =3D 0;
+
+	i =3D 0;
+	do {
+		memset(&format, 0xff, sizeof(format));
+		format.index =3D i;
+		format.type =3D type;
+
+		ret_enum =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format);
+		errno_enum =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_enum=3D%=
i, errno_enum=3D%i\n",
+			__FILE__, __LINE__, i, format.type, ret_enum, errno_enum);
+
+		i++;
+	} while (ret_enum =3D=3D 0 && i !=3D 0 && format.pixelformat !=3D pixel=
_format);
+
+	if (ret_enum =3D=3D 0 && i !=3D 0 && format.pixelformat =3D=3D pixel_fo=
rmat) {
+		supported =3D 1;
+	}
+
+	return supported;
+}
+
+static int supported_pixel_format(__u32 pixel_format) {
+	int supported =3D 0;
+
+	supported =3D supported_pixel_format_type(V4L2_BUF_TYPE_VIDEO_CAPTURE, =
pixel_format);
+	if (!supported) {
+		supported =3D supported_pixel_format_type(V4L2_BUF_TYPE_VIDEO_OUTPUT, =
pixel_format);
+		if (!supported) {
+			supported =3D supported_pixel_format_type(V4L2_BUF_TYPE_VIDEO_OVERLAY=
, pixel_format);
+			if (!supported) {
+				supported =3D supported_pixel_format_type(V4L2_BUF_TYPE_PRIVATE, pix=
el_format);
+			}
+		}
+	}
+
+	return supported;
+}
+
+static void do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(__u32 fm=
t) {
+	struct v4l2_frmsizeenum framesize;
+	int ret_frame, errno_frame;
+	__u32 i;
+
+	if (!supported_pixel_format(fmt)) {
+		i =3D 0;
+		memset(&framesize, 0xff, sizeof(framesize));
+		framesize.index =3D i;
+		framesize.pixel_format =3D fmt;
+		ret_frame =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize=
);
+		errno_frame =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUM_FRAMESIZES, index=3D%u, pixel_format=3D0=
x%x, ret_frame=3D%i, errno_frame=3D%i\n",
+			__FILE__, __LINE__,
+			i, fmt,
+			ret_frame, errno_frame);
+
+		CU_ASSERT_EQUAL(ret_frame, -1);
+		CU_ASSERT_EQUAL(errno_frame, EINVAL);
+	}
+
+}
+
+void test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format() {
+
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(U32_MIN);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format((__u32)S32_MIN);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format((__u32)S32_MAX);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(U32_MAX);
+
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB332=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB444=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB555=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB565=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB555=
X);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB565=
X);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_BGR24)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB24)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_BGR32)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_RGB32)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_GREY);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_Y16);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_PAL8);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YVU410=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YVU420=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUYV);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_UYVY);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV422=
P);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV411=
P);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_Y41P);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV444=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV555=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV565=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV32)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_NV12);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_NV21);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV410=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YUV420=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YYUV);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_HI240)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_HM12);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SBGGR8=
);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SBGGR1=
6);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_MJPEG)=
;
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_JPEG);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_DV);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_MPEG);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_WNVA);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SN9C10=
X);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_PWC1);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_PWC2);
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_ET61X2=
51);
+
+#ifdef V4L2_PIX_FMT_VYUY
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_VYUY);
+#endif
+
+#ifdef V4L2_PIX_FMT_NV16
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_NV16);
+#endif
+
+#ifdef V4L2_PIX_FMT_NV61
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_NV61);
+#endif
+
+#ifdef V4L2_PIX_FMT_SGBRG8
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SGBRG8=
);
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG8
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SGRBG8=
);
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG10
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SGRBG1=
0);
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG10DPCM8
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SGRBG1=
0DPCM8);
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA501
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SPCA50=
1);
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA505
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SPCA50=
5);
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA508
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SPCA50=
8);
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA561
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SPCA56=
1);
+#endif
+
+#ifdef V4L2_PIX_FMT_PAC207
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_PAC207=
);
+#endif
+
+#ifdef V4L2_PIX_FMT_MR97310A
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_MR9731=
0A);
+#endif
+
+#ifdef V4L2_PIX_FMT_SQ905C
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_SQ905C=
);
+#endif
+
+#ifdef V4L2_PIX_FMT_PJPG
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_PJPG);
+#endif
+
+#ifdef V4L2_PIX_FMT_YVYU
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_YVYU);
+#endif
+
+#ifdef V4L2_PIX_FMT_OV511
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_OV511)=
;
+#endif
+
+#ifdef V4L2_PIX_FMT_OV518
+	do_test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(V4L2_PIX_FMT_OV518)=
;
+#endif
+
+}
+
+void test_VIDIOC_ENUM_FRAMESIZES_NULL() {
+	struct v4l2_fmtdesc format_capture;
+	struct v4l2_fmtdesc format_output;
+	struct v4l2_fmtdesc format_overlay;
+	struct v4l2_fmtdesc format_private;
+	struct v4l2_frmsizeenum framesize;
+	int ret_fmt_capture, errno_fmt_capture;
+	int ret_fmt_output, errno_fmt_output;
+	int ret_fmt_overlay, errno_fmt_overlay;
+	int ret_fmt_private, errno_fmt_private;
+	int ret_size, errno_size;
+	int ret_null, errno_null;
+	__u32 fmt;
+
+	memset(&format_capture, 0xff, sizeof(format_capture));
+	format_capture.index =3D 0;
+	format_capture.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+	ret_fmt_capture =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format_capt=
ure);
+	errno_fmt_capture =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_fmt_captu=
re=3D%i, errno_fmt_capture=3D%i\n",
+		__FILE__, __LINE__, format_capture.index, format_capture.type, ret_fmt=
_capture, errno_fmt_capture);
+
+	memset(&format_output, 0xff, sizeof(format_output));
+	format_output.index =3D 0;
+	format_output.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT;
+
+	ret_fmt_output =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format_outpu=
t);
+	errno_fmt_output =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_fmt_outpu=
t=3D%i, errno_fmt_output=3D%i\n",
+		__FILE__, __LINE__, format_output.index, format_output.type, ret_fmt_o=
utput, errno_fmt_output);
+
+	memset(&format_overlay, 0xff, sizeof(format_overlay));
+	format_overlay.index =3D 0;
+	format_overlay.type =3D V4L2_BUF_TYPE_VIDEO_OVERLAY;
+
+	ret_fmt_overlay =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format_over=
lay);
+	errno_fmt_overlay =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_fmt_overl=
ay=3D%i, errno_fmt_overlay=3D%i\n",
+		__FILE__, __LINE__, format_overlay.index, format_overlay.type, ret_fmt=
_overlay, errno_fmt_overlay);
+
+	memset(&format_private, 0xff, sizeof(format_private));
+	format_private.index =3D 0;
+	format_private.type =3D V4L2_BUF_TYPE_PRIVATE;
+
+	ret_fmt_private =3D ioctl(get_video_fd(), VIDIOC_ENUM_FMT, &format_priv=
ate);
+	errno_fmt_private =3D errno;
+
+	dprintf("\t%s:%u: VIDIOC_ENUM_FMT, index=3D%u, type=3D%i, ret_fmt_priva=
te=3D%i, errno_fmt_private=3D%i\n",
+		__FILE__, __LINE__, format_private.index, format_private.type, ret_fmt=
_private, errno_fmt_private);
+
+	if (ret_fmt_capture =3D=3D 0) {
+		fmt =3D format_capture.pixelformat;
+	} else if (ret_fmt_output =3D=3D 0) {
+		fmt =3D format_output.pixelformat;
+	} else if (ret_fmt_overlay =3D=3D 0) {
+		fmt =3D format_overlay.pixelformat;
+	} else if (ret_fmt_private =3D=3D 0) {
+		fmt =3D format_private.pixelformat;
+	} else {
+		fmt =3D 0;
+	}
+
+	memset(&framesize, 0xff, sizeof(framesize));
+	framesize.index =3D 0;
+	framesize.pixel_format =3D fmt;
+	ret_size =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, &framesize);
+	errno_size =3D errno;
+
+	dprintf("\tVIDIOC_ENUM_FRAMESIZES, index=3D%u, pixel_format=3D0x%x, ret=
_size=3D%i, errno_size=3D%i\n",
+				framesize.index, framesize.pixel_format, ret_size, errno_size);
+
+	ret_null =3D ioctl(get_video_fd(), VIDIOC_ENUM_FRAMESIZES, NULL);
+	errno_null =3D errno;
+
+	dprintf("\tVIDIOC_ENUM_FRAMESIZES, ret_null=3D%i, errno_null=3D%i\n", r=
et_null, errno_null);
+
+	if (ret_size =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_size, 0);
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+	} else {
+		CU_ASSERT_EQUAL(ret_size, -1);
+		CU_ASSERT_EQUAL(errno_size, EINVAL);
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EINVAL);
+	}
+
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_ENUM_FRAMESIZES.h ltp/testcases/kernel/device-drivers/v4l/user_spac=
e/test_VIDIOC_ENUM_FRAMESIZES.h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_E=
NUM_FRAMESIZES.h	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUM_F=
RAMESIZES.h	2009-07-20 23:10:23.000000000 +0200
@@ -0,0 +1,13 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 16 Jul 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+void test_VIDIOC_ENUM_FRAMESIZES(void);
+void test_VIDIOC_ENUM_FRAMESIZES_invalid_index(void);
+void test_VIDIOC_ENUM_FRAMESIZES_invalid_pixel_format(void);
+void test_VIDIOC_ENUM_FRAMESIZES_NULL(void);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_FMT.c ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIO=
C_FMT.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_F=
MT.c	2009-04-21 11:23:00.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_FMT.c	=
2009-07-22 22:50:54.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ * 19 Jul 2009  0.4  More V4L2_PIX_FMT_* formats added to valid_poxelfor=
mat()
  * 18 Apr 2009  0.3  Type added to debug printouts
  * 15 Apr 2009  0.2  Added test case for VIDIOC_S_FMT
  *  4 Apr 2009  0.1  First release
@@ -76,6 +77,81 @@ int valid_pixelformat(__u32 pixelformat)
 	case V4L2_PIX_FMT_PWC1:
 	case V4L2_PIX_FMT_PWC2:
 	case V4L2_PIX_FMT_ET61X251:
+
+	/* formats from Linux kernel 2.6.31-rc2 */
+
+#ifdef V4L2_PIX_FMT_VYUY
+	case V4L2_PIX_FMT_VYUY:
+#endif
+
+#ifdef V4L2_PIX_FMT_NV16
+	case V4L2_PIX_FMT_NV16:
+#endif
+
+#ifdef V4L2_PIX_FMT_NV61
+	case V4L2_PIX_FMT_NV61:
+#endif
+
+#ifdef V4L2_PIX_FMT_SGBRG8
+	case V4L2_PIX_FMT_SGBRG8:
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG8
+	case V4L2_PIX_FMT_SGRBG8:
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG10
+	case V4L2_PIX_FMT_SGRBG10:
+#endif
+
+#ifdef V4L2_PIX_FMT_SGRBG10DPCM8
+	case V4L2_PIX_FMT_SGRBG10DPCM8:
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA501
+	case V4L2_PIX_FMT_SPCA501:
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA505
+	case V4L2_PIX_FMT_SPCA505:
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA508
+	case V4L2_PIX_FMT_SPCA508:
+#endif
+
+#ifdef V4L2_PIX_FMT_SPCA561
+	case V4L2_PIX_FMT_SPCA561:
+#endif
+
+#ifdef V4L2_PIX_FMT_PAC207
+	case V4L2_PIX_FMT_PAC207:
+#endif
+
+#ifdef V4L2_PIX_FMT_MR97310A
+	case V4L2_PIX_FMT_MR97310A:
+#endif
+
+#ifdef V4L2_PIX_FMT_SQ905C
+	case V4L2_PIX_FMT_SQ905C:
+#endif
+
+#ifdef V4L2_PIX_FMT_PJPG
+	case V4L2_PIX_FMT_PJPG:
+#endif
+
+#ifdef V4L2_PIX_FMT_YVYU
+	case V4L2_PIX_FMT_YVYU:
+#endif
+
+#ifdef V4L2_PIX_FMT_OV511
+	case V4L2_PIX_FMT_OV511:
+#endif
+
+#ifdef V4L2_PIX_FMT_OV518
+	case V4L2_PIX_FMT_OV518:
+#endif
+
 		valid =3D 1;
 		break;
 	default:
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_JPEGCOMP.c ltp/testcases/kernel/device-drivers/v4l/user_space/test_=
VIDIOC_JPEGCOMP.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_J=
PEGCOMP.c	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_JPEGCO=
MP.c	2009-07-16 11:35:18.000000000 +0200
@@ -0,0 +1,122 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 16 Jun 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
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
+#include "v4l2_validator.h"
+#include "v4l2_foreach.h"
+
+#include "test_VIDIOC_JPEGCOMP.h"
+
+static int valid_jpeg_markers(__u32 jpeg_markers) {
+	int valid =3D 0;
+
+	if ( (jpeg_markers & ~(V4L2_JPEG_MARKER_DHT |
+			       V4L2_JPEG_MARKER_DQT |
+			       V4L2_JPEG_MARKER_DRI |
+			       V4L2_JPEG_MARKER_COM |
+			       V4L2_JPEG_MARKER_APP))
+		=3D=3D 0) {
+		valid =3D 1;
+	} else {
+		valid =3D 0;
+	}
+	return valid;
+}
+
+
+void test_VIDIOC_G_JPEGCOMP() {
+	struct v4l2_jpegcompression jpegcomp;
+	int ret_get, errno_get;
+
+	memset(&jpegcomp, 0xff, sizeof(jpegcomp));
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_JPEGCOMP, &jpegcomp);
+	errno_get =3D errno;
+
+	dprintf("\tVIDIOC_G_JPEGCOMP, ret_get=3D%i, errno_get=3D%i\n", ret_get,=
 errno_get);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+
+		//CU_ASSERT_EQUAL(jpegcomp.quality, ???);
+		//CU_ASSERT_EQUAL(jpegcomp.APPn, ???);
+		CU_ASSERT(0 <=3D jpegcomp.APP_len);
+		CU_ASSERT(jpegcomp.APP_len <=3D (int)sizeof(jpegcomp.APP_data));
+		//CU_ASSERT_EQUAL(jpegcomp.APP_data, ???);
+		CU_ASSERT(0 <=3D jpegcomp.COM_len);
+		CU_ASSERT(jpegcomp.COM_len <=3D (int)sizeof(jpegcomp.COM_data));
+		//CU_ASSERT_EQUAL(jpegcomp.COM_data, ???);
+		CU_ASSERT(valid_jpeg_markers(jpegcomp.jpeg_markers));
+
+		dprintf("\tjpegcomp =3D { .quality=3D%i, "
+			".APPn=3D%i, "
+			".APP_len=3D%i, "
+			".APP_data=3D..., "
+			".COM_len=3D%i, "
+			".COM_data=3D..., "
+			".jpeg_markers=3D0x%x ",
+			jpegcomp.quality,
+			jpegcomp.APPn,
+			jpegcomp.APP_len,
+			//jpegcomp.APP_data,
+			jpegcomp.COM_len,
+			//jpegcomp.COM_data,
+			jpegcomp.jpeg_markers
+		);
+
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+	}
+
+}
+
+void test_VIDIOC_G_JPEGCOMP_NULL() {
+	struct v4l2_jpegcompression jpegcomp;
+	int ret_get, errno_get;
+	int ret_null, errno_null;
+
+	memset(&jpegcomp, 0, sizeof(jpegcomp));
+	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_JPEGCOMP, &jpegcomp);
+	errno_get =3D errno;
+
+	dprintf("\tVIDIOC_G_JPEGCOMP, ret_get=3D%i, errno_get=3D%i\n", ret_get,=
 errno_get);
+
+	ret_null =3D ioctl(get_video_fd(), VIDIOC_G_JPEGCOMP, NULL);
+	errno_null =3D errno;
+
+	dprintf("\tVIDIOC_G_JPEGCOMP, ret_null=3D%i, errno_null=3D%i\n", ret_nu=
ll, errno_null);
+
+	if (ret_get =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_get, 0);
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+	} else {
+		CU_ASSERT_EQUAL(ret_get, -1);
+		CU_ASSERT_EQUAL(errno_get, EINVAL);
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EINVAL);
+	}
+
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_JPEGCOMP.h ltp/testcases/kernel/device-drivers/v4l/user_space/test_=
VIDIOC_JPEGCOMP.h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_J=
PEGCOMP.h	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_JPEGCO=
MP.h	2009-07-16 11:10:27.000000000 +0200
@@ -0,0 +1,11 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ * 16 Jul 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+void test_VIDIOC_G_JPEGCOMP(void);
+void test_VIDIOC_G_JPEGCOMP_NULL(void);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_s=
how.c ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c	2=
009-07-08 19:35:12.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c	2009-0=
7-17 12:12:01.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ * 17 Jul 2009  0.3  show_v4l2_frmsizeenum() added
  *  5 Jul 2009  0.2  show_v4l2_input() introduced
  *  7 May 2009  0.1  First release
  *
@@ -135,3 +136,45 @@ void show_v4l2_input(struct v4l2_input *
 		input->reserved[3]
 		);
 }
+
+void show_v4l2_frmsizeenum(struct v4l2_frmsizeenum* framesize) {
+	dprintf("\tframesize =3D { .index=3D%u, "
+		".pixel_format=3D0x%x, "
+		".type=3D%u, ",
+		framesize->index,
+		framesize->pixel_format,
+		framesize->type
+	);
+
+	switch (framesize->type) {
+		case V4L2_FRMSIZE_TYPE_DISCRETE:
+			dprintf(".discrete =3D { .width=3D%u, heigth=3D%u }, ",
+				framesize->discrete.width,
+				framesize->discrete.height);
+			break;
+		case V4L2_FRMSIZE_TYPE_CONTINUOUS:
+		case V4L2_FRMSIZE_TYPE_STEPWISE:
+			dprintf(".stepwise =3D { .min_width=3D%u, "
+				".max_width=3D%u, "
+				".step_width=3D%u, "
+				".min_height=3D%u, "
+				".max_height=3D%u, "
+				".step_height=3D%u }, ",
+				framesize->stepwise.min_width,
+				framesize->stepwise.max_width,
+				framesize->stepwise.step_width,
+				framesize->stepwise.min_height,
+				framesize->stepwise.max_height,
+				framesize->stepwise.step_height
+				);
+			break;
+		default:
+			;
+	}
+
+	dprintf(".reserved =3D { 0x%x, 0x%x } }\n",
+		framesize->reserved[0],
+		framesize->reserved[1]
+	);
+
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_s=
how.h ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h	2=
009-07-08 19:35:12.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h	2009-0=
7-17 12:13:02.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ * 17 Jul 2009  0.3  show_v4l2_frmsizeenum() added
  *  5 Jul 2009  0.2  show_v4l2_input() introduced
  *  7 May 2009  0.1  First release
  *
@@ -13,3 +14,4 @@
 void show_v4l2_requestbuffers(struct v4l2_requestbuffers *reqbuf);
 void show_v4l2_buffer(struct v4l2_buffer *buf);
 void show_v4l2_input(struct v4l2_input *input);
+void show_v4l2_frmsizeenum(struct v4l2_frmsizeenum* framesize);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_t=
est.c ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c	2=
009-06-04 11:01:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_test.c	2009-0=
7-20 23:11:09.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ * 16 Jul 2009  0.24 Test cases added for VIDIOC_G_JPEGCOMP and VIDIOC_E=
NUM_FRAMESIZES
  * 23 May 2009  0.23 Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_E=
XT_CTRLS
  *  5 May 2009  0.22 Test cases added for VIDIOC_QUERYBUF
  * 29 Apr 2009  0.21 Test cases added for VIDIOC_REQBUFS
@@ -69,6 +70,7 @@
 #include "test_VIDIOC_ENUM_FMT.h"
 #include "test_VIDIOC_ENUMINPUT.h"
 #include "test_VIDIOC_ENUMOUTPUT.h"
+#include "test_VIDIOC_ENUM_FRAMESIZES.h"
=20
 #include "test_VIDIOC_STD.h"
 #include "test_VIDIOC_INPUT.h"
@@ -84,6 +86,7 @@
 #include "test_VIDIOC_EXT_CTRLS.h"
 #include "test_VIDIOC_PARM.h"
 #include "test_VIDIOC_FMT.h"
+#include "test_VIDIOC_JPEGCOMP.h"
=20
 #include "test_VIDIOC_REQBUFS.h"
 #include "test_VIDIOC_QUERYBUF.h"
@@ -150,6 +153,10 @@ static CU_TestInfo suite_enums[] =3D {
   { "VIDIOC_QUERYMENU with private controls", test_VIDIOC_QUERYMENU_priv=
ate },
   { "VIDIOC_QUERYMENU, last private control+1", test_VIDIOC_QUERYMENU_pr=
ivate_last_1 },
=20
+  { "VIDIOC_ENUM_FRAMESIZES", test_VIDIOC_ENUM_FRAMESIZES },
+  { "VIDIOC_ENUM_FRAMESIZES with invalid index", test_VIDIOC_ENUM_FRAMES=
IZES_invalid_index },
+  { "VIDIOC_ENUM_FRAMESIZES with invalid pixel_format", test_VIDIOC_ENUM=
_FRAMESIZES_invalid_pixel_format },
+
   CU_TEST_INFO_NULL,
 };
=20
@@ -245,6 +252,8 @@ static CU_TestInfo suite_get_set_try[] =3D
   { "VIDIOC_S_FMT with enumerated values", test_VIDIOC_S_FMT_enum },
   { "VIDIOC_S_FMT with invalid type parameter", test_VIDIOC_S_FMT_type }=
,
=20
+  { "VIDIOC_G_JPEGCOMP", test_VIDIOC_G_JPEGCOMP },
+
   CU_TEST_INFO_NULL,
 };
=20
@@ -286,7 +295,7 @@ static CU_TestInfo suite_null_readonly[]
   { "VIDIOC_G_INPUT with NULL parameter", test_VIDIOC_G_INPUT_NULL },
   { "VIDIOC_G_OUTPUT with NULL parameter", test_VIDIOC_G_OUTPUT_NULL },
   { "VIDIOC_G_AUDOUT with NULL parameter", test_VIDIOC_G_AUDOUT_NULL },
-  /* { "VIDIOC_G_JPEGCOMP with NULL parameter", }, */
+  { "VIDIOC_G_JPEGCOMP with NULL parameter", test_VIDIOC_G_JPEGCOMP_NULL=
 },
   { "VIDIOC_QUERYSTD with NULL parameter", test_VIDIOC_QUERYSTD_NULL },
   { "VIDIOC_G_PRIORITY with NULL parameter", test_VIDIOC_G_PRIORITY_NULL=
 },
   /* { "VIDIOC_G_ENC_INDEX with NULL parameter", }, */
@@ -345,7 +354,7 @@ static CU_TestInfo suite_null_writeread[
   { "VIDIOC_G_EXT_CTRLS with NULL parameter", test_VIDIOC_G_EXT_CTRLS_NU=
LL },
   { "VIDIOC_S_EXT_CTRLS with NULL parameter", test_VIDIOC_S_EXT_CTRLS_NU=
LL },
   { "VIDIOC_TRY_EXT_CTRLS with NULL parameter", test_VIDIOC_TRY_EXT_CTRL=
S_NULL },
-  /* { "VIDIOC_ENUM_FRAMESIZES with NULL parameter", }, */
+  { "VIDIOC_ENUM_FRAMESIZES with NULL parameter", test_VIDIOC_ENUM_FRAME=
SIZES_NULL },
   /* { "VIDIOC_ENUM_FRAMEINTERVALS with NULL parameter", }, */
   /* { "VIDIOC_ENCODER_CMD with NULL parameter", }, */
   /* { "VIDIOC_TRY_ENCODER_CMD with NULL parameter", }, */

--------------090603080201060804070208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------090603080201060804070208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090603080201060804070208--

