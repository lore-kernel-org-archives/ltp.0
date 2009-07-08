Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nm127@freemail.hu>) id 1MORAG-000894-7J
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 07:02:00 +0000
Received: from mail00a.mail.t-online.hu ([84.2.40.5])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MORAA-0006XA-1I
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 07:01:59 +0000
Message-ID: <4A544160.9030302@freemail.hu>
Date: Wed, 08 Jul 2009 08:49:04 +0200
From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090004070608020102050002"
Subject: [LTP] [PATCH] v4l-test 0.16 for LTP
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
--------------090004070608020102050002
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

this is v4l-test 0.16 for LTP.

Changes:
Iterate through all available inputs in VIDIOC_G_STD and
VIDIOC_S_STD test cases

Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>

Regards,

	M=E1rton N=E9meth

---
v4l-test home page: http://v4l-test.sourceforge.net/

--------------090004070608020102050002
Content-Type: text/x-diff;
 name="v4l-test-0.16_for_ltp.patch"
Content-Disposition: inline;
 filename="v4l-test-0.16_for_ltp.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/in=
dex.html ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/doc/index.htm=
l	2009-06-04 11:01:16.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/doc/index.html	200=
9-06-03 08:37:14.000000000 +0200
@@ -510,6 +510,18 @@ influence on the V4L2 API functions:</p>
       <td>Resume</td>
       <td>no</td>
     </tr>
+    <tr>
+      <td>Check for memory leak (e.g. analyze /proc/slab_allocators)</td=
>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>Opening /dev/video0 multiple times</td>
+      <td>no</td>
+    </tr>
+    <tr>
+      <td>Using /dev/video0 from a multi-threaded or multi-process envir=
onment paralell</td>
+      <td>no</td>
+    </tr>
   </tbody>
 </table>
=20
@@ -555,12 +567,43 @@ The following documents and articles are
       writen by <a href=3D"http://moinejf.free.fr/">Jean-Fran=C3=A7ois M=
oine</a>
   </li>
 </ul>
+<p>
+For USB or V4L loopback testing:
+</p>
+<ul>
+  <li>
+  <a href=3D"http://sourceforge.net/projects/usbip/">USB/IP</a>
+  </li>
+  <li>
+  <a href=3D"http://www.linux-usb.org/gadget/">Linux-USB Gadget API Fram=
ework</a>
+  </li>
+  <li>
+  <a href=3D"http://www.lavrsen.dk/twiki/bin/view/Motion/VideoFourLinuxL=
oopbackDevice">
+  Video4Linux Loopback Device
+  </a>
+  </li>
+</ul>
+<p>
+And what else can we read if we are looking for webcam test ideas:
+</p>
+<ul>
+  <li>
+  <a href=3D"http://www.microsoft.com/whdc/device/media/vidcap-drvtest.m=
spx">
+  Testing Windows Video Capture Drivers
+  </a>
+  </li>
+  <li>
+  <a href=3D"http://www.microsoft.com/whdc/device/media/WebCam_VidTests.=
mspx">
+  Webcam Video Fidelity Tests
+  </a>
+</ul>
=20
 <h2><a name=3D"feedback">Feedbacks</a></h2>
-<p>Any feedbacks, comments, ideas, etc. are welcome at the author's emai=
l address.</p>
+<p>Any feedbacks, comments, ideas, etc. are welcome at the author's emai=
l address.
+You can find the email address in the source package in the README file.=
</p>
 <hr style=3D"width: 100%; height: 2px;">
 <p>Last changed:
-Mon May 25 08:08:11 CEST 2009
+Wed Jun  3 08:35:10 CEST 2009
 </p>
 <p>
   <a href=3D"http://validator.w3.org/check?uri=3Dreferer"><img
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefi=
le ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009=
-06-04 11:01:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile	2009-07-0=
6 08:34:22.000000000 +0200
@@ -1,6 +1,7 @@
 #
 # v4l-test: Test environment for Video For Linux Two API
 #
+#  5 Jul 2009  0.18 v4l2_foreach.c added
 # 19 May 2009  0.17 test_VIDIOC_EXT_CTRLS.c added
 #  7 May 2009  0.16 v4l2_show.c added
 #  5 May 2009  0.15 test_VIDIOC_QUERYBUF.c added
@@ -38,6 +39,7 @@ LDFLAGS =3D -lcunit
=20
 OBJS =3D dev_video.o \
        v4l2_validator.o \
+       v4l2_foreach.o \
        test_VIDIOC_QUERYCAP.o \
        test_VIDIOC_ENUMAUDIO.o \
        test_VIDIOC_ENUMAUDOUT.o \
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README=
 ltp/testcases/kernel/device-drivers/v4l/user_space/README
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/README	2009-0=
6-04 11:01:15.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/README	2009-07-06 =
08:37:33.000000000 +0200
@@ -3,6 +3,8 @@
=20
 Release History
 ---------------
+ 6 Jul 2009  0.16 Iterate through all available inputs in VIDIOC_G_STD a=
nd
+                  VIDIOC_S_STD test cases
 25 May 2009  0.15 Test cases added for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_=
CTRLS
                   and VIDIOC_TRY_EXT_CTRLS
  7 May 2009  0.14 Test cases added for VIDIOC_QUERYBUF;
@@ -111,14 +113,9 @@ a USB video device or ask the user if a=20
 See doc/index.html about how much of the specification is covered by the
 different test cases.
=20
-Similar projects
-----------------
- - v4ltest: http://www.linuxowl.com/v4ltest.html
- - test cases in dvb-apps repository, under /test directory: http://linu=
xtv.org/hg/dvb-apps/file
- - test cases in v4l-dvb repository, under /v4l2-apps/test directory:
-http://linuxtv.org/hg/v4l-dvb/file
- - this test environment is also available under Linux Test Project (LTP=
),
-   under directory testcases/kernel/device-drivers/v4l/user_space: http:=
//ltp.sourceforge.net/
+See also
+--------
+See also doc/index.html for further references and recommended readings.
=20
 Feedbacks
 ---------
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_ENUMINPUT.c ltp/testcases/kernel/device-drivers/v4l/user_space/test=
_VIDIOC_ENUMINPUT.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_E=
NUMINPUT.c	2009-05-11 08:07:10.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_ENUMIN=
PUT.c	2009-07-06 08:34:29.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ *  5 Jul 2009  0.10 show_v4l2_input() introduced
  * 20 Apr 2009  0.9  Added string content validation
  * 19 Apr 2009  0.8  Also check std field
  * 18 Apr 2009  0.7  More strict check for strings
@@ -35,6 +36,7 @@
 #include "dev_video.h"
 #include "video_limits.h"
 #include "v4l2_validator.h"
+#include "v4l2_show.h"
=20
 #include "test_VIDIOC_ENUMINPUT.h"
=20
@@ -86,23 +88,7 @@ void test_VIDIOC_ENUMINPUT() {
 			input2.status =3D input.status;
 			CU_ASSERT_EQUAL(memcmp(&input, &input2, sizeof(input)), 0);
=20
-			dprintf("\tinput =3D {.index=3D%u, .name=3D\"%s\", "
-				".type=3D0x%X, .audioset=3D0x%X, .tuner=3D0x%X, "
-				".std=3D%llX, "
-				".status=3D0x%X, "
-				".reserved[]=3D{ 0x%X, 0x%X, 0x%X, 0x%X } }\n",
-				input.index,
-				input.name,
-				input.type,
-				input.audioset,
-				input.tuner,
-				input.std,
-				input.status,
-				input.reserved[0],
-				input.reserved[1],
-				input.reserved[2],
-				input.reserved[3]
-				);
+			show_v4l2_input(&input);
=20
 		} else {
 			CU_ASSERT_EQUAL(ret_enum, -1);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_V=
IDIOC_STD.c ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIO=
C_STD.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_S=
TD.c	2009-05-11 08:07:10.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/test_VIDIOC_STD.c	=
2009-07-06 08:34:17.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ *  5 Jul 2009  0.9  Iterate through all possible inputs
  * 18 Apr 2009  0.8  Typo corrected
  * 27 Mar 2009  0.7  Cleanup ret and errno variable names and dprintf() =
outputs;
  *                   Make VIDIOC_S_STD tests independent from VIDIOC_G_S=
TD
@@ -34,79 +35,153 @@
 #include "dev_video.h"
 #include "video_limits.h"
 #include "v4l2_validator.h"
+#include "v4l2_foreach.h"
=20
 #include "test_VIDIOC_STD.h"
=20
-void test_VIDIOC_G_STD() {
-	int ret_get, errno_get;
+static void do_test_VIDIOC_G_STD(int ret_input_enum, int errno_input_enu=
m, struct v4l2_input* input) {
 	v4l2_std_id std_id;
+	int ret_std_get, errno_std_get;
+	int f;
=20
-	/* TODO: Iterate trough all inputs and all outputs
-	 * with VIDIOC_ENUMINPUT and VIDIOC_ENUMOUTPUT.
+	/* Iterate trough all inputs with VIDIOC_ENUMINPUT.
 	 * Also ensure tahat VIDIC_G_STD is called at least
-	 * once even if VIDIOC_ENUMINPUT and VIDIOC_ENUMOUTPUT
-	 * always return EINVAL.
+	 * once even if VIDIOC_ENUMINPUT always return EINVAL.
 	 *
 	 * V4L2 API specification rev. 0.24, Chapter 1.7.
 	 * "Video Standards" specifies if the std field
-	 * of v4l2_input and v4l2_output is zero then
-	 * VIDIOC_G_STD shall always return EINVAL.
+	 * of v4l2_input or v4l2_output is zero when
+	 * executing VIDIOC_ENUMINPUT or VIDIOC_ENUMOUTPUT,
+	 * respectively, then VIDIOC_G_STD shall always
+	 * return EINVAL.
+	 */
+
+	/* TODO: Iterate trough all outputs VIDIOC_ENUMOUTPUT.
+	 * Also ensure tahat VIDIC_G_STD is called at least
+	 * once even if VIDIOC_ENUMOUTPUT always return EINVAL.
+	 *
+	 * TODO: What shall happen when changing output? The
+	 * VIDIOC_G_STD only deals with current input.
 	 */
=20
+	f =3D get_video_fd();
+
 	memset(&std_id, 0xff, sizeof(std_id));
-	ret_get =3D ioctl(get_video_fd(), VIDIOC_G_STD, &std_id);
-	errno_get =3D errno;
+	ret_std_get =3D ioctl(f, VIDIOC_G_STD, &std_id);
+	errno_std_get =3D errno;
=20
-	dprintf("\t%s:%u: VIDIOC_G_STD, ret_get=3D%i, errno_get=3D%i, std_id=3D=
0x%llX\n",
-		__FILE__, __LINE__, ret_get, errno_get, std_id);
+	dprintf("\t%s:%u: VIDIOC_G_STD, ret_std_get=3D%i, errno_std_get=3D%i, s=
td_id=3D0x%llX\n",
+		__FILE__, __LINE__, ret_std_get, errno_std_get, std_id);
=20
-	if (ret_get =3D=3D 0) {
-		CU_ASSERT_EQUAL(ret_get, 0);
-		CU_ASSERT(valid_v4l2_std_id(std_id));
+	if (ret_input_enum =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_input_enum, 0);
+		if (input->std =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_std_get, -1);
+			CU_ASSERT_EQUAL(errno_std_get, EINVAL);
+		} else {
+			if (ret_std_get =3D=3D 0) {
+				CU_ASSERT_EQUAL(ret_std_get, 0);
+				CU_ASSERT(valid_v4l2_std_id(std_id));
+			} else {
+				CU_ASSERT_EQUAL(ret_std_get, -1);
+				CU_ASSERT_EQUAL(errno_std_get, EINVAL);
+			}
+		}
 	} else {
-		CU_ASSERT_EQUAL(ret_get, -1);
-		CU_ASSERT_EQUAL(errno_get, EINVAL);
+		CU_ASSERT_EQUAL(ret_input_enum, -1);
+		CU_ASSERT_EQUAL(errno_input_enum, EINVAL);
+		if (ret_std_get =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_std_get, 0);
+			CU_ASSERT(valid_v4l2_std_id(std_id));
+		} else {
+			CU_ASSERT_EQUAL(ret_std_get, -1);
+			CU_ASSERT_EQUAL(errno_std_get, EINVAL);
+		}
 	}
+}
+
+void test_VIDIOC_G_STD() {
+
+	/* Iterate trough all inputs with VIDIOC_ENUMINPUT.
+	 * Also ensure tahat VIDIC_G_STD is called at least
+	 * once even if VIDIOC_ENUMINPUT always return EINVAL.
+	 *
+	 * V4L2 API specification rev. 0.24, Chapter 1.7.
+	 * "Video Standards" specifies if the std field
+	 * of v4l2_input or v4l2_output is zero when
+	 * executing VIDIOC_ENUMINPUT or VIDIOC_ENUMOUTPUT,
+	 * respectively, then VIDIOC_G_STD shall always
+	 * return EINVAL.
+	 */
+
+	foreach_input(do_test_VIDIOC_G_STD);
+
+
+	/* TODO: Iterate trough all outputs VIDIOC_ENUMOUTPUT.
+	 * Also ensure tahat VIDIC_G_STD is called at least
+	 * once even if VIDIOC_ENUMOUTPUT always return EINVAL.
+	 *
+	 * TODO: What shall happen when changing output? The
+	 * VIDIOC_G_STD only deals with current input.
+	 */
+
=20
 }
=20
-static int do_set_video_standard(int f, v4l2_std_id id) {
-	int ret_set, errno_set;
-	int ret_get, errno_get;
+static int do_set_video_standard(int f, v4l2_std_id id,
+		int ret_input_enum, int errno_input_enum, struct v4l2_input* input) {
+	int ret_std_set, errno_std_set;
+	int ret_std_get, errno_std_get;
 	v4l2_std_id std_id;
=20
 	std_id =3D id;
-	ret_set =3D ioctl(f, VIDIOC_S_STD, &std_id);
-	errno_set =3D errno;
+	ret_std_set =3D ioctl(f, VIDIOC_S_STD, &std_id);
+	errno_std_set =3D errno;
=20
-	dprintf("\t%s:%u: ret_set=3D%i, errno_set=3D%i, std_id=3D0x%llX, id=3D0=
x%llX\n",
-		__FILE__, __LINE__, ret_set, errno_set, std_id, id);
+	dprintf("\t%s:%u: VIDIOC_S_STD: ret_std_set=3D%i, errno_std_set=3D%i, s=
td_id=3D0x%llX, id=3D0x%llX\n",
+		__FILE__, __LINE__, ret_std_set, errno_std_set, std_id, id);
=20
-	if (ret_set =3D=3D 0) {
-		CU_ASSERT_EQUAL(ret_set, 0);
-		memset(&std_id, 0xff, sizeof(std_id));
-		ret_get =3D ioctl(f, VIDIOC_G_STD, &std_id);
-		errno_get =3D errno;
+	memset(&std_id, 0xff, sizeof(std_id));
+	ret_std_get =3D ioctl(f, VIDIOC_G_STD, &std_id);
+	errno_std_get =3D errno;
=20
-		CU_ASSERT_EQUAL(ret_get, 0);
-		if (ret_get =3D=3D 0) {
-			CU_ASSERT( (id & std_id) =3D=3D id);
+	dprintf("\t%s:%u: VIDIOC_G_STD: ret_std_get=3D%i, errno_std_get=3D%i, s=
td_id=3D0x%llX\n",
+		__FILE__, __LINE__, ret_std_get, errno_std_get, std_id);
=20
-			if (std_id !=3D id) {
-				dprintf("\t%s:%u: ret_get=3D%i, errno_get=3D%i, std_id=3D0x%llX, id=3D=
0x%llX\n",
-					__FILE__, __LINE__, ret_get, errno_get, std_id, id);
+	if (ret_input_enum =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_input_enum, 0);
+		if (input->std =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_std_get, -1);
+			CU_ASSERT_EQUAL(errno_std_get, EINVAL);
+			CU_ASSERT_EQUAL(ret_std_set, -1);
+			CU_ASSERT_EQUAL(errno_std_set, EINVAL);
+		} else {
+			if (ret_std_set =3D=3D 0) {
+				CU_ASSERT_EQUAL(ret_std_set, 0);
+				CU_ASSERT_EQUAL(ret_std_get, 0);
+				CU_ASSERT(valid_v4l2_std_id(std_id));
+			} else {
+				CU_ASSERT_EQUAL(ret_std_set, -1);
+				CU_ASSERT_EQUAL(errno_std_set, EINVAL);
 			}
-
 		}
 	} else {
-		CU_ASSERT_EQUAL(ret_set, -1);
-		CU_ASSERT_EQUAL(errno_set, EINVAL);
+		CU_ASSERT_EQUAL(ret_input_enum, -1);
+		CU_ASSERT_EQUAL(errno_input_enum, EINVAL);
+			if (ret_std_set =3D=3D 0) {
+				CU_ASSERT_EQUAL(ret_std_set, 0);
+				CU_ASSERT_EQUAL(ret_std_get, 0);
+				CU_ASSERT(valid_v4l2_std_id(std_id));
+			} else {
+				CU_ASSERT_EQUAL(ret_std_set, -1);
+				CU_ASSERT_EQUAL(errno_std_set, EINVAL);
+			}
 	}
=20
-	return ret_set;
+	return ret_std_set;
 }
=20
-void test_VIDIOC_S_STD() {
+static void do_test_VIDIOC_S_STD(int ret_input_enum, int errno_input_enu=
m, struct v4l2_input* input) {
 	int ret_get, errno_get;
 	int ret_set, errno_set;
 	v4l2_std_id std_id_orig;
@@ -121,37 +196,37 @@ void test_VIDIOC_S_STD() {
 	dprintf("\t%s:%u: VIDIOC_G_STD: ret_get=3D%i, errno_get=3D%i, std_id_or=
ig=3D0x%llX\n",
 		__FILE__, __LINE__, ret_get, errno_get, std_id_orig);
=20
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_B);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_B1);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_G);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_H);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_I);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_D);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_D1);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_K);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_M);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_N);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_Nc);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_60);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M_JP);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_443);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M_KR);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_B);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_D);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_G);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_H);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_K);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_K1);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_L);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_LC);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_ATSC_8_VSB);
-	ret_set =3D do_set_video_standard(f, V4L2_STD_ATSC_16_VSB);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_B, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_B1, ret_input_enum, e=
rrno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_G, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_H, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_I, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_D, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_D1, ret_input_enum, e=
rrno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_K, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_M, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_N, ret_input_enum, er=
rno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_Nc, ret_input_enum, e=
rrno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_PAL_60, ret_input_enum, e=
rrno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M, ret_input_enum, e=
rrno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M_JP, ret_input_enum=
, errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_443, ret_input_enum,=
 errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_NTSC_M_KR, ret_input_enum=
, errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_B, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_D, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_G, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_H, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_K, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_K1, ret_input_enum,=
 errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_L, ret_input_enum, =
errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_SECAM_LC, ret_input_enum,=
 errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_ATSC_8_VSB, ret_input_enu=
m, errno_input_enum, input);
+	ret_set =3D do_set_video_standard(f, V4L2_STD_ATSC_16_VSB, ret_input_en=
um, errno_input_enum, input);
=20
 	if (ret_get =3D=3D 0) {
 		CU_ASSERT_EQUAL(ret_get, 0);
 		/* Setting the original std_id should not fail */
-		ret_set =3D do_set_video_standard(f, std_id_orig);
+		ret_set =3D do_set_video_standard(f, std_id_orig, ret_input_enum, errn=
o_input_enum, input);
 		errno_set =3D errno;
=20
 		CU_ASSERT_EQUAL(ret_set, 0);
@@ -162,7 +237,11 @@ void test_VIDIOC_S_STD() {
=20
 }
=20
-void test_VIDIOC_S_STD_from_enum() {
+void test_VIDIOC_S_STD() {
+	foreach_input(do_test_VIDIOC_S_STD);
+}
+
+static void do_test_VIDIOC_S_STD_from_enum(int ret_input_enum, int errno=
_input_enum, struct v4l2_input* input) {
 	int ret_get, errno_get;
 	int ret_enum, errno_enum;
 	int ret_set, errno_set;
@@ -192,7 +271,7 @@ void test_VIDIOC_S_STD_from_enum() {
 			__FILE__, __LINE__, i, ret_enum, errno_enum, std.id);
=20
 		if (ret_enum =3D=3D 0) {
-			ret_set =3D do_set_video_standard(f, std.id);
+			ret_set =3D do_set_video_standard(f, std.id, ret_input_enum, errno_in=
put_enum, input);
 			CU_ASSERT_EQUAL(ret_set, 0);
 		}
 		i++;
@@ -202,7 +281,7 @@ void test_VIDIOC_S_STD_from_enum() {
 		CU_ASSERT_EQUAL(ret_get, 0);
=20
 		/* Setting the original std_id should not fail */
-		ret_set =3D do_set_video_standard(f, std_id_orig);
+		ret_set =3D do_set_video_standard(f, std_id_orig, ret_input_enum, errn=
o_input_enum, input);
 		errno_set =3D errno;
 		dprintf("\t%s:%u: VIDIOC_S_STD: ret_set=3D%i (expected %i), errno=3D%i=
\n",
 			__FILE__, __LINE__, ret_set, 0, errno);
@@ -214,8 +293,11 @@ void test_VIDIOC_S_STD_from_enum() {
=20
 }
=20
+void test_VIDIOC_S_STD_from_enum() {
+	foreach_input(do_test_VIDIOC_S_STD_from_enum);
+}
=20
-void test_VIDIOC_S_STD_invalid_standard() {
+static void do_test_VIDIOC_S_STD_invalid_standard(int ret_input_enum, in=
t errno_input_enum, struct v4l2_input* input) {
 	int ret_get, errno_get;
 	int ret_set, errno_set;
 	v4l2_std_id std_id_orig;
@@ -235,7 +317,7 @@ void test_VIDIOC_S_STD_invalid_standard(
 	std_id =3D 1;
 	while (std_id !=3D 0) {
 		if (!valid_v4l2_std_id(std_id)) {
-			ret_set =3D do_set_video_standard(f, std_id);
+			ret_set =3D do_set_video_standard(f, std_id, ret_input_enum, errno_in=
put_enum, input);
 			errno_set =3D errno;
=20
 			CU_ASSERT_EQUAL(ret_set, -1);
@@ -250,7 +332,7 @@ void test_VIDIOC_S_STD_invalid_standard(
 		CU_ASSERT_EQUAL(ret_get, 0);
=20
 		/* Setting the original std_id should not fail */
-		ret_set =3D do_set_video_standard(f, std_id_orig);
+		ret_set =3D do_set_video_standard(f, std_id_orig, ret_input_enum, errn=
o_input_enum, input);
 		errno_set =3D errno;
=20
 		dprintf("\t%s:%u: VIDIOC_S_STD: ret_set=3D%i (expected 0), errno=3D%i\=
n",
@@ -262,7 +344,11 @@ void test_VIDIOC_S_STD_invalid_standard(
 	}
 }
=20
-void test_VIDIOC_G_STD_NULL() {
+void test_VIDIOC_S_STD_invalid_standard() {
+	foreach_input(do_test_VIDIOC_S_STD_invalid_standard);
+}
+
+static void do_test_VIDIOC_G_STD_NULL(int ret_input_enum, int errno_inpu=
t_enum, struct v4l2_input* input) {
 	int ret_get, errno_get;
 	int ret_null, errno_null;
 	v4l2_std_id std_id;
@@ -280,20 +366,49 @@ void test_VIDIOC_G_STD_NULL() {
 	dprintf("\t%s:%u: VIDIOC_G_STD: ret_null=3D%i, errno_null=3D%i\n",
 		__FILE__, __LINE__, ret_null, errno_null);
=20
-	if (ret_get =3D=3D 0) {
-		CU_ASSERT_EQUAL(ret_get, 0);
-		CU_ASSERT_EQUAL(ret_null, -1);
-		CU_ASSERT_EQUAL(errno_null, EFAULT);
+	if (ret_input_enum =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_input_enum, 0);
+		if (input->std =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
+			CU_ASSERT_EQUAL(ret_null, -1);
+			CU_ASSERT_EQUAL(errno_null, EINVAL);
+		} else {
+			if (ret_get =3D=3D 0) {
+				CU_ASSERT_EQUAL(ret_get, 0);
+				CU_ASSERT_EQUAL(ret_null, -1);
+				CU_ASSERT_EQUAL(errno_null, EFAULT);
+			} else {
+				CU_ASSERT_EQUAL(ret_get, -1);
+				CU_ASSERT_EQUAL(errno_get, EINVAL);
+				CU_ASSERT_EQUAL(ret_null, -1);
+				CU_ASSERT_EQUAL(errno_null, EINVAL);
+			}
+		}
 	} else {
-		CU_ASSERT_EQUAL(ret_get, -1);
-		CU_ASSERT_EQUAL(errno_get, EINVAL);
-		CU_ASSERT_EQUAL(ret_null, -1);
-		CU_ASSERT_EQUAL(errno_null, EINVAL);
+		CU_ASSERT_EQUAL(ret_input_enum, -1);
+		CU_ASSERT_EQUAL(errno_input_enum, EINVAL);
+		if (ret_get =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_get, 0);
+			CU_ASSERT_EQUAL(ret_null, -1);
+			CU_ASSERT_EQUAL(errno_null, EFAULT);
+		} else {
+			CU_ASSERT_EQUAL(ret_get, -1);
+			CU_ASSERT_EQUAL(errno_get, EINVAL);
+			CU_ASSERT_EQUAL(ret_null, -1);
+			CU_ASSERT_EQUAL(errno_null, EINVAL);
+		}
 	}
=20
+
+
 }
=20
-void test_VIDIOC_S_STD_NULL() {
+void test_VIDIOC_G_STD_NULL() {
+	foreach_input(do_test_VIDIOC_G_STD_NULL);
+}
+
+static void do_test_VIDIOC_S_STD_NULL(int ret_input_enum, int errno_inpu=
t_enum, struct v4l2_input* input) {
 	int ret_null, errno_null;
=20
 	/* TODO: check whether VIDIOC_S_STD is supported at all or not */
@@ -304,10 +419,23 @@ void test_VIDIOC_S_STD_NULL() {
 	dprintf("\t%s:%u: VIDIOC_S_STD: ret_null=3D%i, errno_null=3D%i\n",
 		__FILE__, __LINE__, ret_null, errno_null);
=20
-	CU_ASSERT_EQUAL(ret_null, -1);
-	CU_ASSERT_EQUAL(errno_null, EFAULT);
-
+	if (ret_input_enum =3D=3D 0) {
+		CU_ASSERT_EQUAL(ret_input_enum, 0);
+		if (input->std =3D=3D 0) {
+			CU_ASSERT_EQUAL(ret_null, -1);
+			CU_ASSERT_EQUAL(errno_null, EINVAL);
+		} else {
+		}
+	} else {
+		CU_ASSERT_EQUAL(ret_input_enum, -1);
+		CU_ASSERT_EQUAL(errno_input_enum, EINVAL);
+		CU_ASSERT_EQUAL(ret_null, -1);
+		CU_ASSERT_EQUAL(errno_null, EFAULT);
+	}
 }
=20
+void test_VIDIOC_S_STD_NULL() {
+    foreach_input(do_test_VIDIOC_S_STD_NULL);
+}
=20
 /* TODO: VIDIOC_S_STD while STREAM_ON */
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_f=
oreach.c ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.=
c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.=
c	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.c	200=
9-07-06 08:34:33.000000000 +0200
@@ -0,0 +1,83 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ *  5 Jul 2009  0.1  First release
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
+#include "v4l2_show.h"
+#include "v4l2_foreach.h"
+
+void foreach_input(V4L2InputTestFunc pFunc) {
+	__u32 input_index_orig;
+	struct v4l2_input input;
+	int ret_input_get, errno_input_get;
+	int ret_input_enum, errno_input_enum;
+	int ret_input_set, errno_input_set;
+	__u32 i;
+	int f;
+	char not_yet_called =3D 1;
+
+	f =3D get_video_fd();
+
+	memset(&input_index_orig, 0xff, sizeof(input_index_orig));
+	ret_input_get =3D ioctl(f, VIDIOC_G_INPUT, &input_index_orig);
+	errno_input_get =3D errno;
+	dprintf("\t%s:%u: VIDIOC_G_INPUT, ret_input_get=3D%i, errno_input_get=3D=
%i, input_index_orig=3D0x%X\n",
+		__FILE__, __LINE__, ret_input_get, errno_input_get, input_index_orig);
+
+	i =3D 0;
+	do {
+		memset(&input, 0xff, sizeof(input));
+		input.index =3D i;
+		ret_input_enum =3D ioctl(f, VIDIOC_ENUMINPUT, &input);
+		errno_input_enum =3D errno;
+
+		dprintf("\t%s:%u: VIDIOC_ENUMINPUT: i=3D%u, ret_input_enum=3D%i, errno=
_input_enum=3D%i\n",
+			__FILE__, __LINE__, i, ret_input_enum, errno_input_enum);
+
+		if (ret_input_enum =3D=3D 0) {
+			show_v4l2_input(&input);
+			ret_input_set =3D ioctl(f, VIDIOC_S_INPUT, &input.index);
+			errno_input_set =3D errno;
+			dprintf("\t%s:%u: VIDIOC_S_INPUT: input.index=3D0x%X, ret_input_set=3D=
%i, errno_input_set=3D%i\n",
+				__FILE__, __LINE__, input.index, ret_input_set, errno_input_set);
+			CU_ASSERT_EQUAL(ret_input_set, 0);
+		}
+
+		/* Ensure that pFunc() is called at least once even if
+		 * everything else returned error before.
+		 */
+		if (not_yet_called || ret_input_enum =3D=3D 0) {
+			pFunc(ret_input_enum, errno_input_enum, &input);
+			not_yet_called =3D 0;
+		}
+
+		i++;
+	} while (ret_input_enum =3D=3D 0 && i !=3D 0);
+
+	if (ret_input_get =3D=3D 0) {
+		/* Setting the original input_id should not fail */
+		ret_input_set =3D ioctl(f, VIDIOC_S_INPUT, &input_index_orig);
+		errno_input_set =3D errno;
+		CU_ASSERT_EQUAL(ret_input_set, 0);
+	}
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_f=
oreach.h ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.=
h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.=
h	1970-01-01 01:00:00.000000000 +0100
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_foreach.h	200=
9-07-06 08:34:41.000000000 +0200
@@ -0,0 +1,14 @@
+/*
+ * v4l-test: Test environment for Video For Linux Two API
+ *
+ *  5 Jul 2009  0.1  First release
+ *
+ * Written by M=E1rton N=E9meth <nm127@freemail.hu>
+ * Released under GPL
+ */
+
+#include <linux/videodev2.h>
+
+typedef void (*V4L2InputTestFunc)(int ret_input_enum, int errno_input_en=
um, struct v4l2_input* input);
+
+void foreach_input(V4L2InputTestFunc pFunc);
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_s=
how.c ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c	2=
009-05-11 08:10:27.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.c	2009-0=
7-06 08:34:44.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ *  5 Jul 2009  0.2  show_v4l2_input() introduced
  *  7 May 2009  0.1  First release
  *
  * Written by M=E1rton N=E9meth <nm127@freemail.hu>
@@ -114,3 +115,23 @@ void show_v4l2_buffer(struct v4l2_buffer
 	);
=20
 }
+
+void show_v4l2_input(struct v4l2_input *input) {
+	dprintf("\tinput =3D {.index=3D%u, .name=3D\"%s\", "
+		".type=3D0x%X, .audioset=3D0x%X, .tuner=3D0x%X, "
+		".std=3D%llX, "
+		".status=3D0x%X, "
+		".reserved[]=3D{ 0x%X, 0x%X, 0x%X, 0x%X } }\n",
+		input->index,
+		input->name,
+		input->type,
+		input->audioset,
+		input->tuner,
+		input->std,
+		input->status,
+		input->reserved[0],
+		input->reserved[1],
+		input->reserved[2],
+		input->reserved[3]
+		);
+}
diff -uprN ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_s=
how.h ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h	2=
009-05-11 08:10:27.000000000 +0200
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/v4l2_show.h	2009-0=
7-06 08:34:38.000000000 +0200
@@ -1,6 +1,7 @@
 /*
  * v4l-test: Test environment for Video For Linux Two API
  *
+ *  5 Jul 2009  0.2  show_v4l2_input() introduced
  *  7 May 2009  0.1  First release
  *
  * Written by M=E1rton N=E9meth <nm127@freemail.hu>
@@ -11,3 +12,4 @@
=20
 void show_v4l2_requestbuffers(struct v4l2_requestbuffers *reqbuf);
 void show_v4l2_buffer(struct v4l2_buffer *buf);
+void show_v4l2_input(struct v4l2_input *input);

--------------090004070608020102050002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--------------090004070608020102050002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090004070608020102050002--

