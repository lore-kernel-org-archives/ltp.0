Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MZKMc-00075z-6a
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 07:59:46 +0000
Received: from mail-yx0-f174.google.com ([209.85.210.174])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZKMV-0004Ck-Rr
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 07:59:46 +0000
Received: by yxe4 with SMTP id 4so1869137yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Aug 2009 00:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
	<20090721044529.GB9807@jenkins.home.ifup.org>
	<f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
Date: Fri, 7 Aug 2009 13:29:34 +0530
Message-ID: <f5a7b3810908070059x33ffce53n6b00e999232101e2@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd6a87ced0e200470889d81
Subject: Re: [LTP] [PATCH v2] mq_send/5-1.c: Fix race conditions in the test
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
To: Brandon Philips <bphilips@suse.de>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

--000e0cd6a87ced0e200470889d81
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Brandon Philips,

On Tue, Jul 21, 2009 at 6:52 PM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> On Tue, Jul 21, 2009 at 10:15 AM, Brandon Philips<bphilips@suse.de> wrote=
:
>> On 12:35 Tue 30 Jun 2009, naresh kamboju wrote:
>>> I have noticed some issue with your patch dated on 12-Dec-2008.
>>> I want conform the problem and root cause.
>>
>> What is the problem?
>
> After applying you=92re Patch to
> Include/posixtest.h
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.html
>
> Most of the mq_ and other test cases are failed at Build and linking.
> It was almost of the test cases total test case are 1888.
>
> After that I have removed your patch and executed test suite it is workin=
g fine.
>
> I think you have to revisit your patch and get the difference at your end=
.
>
>>
>>> Could you send me your open posix full Results logs of before and
>>> after your patch with ARCH and Kernel versions?
>>
>> I never ran the full test suite. To be honest I could never figure out
>> how to get it running. Are there instructions somewhere?
>>
>> My fix was triggered by a bug report I got that thought it found a
>> Kernel regression based on this test and it looked to me like it was
>> caused by that bug.
>
> Yes.
> There are Docs to do that.
> #Remove your patch dated Dec 12 =A02008
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.html
>
>
> # vim LDFLAGS
> Uncomment following line.
>
> #Recommended flags:
> -D_XOPEN_SOURCE=3D600 -lpthread -lrt -lm
>
> FULL Execution:
> Simple command is =93make=94
> #pwd
> ltp-full-20090630/testcases/open_posix_testsuite
> #make
>
> Single DIR Execution:
> You can build only one directory of test cases
> # export POSIX_TARGET=3Dconformance/interfaces/mq_send/
> #make
>
> Please read the followind Documents
> 1. BUILD
> - describes how to set up your developer machine to build and test
> 2. LDFLAGS
> - File that Makefile uses to link to what you specify
> 3. QUICK-START
> - Quick doc to help you around POSIX** Test Suite.
>
> Please share the full results log of your test.
>
> Best regards,
> Naresh Kamboju
>
>>
>> Cheers,
>>
>> =A0 =A0 =A0 =A0Brandon
>>
>
I have noticed issues for patch applied on 12-Dec-2008.
Because it is fixing the mq_send/5-1.c problem, but at the same time
patch is affecting the building of few test cases in the same
directory.
I have listed the build log before and after the patch.
So I have modified the patch such a way that it should not affect
other test cases.

Modifications:
1.	remove function definitions from =93include/posixtest.h=94
2.	add function definitions to new header file =93include/mq_send.h=94
3.	add #include =94mq_send.h=94 line to mq_send/5-1.c test cases

I have attached modified patch and below.
Please review the same.

Best regards,
Naresh Kamboju

/*****************************************************************/
Before current patch
/*****************************************************************/

#export  POSIX_TARGET=3Dconformance/interfaces/mq_send/
# make
conformance/interfaces/mq_send/8-1: build: FAILED
conformance/interfaces/mq_send/4-1: build: FAILED
conformance/interfaces/mq_send/10-1: build: PASS
conformance/interfaces/mq_send/10-1: link: PASS
conformance/interfaces/mq_send/9-1: build: PASS
conformance/interfaces/mq_send/9-1: link: PASS
conformance/interfaces/mq_send/14-1: build: PASS
conformance/interfaces/mq_send/14-1: link: PASS
conformance/interfaces/mq_send/7-1: build: PASS
conformance/interfaces/mq_send/7-1: link: PASS
conformance/interfaces/mq_send/13-1: build: PASS
conformance/interfaces/mq_send/13-1: link: PASS
conformance/interfaces/mq_send/11-2: build: PASS
conformance/interfaces/mq_send/11-2: link: PASS
conformance/interfaces/mq_send/3-2: build: FAILED
conformance/interfaces/mq_send/4-3: build: FAILED
conformance/interfaces/mq_send/2-1: build: FAILED
conformance/interfaces/mq_send/11-1: build: PASS
conformance/interfaces/mq_send/11-1: link: PASS
conformance/interfaces/mq_send/4-2: build: FAILED
conformance/interfaces/mq_send/3-1: build: FAILED
conformance/interfaces/mq_send/5-2: build: PASS
conformance/interfaces/mq_send/5-2: link: PASS
conformance/interfaces/mq_send/6-1: build: FAILED
conformance/interfaces/mq_send/1-1: build: FAILED
conformance/interfaces/mq_send/12-1: build: PASS
conformance/interfaces/mq_send/12-1: link: PASS
conformance/interfaces/mq_send/5-1: build: PASS
conformance/interfaces/mq_send/5-1: link: PASS

/*****************************************************************/
After current patch
/*****************************************************************/
#export  POSIX_TARGET=3Dconformance/interfaces/mq_send/
#make
conformance/interfaces/mq_send/8-1: build: PASS
conformance/interfaces/mq_send/8-1: link: PASS
conformance/interfaces/mq_send/4-1: build: PASS
conformance/interfaces/mq_send/4-1: link: PASS
conformance/interfaces/mq_send/10-1: build: PASS
conformance/interfaces/mq_send/10-1: link: PASS
conformance/interfaces/mq_send/9-1: build: PASS
conformance/interfaces/mq_send/9-1: link: PASS
conformance/interfaces/mq_send/14-1: build: PASS
conformance/interfaces/mq_send/14-1: link: PASS
conformance/interfaces/mq_send/7-1: build: PASS
conformance/interfaces/mq_send/7-1: link: PASS
conformance/interfaces/mq_send/13-1: build: PASS
conformance/interfaces/mq_send/13-1: link: PASS
conformance/interfaces/mq_send/11-2: build: PASS
conformance/interfaces/mq_send/11-2: link: PASS
conformance/interfaces/mq_send/3-2: build: PASS
conformance/interfaces/mq_send/3-2: link: PASS
conformance/interfaces/mq_send/4-3: build: PASS
conformance/interfaces/mq_send/4-3: link: PASS
conformance/interfaces/mq_send/2-1: build: PASS
conformance/interfaces/mq_send/2-1: link: PASS
conformance/interfaces/mq_send/11-1: build: PASS
conformance/interfaces/mq_send/11-1: link: PASS
conformance/interfaces/mq_send/4-2: build: PASS
conformance/interfaces/mq_send/4-2: link: PASS
conformance/interfaces/mq_send/3-1: build: PASS
conformance/interfaces/mq_send/3-1: link: PASS
conformance/interfaces/mq_send/5-2: build: PASS
conformance/interfaces/mq_send/5-2: link: PASS
conformance/interfaces/mq_send/6-1: build: PASS
conformance/interfaces/mq_send/6-1: link: PASS
conformance/interfaces/mq_send/1-1: build: PASS
conformance/interfaces/mq_send/1-1: link: PASS
conformance/interfaces/mq_send/12-1: build: PASS
conformance/interfaces/mq_send/12-1: link: PASS
conformance/interfaces/mq_send/5-1: build: PASS
conformance/interfaces/mq_send/5-1: link: PASS
/*****************************************************************/
Results:
/*****************************************************************/
conformance/interfaces/mq_send/10-1.test:execution:PASS
conformance/interfaces/mq_send/14-1.test:execution:PASS
conformance/interfaces/mq_send/12-1.test:execution:PASS
conformance/interfaces/mq_send/11-1.test:execution:PASS
conformance/interfaces/mq_send/9-1.test:execution:PASS
conformance/interfaces/mq_send/3-1.test:execution:PASS
conformance/interfaces/mq_send/4-3.test:execution:PASS
conformance/interfaces/mq_send/8-1.test:execution:PASS
conformance/interfaces/mq_send/7-1.test:execution:PASS
conformance/interfaces/mq_send/13-1.test:execution:PASS
conformance/interfaces/mq_send/1-1.test:execution:PASS
conformance/interfaces/mq_send/5-2.test:execution:PASS
conformance/interfaces/mq_send/5-1.test:execution:PASS
conformance/interfaces/mq_send/2-1.test:execution:PASS
conformance/interfaces/mq_send/6-1.test:execution:UNTESTED
conformance/interfaces/mq_send/4-1.test:execution:PASS
conformance/interfaces/mq_send/11-2.test:execution:PASS
conformance/interfaces/mq_send/4-2.test:execution:PASS
conformance/interfaces/mq_send/3-2.test:execution:PASS

/*****************************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_send=
/5-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2=
008-12-12
18:26:25.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2=
009-08-07
11:29:42.000000000 +0530
@@ -37,6 +37,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "posixtest.h"
+#include "mq_send.h"

 #define NAMESIZE 50
 #define MSGSTR "0123456789"
diff -Naurb a/testcases/open_posix_testsuite/include/mq_send.h
b/testcases/open_posix_testsuite/include/mq_send.h
--- a/testcases/open_posix_testsuite/include/mq_send.h	1970-01-01
05:30:00.000000000 +0530
+++ b/testcases/open_posix_testsuite/include/mq_send.h	2009-08-07
11:28:41.000000000 +0530
@@ -0,0 +1,92 @@
+
+/*
+ * Copyright (c) 2002, Intel Corporation. All rights reserved.
+ * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
+ * This file is licensed under the GPL license.  For the full content
+ * of this license, see the COPYING file at the top level of this
+ * source tree.
+ */
+
+
+#include <sys/select.h>
+
+
+int sync_pipe_create(int fd[])
+{
+        return pipe (fd);
+}
+
+int sync_pipe_close(int fd[])
+{
+        int r =3D 0;
+
+        if (fd[0] !=3D -1)
+                r =3D close (fd[0]);
+        if (fd[1] !=3D -1)
+                r |=3D close (fd[1]);
+        return r;
+}
+
+int sync_pipe_wait(int fd[])
+{
+        char buf;
+        int r;
+
+        if (fd[1] !=3D -1) {
+                close (fd[1]);
+                fd[1] =3D -1;
+        }
+
+        r =3D read (fd[0], &buf, 1);
+
+        if ((r !=3D 1) || (buf !=3D 'A'))
+                return -1;
+        return 0;
+}
+
+int sync_pipe_wait_select(int fd[], long tv_sec)
+{
+        char buf;
+        int r;
+       fd_set rfds;
+       struct timeval tv;
+       int err;
+
+       tv.tv_sec =3D tv_sec;
+       tv.tv_usec =3D 0;
+
+        if (fd[1] !=3D -1) {
+                close (fd[1]);
+                fd[1] =3D -1;
+        }
+
+       FD_ZERO(&rfds);
+       FD_SET(fd[0], &rfds);
+
+       r =3D select(fd[0] + 1, &rfds, NULL, NULL, &tv);
+       err =3D errno;
+
+       if (FD_ISSET(fd[0], &rfds)) {
+               return sync_pipe_wait(fd);
+       }
+
+       return r ? err : -ETIMEDOUT;
+}
+
+
+int sync_pipe_notify(int fd[])
+{
+        char buf =3D 'A';
+        int r;
+
+        if (fd[0] !=3D -1) {
+                close (fd[0]);
+                fd[0] =3D -1;
+        }
+
+        r =3D write (fd[1], &buf, 1);
+
+        if (r !=3D 1)
+                return -1;
+        return 0;
+}
diff -Naurb a/testcases/open_posix_testsuite/include/posixtest.h
b/testcases/open_posix_testsuite/include/posixtest.h
--- a/testcases/open_posix_testsuite/include/posixtest.h	2009-08-06
21:49:42.000000000 +0530
+++ b/testcases/open_posix_testsuite/include/posixtest.h	2009-08-07
11:28:41.000000000 +0530
@@ -15,86 +15,3 @@
 #define PTS_UNSUPPORTED 4
 #define PTS_UNTESTED    5

-
-#include <sys/select.h>
-
-
-int sync_pipe_create(int fd[])
-{
-        return pipe (fd);
-}
-
-int sync_pipe_close(int fd[])
-{
-        int r =3D 0;
-
-        if (fd[0] !=3D -1)
-                r =3D close (fd[0]);
-        if (fd[1] !=3D -1)
-                r |=3D close (fd[1]);
-        return r;
-}
-
-int sync_pipe_wait(int fd[])
-{
-        char buf;
-        int r;
-
-        if (fd[1] !=3D -1) {
-                close (fd[1]);
-                fd[1] =3D -1;
-        }
-
-        r =3D read (fd[0], &buf, 1);
-
-        if ((r !=3D 1) || (buf !=3D 'A'))
-                return -1;
-        return 0;
-}
-
-int sync_pipe_wait_select(int fd[], long tv_sec)
-{
-        char buf;
-        int r;
-       fd_set rfds;
-       struct timeval tv;
-       int err;
-
-       tv.tv_sec =3D tv_sec;
-       tv.tv_usec =3D 0;
-
-        if (fd[1] !=3D -1) {
-                close (fd[1]);
-                fd[1] =3D -1;
-        }
-
-       FD_ZERO(&rfds);
-       FD_SET(fd[0], &rfds);
-
-       r =3D select(fd[0] + 1, &rfds, NULL, NULL, &tv);
-       err =3D errno;
-
-       if (FD_ISSET(fd[0], &rfds)) {
-               return sync_pipe_wait(fd);
-       }
-
-       return r ? err : -ETIMEDOUT;
-}
-
-
-int sync_pipe_notify(int fd[])
-{
-        char buf =3D 'A';
-        int r;
-
-        if (fd[0] !=3D -1) {
-                close (fd[0]);
-                fd[0] =3D -1;
-        }
-
-        r =3D write (fd[1], &buf, 1);
-
-        if (r !=3D 1)
-                return -1;
-        return 0;
-}

--000e0cd6a87ced0e200470889d81
Content-Type: application/octet-stream; name="ltp-fix-mq_send_5-1.patch"
Content-Disposition: attachment; filename="ltp-fix-mq_send_5-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fy2mk6y00

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tcV9zZW5kLzUtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfc2VuZC81LTEuYwotLS0gYS90ZXN0Y2FzZXMvb3Bl
bl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV9zZW5kLzUtMS5jCTIw
MDgtMTItMTIgMTg6MjY6MjUuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bv
c2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21xX3NlbmQvNS0xLmMJMjAwOS0w
OC0wNyAxMToyOTo0Mi4wMDAwMDAwMDAgKzA1MzAKQEAgLTM3LDYgKzM3LDcgQEAKICNpbmNsdWRl
IDxzaWduYWwuaD4KICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUgInBvc2l4dGVzdC5oIgor
I2luY2x1ZGUgIm1xX3NlbmQuaCIKIAogI2RlZmluZSBOQU1FU0laRSA1MAogI2RlZmluZSBNU0dT
VFIgIjAxMjM0NTY3ODkiCmRpZmYgLU5hdXJiIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1
aXRlL2luY2x1ZGUvbXFfc2VuZC5oIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2lu
Y2x1ZGUvbXFfc2VuZC5oCi0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9pbmNs
dWRlL21xX3NlbmQuaAkxOTcwLTAxLTAxIDA1OjMwOjAwLjAwMDAwMDAwMCArMDUzMAorKysgYi90
ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvaW5jbHVkZS9tcV9zZW5kLmgJMjAwOS0wOC0w
NyAxMToyODo0MS4wMDAwMDAwMDAgKzA1MzAKQEAgLTAsMCArMSw5MiBAQAorCisvKgorICogQ29w
eXJpZ2h0IChjKSAyMDAyLCBJbnRlbCBDb3Jwb3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4K
KyAqIENyZWF0ZWQgYnk6ICBqdWxpZS5uLmZsZWlzY2hlciBSRU1PVkUtVEhJUyBBVCBpbnRlbCBE
T1QgY29tCisgKiBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIEdQTCBsaWNlbnNlLiAg
Rm9yIHRoZSBmdWxsIGNvbnRlbnQKKyAqIG9mIHRoaXMgbGljZW5zZSwgc2VlIHRoZSBDT1BZSU5H
IGZpbGUgYXQgdGhlIHRvcCBsZXZlbCBvZiB0aGlzCisgKiBzb3VyY2UgdHJlZS4KKyAqLworCisK
KyNpbmNsdWRlIDxzeXMvc2VsZWN0Lmg+CisKKworaW50IHN5bmNfcGlwZV9jcmVhdGUoaW50IGZk
W10pCit7CisgICAgICAgIHJldHVybiBwaXBlIChmZCk7Cit9CisKK2ludCBzeW5jX3BpcGVfY2xv
c2UoaW50IGZkW10pCit7CisgICAgICAgIGludCByID0gMDsKKworICAgICAgICBpZiAoZmRbMF0g
IT0gLTEpCisgICAgICAgICAgICAgICAgciA9IGNsb3NlIChmZFswXSk7CisgICAgICAgIGlmIChm
ZFsxXSAhPSAtMSkKKyAgICAgICAgICAgICAgICByIHw9IGNsb3NlIChmZFsxXSk7CisgICAgICAg
IHJldHVybiByOworfQorCitpbnQgc3luY19waXBlX3dhaXQoaW50IGZkW10pCit7CisgICAgICAg
IGNoYXIgYnVmOworICAgICAgICBpbnQgcjsKKworICAgICAgICBpZiAoZmRbMV0gIT0gLTEpIHsK
KyAgICAgICAgICAgICAgICBjbG9zZSAoZmRbMV0pOworICAgICAgICAgICAgICAgIGZkWzFdID0g
LTE7CisgICAgICAgIH0KKworICAgICAgICByID0gcmVhZCAoZmRbMF0sICZidWYsIDEpOworCisg
ICAgICAgIGlmICgociAhPSAxKSB8fCAoYnVmICE9ICdBJykpCisgICAgICAgICAgICAgICAgcmV0
dXJuIC0xOworICAgICAgICByZXR1cm4gMDsKK30KKworaW50IHN5bmNfcGlwZV93YWl0X3NlbGVj
dChpbnQgZmRbXSwgbG9uZyB0dl9zZWMpCit7CisgICAgICAgIGNoYXIgYnVmOworICAgICAgICBp
bnQgcjsKKyAgICAgICBmZF9zZXQgcmZkczsKKyAgICAgICBzdHJ1Y3QgdGltZXZhbCB0djsKKyAg
ICAgICBpbnQgZXJyOworCisgICAgICAgdHYudHZfc2VjID0gdHZfc2VjOworICAgICAgIHR2LnR2
X3VzZWMgPSAwOworCisgICAgICAgIGlmIChmZFsxXSAhPSAtMSkgeworICAgICAgICAgICAgICAg
IGNsb3NlIChmZFsxXSk7CisgICAgICAgICAgICAgICAgZmRbMV0gPSAtMTsKKyAgICAgICAgfQor
CisgICAgICAgRkRfWkVSTygmcmZkcyk7CisgICAgICAgRkRfU0VUKGZkWzBdLCAmcmZkcyk7CisK
KyAgICAgICByID0gc2VsZWN0KGZkWzBdICsgMSwgJnJmZHMsIE5VTEwsIE5VTEwsICZ0dik7Cisg
ICAgICAgZXJyID0gZXJybm87CisKKyAgICAgICBpZiAoRkRfSVNTRVQoZmRbMF0sICZyZmRzKSkg
eworICAgICAgICAgICAgICAgcmV0dXJuIHN5bmNfcGlwZV93YWl0KGZkKTsKKyAgICAgICB9CisK
KyAgICAgICByZXR1cm4gciA/IGVyciA6IC1FVElNRURPVVQ7Cit9CisKKworaW50IHN5bmNfcGlw
ZV9ub3RpZnkoaW50IGZkW10pCit7CisgICAgICAgIGNoYXIgYnVmID0gJ0EnOworICAgICAgICBp
bnQgcjsKKworICAgICAgICBpZiAoZmRbMF0gIT0gLTEpIHsKKyAgICAgICAgICAgICAgICBjbG9z
ZSAoZmRbMF0pOworICAgICAgICAgICAgICAgIGZkWzBdID0gLTE7CisgICAgICAgIH0KKworICAg
ICAgICByID0gd3JpdGUgKGZkWzFdLCAmYnVmLCAxKTsKKworICAgICAgICBpZiAociAhPSAxKQor
ICAgICAgICAgICAgICAgIHJldHVybiAtMTsKKyAgICAgICAgcmV0dXJuIDA7Cit9CmRpZmYgLU5h
dXJiIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2luY2x1ZGUvcG9zaXh0ZXN0Lmgg
Yi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvaW5jbHVkZS9wb3NpeHRlc3QuaAotLS0g
YS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvaW5jbHVkZS9wb3NpeHRlc3QuaAkyMDA5
LTA4LTA2IDIxOjQ5OjQyLjAwMDAwMDAwMCArMDUzMAorKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvaW5jbHVkZS9wb3NpeHRlc3QuaAkyMDA5LTA4LTA3IDExOjI4OjQxLjAwMDAw
MDAwMCArMDUzMApAQCAtMTUsODYgKzE1LDMgQEAKICNkZWZpbmUgUFRTX1VOU1VQUE9SVEVEIDQK
ICNkZWZpbmUgUFRTX1VOVEVTVEVEICAgIDUKIAotCi0jaW5jbHVkZSA8c3lzL3NlbGVjdC5oPgot
Ci0KLWludCBzeW5jX3BpcGVfY3JlYXRlKGludCBmZFtdKQotewotICAgICAgICByZXR1cm4gcGlw
ZSAoZmQpOwotfQotCi1pbnQgc3luY19waXBlX2Nsb3NlKGludCBmZFtdKQotewotICAgICAgICBp
bnQgciA9IDA7Ci0KLSAgICAgICAgaWYgKGZkWzBdICE9IC0xKQotICAgICAgICAgICAgICAgIHIg
PSBjbG9zZSAoZmRbMF0pOwotICAgICAgICBpZiAoZmRbMV0gIT0gLTEpCi0gICAgICAgICAgICAg
ICAgciB8PSBjbG9zZSAoZmRbMV0pOwotICAgICAgICByZXR1cm4gcjsKLX0KLQotaW50IHN5bmNf
cGlwZV93YWl0KGludCBmZFtdKQotewotICAgICAgICBjaGFyIGJ1ZjsKLSAgICAgICAgaW50IHI7
Ci0KLSAgICAgICAgaWYgKGZkWzFdICE9IC0xKSB7Ci0gICAgICAgICAgICAgICAgY2xvc2UgKGZk
WzFdKTsKLSAgICAgICAgICAgICAgICBmZFsxXSA9IC0xOwotICAgICAgICB9Ci0KLSAgICAgICAg
ciA9IHJlYWQgKGZkWzBdLCAmYnVmLCAxKTsKLQotICAgICAgICBpZiAoKHIgIT0gMSkgfHwgKGJ1
ZiAhPSAnQScpKQotICAgICAgICAgICAgICAgIHJldHVybiAtMTsKLSAgICAgICAgcmV0dXJuIDA7
Ci19Ci0KLWludCBzeW5jX3BpcGVfd2FpdF9zZWxlY3QoaW50IGZkW10sIGxvbmcgdHZfc2VjKQot
ewotICAgICAgICBjaGFyIGJ1ZjsKLSAgICAgICAgaW50IHI7Ci0gICAgICAgZmRfc2V0IHJmZHM7
Ci0gICAgICAgc3RydWN0IHRpbWV2YWwgdHY7Ci0gICAgICAgaW50IGVycjsKLQotICAgICAgIHR2
LnR2X3NlYyA9IHR2X3NlYzsKLSAgICAgICB0di50dl91c2VjID0gMDsKLQotICAgICAgICBpZiAo
ZmRbMV0gIT0gLTEpIHsKLSAgICAgICAgICAgICAgICBjbG9zZSAoZmRbMV0pOwotICAgICAgICAg
ICAgICAgIGZkWzFdID0gLTE7Ci0gICAgICAgIH0KLQotICAgICAgIEZEX1pFUk8oJnJmZHMpOwot
ICAgICAgIEZEX1NFVChmZFswXSwgJnJmZHMpOwotCi0gICAgICAgciA9IHNlbGVjdChmZFswXSAr
IDEsICZyZmRzLCBOVUxMLCBOVUxMLCAmdHYpOwotICAgICAgIGVyciA9IGVycm5vOwotCi0gICAg
ICAgaWYgKEZEX0lTU0VUKGZkWzBdLCAmcmZkcykpIHsKLSAgICAgICAgICAgICAgIHJldHVybiBz
eW5jX3BpcGVfd2FpdChmZCk7Ci0gICAgICAgfQotCi0gICAgICAgcmV0dXJuIHIgPyBlcnIgOiAt
RVRJTUVET1VUOwotfQotCi0KLWludCBzeW5jX3BpcGVfbm90aWZ5KGludCBmZFtdKQotewotICAg
ICAgICBjaGFyIGJ1ZiA9ICdBJzsKLSAgICAgICAgaW50IHI7Ci0KLSAgICAgICAgaWYgKGZkWzBd
ICE9IC0xKSB7Ci0gICAgICAgICAgICAgICAgY2xvc2UgKGZkWzBdKTsKLSAgICAgICAgICAgICAg
ICBmZFswXSA9IC0xOwotICAgICAgICB9Ci0KLSAgICAgICAgciA9IHdyaXRlIChmZFsxXSwgJmJ1
ZiwgMSk7Ci0KLSAgICAgICAgaWYgKHIgIT0gMSkKLSAgICAgICAgICAgICAgICByZXR1cm4gLTE7
Ci0gICAgICAgIHJldHVybiAwOwotfQo=
--000e0cd6a87ced0e200470889d81
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd6a87ced0e200470889d81
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd6a87ced0e200470889d81--

