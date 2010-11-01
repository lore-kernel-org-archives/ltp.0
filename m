Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PCoJN-0000XB-SQ
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 06:56:09 +0000
Received: from out13.sjc.mx.trendmicro.com ([216.99.131.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PCoJG-0003i9-Ta
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 06:56:09 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.9])
	by out13.sjc.mx.trendmicro.com (Postfix) with ESMTP id E318F980419
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Nov 2010 06:55:56 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2CB96114B874
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Nov 2010 06:55:55 +0000 (UTC)
Message-ID: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 1 Nov 2010 15:22:05 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_15_22_06_Monday_November_01_2010_8485"
Content-Language: ja
Subject: [LTP] [PATCH] fix "sigaction" tests
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
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_15_22_06_Monday_November_01_2010_8485
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi,


POSIX "conformance/interfaces/sigaction/16-1" and other 25 tests failed
with following message:
------------
conformance/interfaces/sigaction/16-1: execution: FAILED: Output:
Caught signal 6
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-1.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-10: execution: FAILED: Output:
Caught signal 13
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-10.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-11: execution: FAILED: Output:
Caught signal 3
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-11.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-12: execution: FAILED: Output:
Caught signal 11
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-12.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-13: execution: FAILED: Output:
Caught signal 15
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-13.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-14: execution: FAILED: Output:
Caught signal 20
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-14.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-15: execution: FAILED: Output:
Caught signal 21
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-15.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-16: execution: FAILED: Output:
Caught signal 22
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-16.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-17: execution: FAILED: Output:
Caught signal 10
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-17.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-18: execution: FAILED: Output:
Caught signal 12
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-18.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-19: execution: FAILED: Output:
Caught signal 29
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-19.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-2: execution: FAILED: Output:
Caught signal 14
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-2.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-20: execution: FAILED: Output:
Caught signal 27
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-20.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-21: execution: FAILED: Output:
Caught signal 31
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-21.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-22: execution: FAILED: Output:
Caught signal 5
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-22.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-23: execution: FAILED: Output:
Caught signal 23
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-23.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-24: execution: FAILED: Output:
Caught signal 26
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-24.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-25: execution: FAILED: Output:
Caught signal 24
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-25.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-26: execution: FAILED: Output:
Caught signal 25
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-26.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-3: execution: FAILED: Output:
Caught signal 7
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-3.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-4: execution: FAILED: Output:
Caught signal 17
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-4.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-5: execution: FAILED: Output:
Caught signal 18
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-5.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-6: execution: FAILED: Output:
Caught signal 8
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-6.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-7: execution: FAILED: Output:
Caught signal 1
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-7.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-8: execution: FAILED: Output:
Caught signal 4
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-8.c FAILED: The
function returned EINTR while SA_RESTART is set
conformance/interfaces/sigaction/16-9: execution: FAILED: Output:
Caught signal 2
[16:42:34]Test ../../../conformance/interfaces/sigaction/16-9.c FAILED: The
function returned EINTR while SA_RESTART is set
------------

Environment is as follows:
  - RHEL4.8 (kernel version 2.6.9-89)   --- (x86, x86_64, ia64)
  - RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)


The cause of above error is that sem_wait() of the testing kernel version
always returns with EINTR.

"man sem_wait" says:
------------
[...]

       EINTR  The call was interrupted by a signal handler.

[...]

NOTES
       A  signal handler always interrupts a blocked call to one of these
functions, regardless
       of the use of the sigaction(2) SA_RESTART flag.

POSIX.1-2001.
------------


And "man 7 signal" of "RHEL6.0 Beta"(*) says:
------------
       If a blocked call to one of the following interfaces is interrupted
by
       a  signal handler, then the call will be automatically restarted
after
       the signal handler returns if the SA_RESTART flag was used;
otherwise
       the call will fail with the error EINTR:

[...]

           * POSIX  semaphore  interfaces:  sem_wait(3)  and
sem_timedwait(3)
             (since Linux 2.6.22; beforehand, always failed with EINTR).

[...]

   Interruption of System Calls and Library Functions by Stop Signals
       On Linux, even in the absence of  signal  handlers,  certain
blocking
       interfaces  can fail with the error EINTR after the process is
stopped
       by one of the  stop  signals  and  then  resumed  via  SIGCONT.
This
       behavior is not sanctioned by POSIX.1, and doesn’t occur on other
sys-
       tems.

[...]

           * Linux 2.6.21 and earlier: futex(2) FUTEX_WAIT,
sem_timedwait(3),
             sem_wait(3).

------------
(*) -- Above description didn't exist in "man" of RHEL4.8/5.5.
       But "man" of RHEL6.0 Beta says that "sem_wait()" failed in the
       version earlier than Linux 2.6.22.


Therefore, These 26 tests are useful after 2.6.22 version, I think.

I tried to revised "testcases/open_posix_testsuite/conformance/interfaces/
sigaction/templates/template_16-1.in"

============
---
a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/templates/
template_16-1.in	2010-10-14 03:58:31.000000000 +0900
+++
b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/templates/
template_16-1.new	2010-10-18 17:47:40.000000000 +0900
@@ -55,6 +55,8 @@
 #include <signal.h>
 #include <errno.h>

+#include <sys/utsname.h>
+

/***************************************************************************
***/
 /***************************   Test framework
*******************************/

/***************************************************************************
***/
@@ -124,6 +126,23 @@
 	return NULL;
 }

+/* Checking for Kernel Version function */
+int kernel_ver_cmp(int k1, int k2, int k3)
+{
+	struct utsname buf;
+	int r1, r2, r3;
+
+	uname(&buf);
+	sscanf(buf.release, "%d.%d.%d", &r1, &r2, &r3);
+	if (r1 > k1)
+		return 0;
+	if (r2 > k2)
+		return 0;
+	if (r3 > k3)
+		return 0;
+	return 1;
+}
+
 /* main function */
 int main()
 {
@@ -133,6 +152,12 @@

 	struct sigaction sa;

+	/* Checking for Kernel Version */
+	if ( kernel_ver_cmp(2, 6, 21) != 0 )
+	{
+		UNTESTED( "sem_wait() returned EINTR on kernel versions
lower than 2.6.22" );
+	}
+
 	/* Initialize output */
 	output_init();

============

Above patch is revision only for templates.
The following procedure is necessary after applying patch:
------------
#cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
#./gentests.pl
------------

Similar revisions are necessary for other 25 "sigaction" tests.



Regards--

-Tomonori Mitani

----=_NextPart_ST_15_22_06_Monday_November_01_2010_8485
Content-Type: application/octet-stream;
	name="template_16-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="template_16-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/templ=
ates/template_16-1.in=092010-10-14 03:58:31.000000000 +0900=0A+++ b/testcas=
es/open_posix_testsuite/conformance/interfaces/sigaction/templates/template=
_16-1.new=092010-10-18 17:47:40.000000000 +0900=0A@@ -55,6 +55,8 @@=0A #inc=
lude <signal.h>=0A #include <errno.h>=0A =0A+#include <sys/utsname.h>=0A+=0A=
 /*************************************************************************=
*****/=0A /***************************   Test framework   *****************=
**************/=0A /*******************************************************=
***********************/=0A@@ -124,6 +126,23 @@=0A =09return NULL;=0A }=0A =
=0A+/* Checking for Kernel Version function */=0A+int kernel_ver_cmp(int k1=
, int k2, int k3)=0A+{=0A+=09struct utsname buf;=0A+=09int r1, r2, r3;=0A+=0A=
+=09uname(&buf);=0A+=09sscanf(buf.release, "%d.%d.%d", &r1, &r2, &r3);=0A+=09=
if (r1 > k1)=0A+=09=09return 0;=0A+=09if (r2 > k2)=0A+=09=09return 0;=0A+=09=
if (r3 > k3)=0A+=09=09return 0;=0A+=09return 1;=0A+}=0A+=0A /* main functio=
n */=0A int main()=0A {=0A@@ -133,6 +152,12 @@=0A =0A =09struct sigaction s=
a;=0A =0A+=09/* Checking for Kernel Version */=0A+=09if ( kernel_ver_cmp(2,=
 6, 21) !=3D 0 )=0A+=09{=0A+=09=09UNTESTED( "sem_wait() returned EINTR on k=
ernel versions lower than 2.6.22" );=0A+=09}=0A+=0A =09/* Initialize output=
 */=0A =09output_init();=0A =0A
----=_NextPart_ST_15_22_06_Monday_November_01_2010_8485
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
----=_NextPart_ST_15_22_06_Monday_November_01_2010_8485
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_15_22_06_Monday_November_01_2010_8485--

