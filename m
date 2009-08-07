Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MZRbD-0005l0-JQ
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 15:43:19 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZRb8-0008MF-Lh
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 15:43:19 +0000
Received: by mail-gx0-f220.google.com with SMTP id 20so4448842gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Aug 2009 08:43:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1249648941.4851.47.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
	<20090721044529.GB9807@jenkins.home.ifup.org>
	<f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
	<f5a7b3810908070059x33ffce53n6b00e999232101e2@mail.gmail.com>
	<1249648941.4851.47.camel@subratamodak.linux.ibm.com>
Date: Fri, 7 Aug 2009 21:13:13 +0530
Message-ID: <f5a7b3810908070843r77eb24b3i57a8ce4a6a929362@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd6a87c13660f04708f186d
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>

--000e0cd6a87c13660f04708f186d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 7, 2009 at 6:12 PM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> Hi,
>
> On Fri, 2009-08-07 at 13:29 +0530, naresh kamboju wrote:
>> Hi Brandon Philips,
>>
>> On Tue, Jul 21, 2009 at 6:52 PM, naresh kamboju<naresh.kernel@gmail.com>=
 wrote:
>> > On Tue, Jul 21, 2009 at 10:15 AM, Brandon Philips<bphilips@suse.de> wr=
ote:
>> >> On 12:35 Tue 30 Jun 2009, naresh kamboju wrote:
>> >>> I have noticed some issue with your patch dated on 12-Dec-2008.
>> >>> I want conform the problem and root cause.
>> >>
>> >> What is the problem?
>> >
>> > After applying you=92re Patch to
>> > Include/posixtest.h
>> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.ht=
ml
>> >
>> > Most of the mq_ and other test cases are failed at Build and linking.
>> > It was almost of the test cases total test case are 1888.
>> >
>> > After that I have removed your patch and executed test suite it is wor=
king fine.
>> >
>> > I think you have to revisit your patch and get the difference at your =
end.
>> >
>> >>
>> >>> Could you send me your open posix full Results logs of before and
>> >>> after your patch with ARCH and Kernel versions?
>> >>
>> >> I never ran the full test suite. To be honest I could never figure ou=
t
>> >> how to get it running. Are there instructions somewhere?
>> >>
>> >> My fix was triggered by a bug report I got that thought it found a
>> >> Kernel regression based on this test and it looked to me like it was
>> >> caused by that bug.
>> >
>> > Yes.
>> > There are Docs to do that.
>> > #Remove your patch dated Dec 12 =A02008
>> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg04867.ht=
ml
>> >
>> >
>> > # vim LDFLAGS
>> > Uncomment following line.
>> >
>> > #Recommended flags:
>> > -D_XOPEN_SOURCE=3D600 -lpthread -lrt -lm
>> >
>> > FULL Execution:
>> > Simple command is =93make=94
>> > #pwd
>> > ltp-full-20090630/testcases/open_posix_testsuite
>> > #make
>> >
>> > Single DIR Execution:
>> > You can build only one directory of test cases
>> > # export POSIX_TARGET=3Dconformance/interfaces/mq_send/
>> > #make
>> >
>> > Please read the followind Documents
>> > 1. BUILD
>> > - describes how to set up your developer machine to build and test
>> > 2. LDFLAGS
>> > - File that Makefile uses to link to what you specify
>> > 3. QUICK-START
>> > - Quick doc to help you around POSIX** Test Suite.
>> >
>> > Please share the full results log of your test.
>> >
>> > Best regards,
>> > Naresh Kamboju
>> >
>> >>
>> >> Cheers,
>> >>
>> >> =A0 =A0 =A0 =A0Brandon
>> >>
>> >
>> I have noticed issues for patch applied on 12-Dec-2008.
>> Because it is fixing the mq_send/5-1.c problem, but at the same time
>> patch is affecting the building of few test cases in the same
>> directory.
>> I have listed the build log before and after the patch.
>> So I have modified the patch such a way that it should not affect
>> other test cases.
>>
>> Modifications:
>> 1. =A0 =A0remove function definitions from =93include/posixtest.h=94
>> 2. =A0 =A0add function definitions to new header file =93include/mq_send=
.h=94
>> 3. =A0 =A0add #include =94mq_send.h=94 line to mq_send/5-1.c test cases
>>
>> I have attached modified patch and below.
>> Please review the same.
>>
>> Best regards,
>> Naresh Kamboju
>>
>> /*****************************************************************/
>> Before current patch
>> /*****************************************************************/
>>
>> #export =A0POSIX_TARGET=3Dconformance/interfaces/mq_send/
>> # make
>> conformance/interfaces/mq_send/8-1: build: FAILED
>> conformance/interfaces/mq_send/4-1: build: FAILED
>> conformance/interfaces/mq_send/10-1: build: PASS
>> conformance/interfaces/mq_send/10-1: link: PASS
>> conformance/interfaces/mq_send/9-1: build: PASS
>> conformance/interfaces/mq_send/9-1: link: PASS
>> conformance/interfaces/mq_send/14-1: build: PASS
>> conformance/interfaces/mq_send/14-1: link: PASS
>> conformance/interfaces/mq_send/7-1: build: PASS
>> conformance/interfaces/mq_send/7-1: link: PASS
>> conformance/interfaces/mq_send/13-1: build: PASS
>> conformance/interfaces/mq_send/13-1: link: PASS
>> conformance/interfaces/mq_send/11-2: build: PASS
>> conformance/interfaces/mq_send/11-2: link: PASS
>> conformance/interfaces/mq_send/3-2: build: FAILED
>> conformance/interfaces/mq_send/4-3: build: FAILED
>> conformance/interfaces/mq_send/2-1: build: FAILED
>> conformance/interfaces/mq_send/11-1: build: PASS
>> conformance/interfaces/mq_send/11-1: link: PASS
>> conformance/interfaces/mq_send/4-2: build: FAILED
>> conformance/interfaces/mq_send/3-1: build: FAILED
>> conformance/interfaces/mq_send/5-2: build: PASS
>> conformance/interfaces/mq_send/5-2: link: PASS
>> conformance/interfaces/mq_send/6-1: build: FAILED
>> conformance/interfaces/mq_send/1-1: build: FAILED
>> conformance/interfaces/mq_send/12-1: build: PASS
>> conformance/interfaces/mq_send/12-1: link: PASS
>> conformance/interfaces/mq_send/5-1: build: PASS
>> conformance/interfaces/mq_send/5-1: link: PASS
>>
>> /*****************************************************************/
>> After current patch
>> /*****************************************************************/
>> #export =A0POSIX_TARGET=3Dconformance/interfaces/mq_send/
>> #make
>> conformance/interfaces/mq_send/8-1: build: PASS
>> conformance/interfaces/mq_send/8-1: link: PASS
>> conformance/interfaces/mq_send/4-1: build: PASS
>> conformance/interfaces/mq_send/4-1: link: PASS
>> conformance/interfaces/mq_send/10-1: build: PASS
>> conformance/interfaces/mq_send/10-1: link: PASS
>> conformance/interfaces/mq_send/9-1: build: PASS
>> conformance/interfaces/mq_send/9-1: link: PASS
>> conformance/interfaces/mq_send/14-1: build: PASS
>> conformance/interfaces/mq_send/14-1: link: PASS
>> conformance/interfaces/mq_send/7-1: build: PASS
>> conformance/interfaces/mq_send/7-1: link: PASS
>> conformance/interfaces/mq_send/13-1: build: PASS
>> conformance/interfaces/mq_send/13-1: link: PASS
>> conformance/interfaces/mq_send/11-2: build: PASS
>> conformance/interfaces/mq_send/11-2: link: PASS
>> conformance/interfaces/mq_send/3-2: build: PASS
>> conformance/interfaces/mq_send/3-2: link: PASS
>> conformance/interfaces/mq_send/4-3: build: PASS
>> conformance/interfaces/mq_send/4-3: link: PASS
>> conformance/interfaces/mq_send/2-1: build: PASS
>> conformance/interfaces/mq_send/2-1: link: PASS
>> conformance/interfaces/mq_send/11-1: build: PASS
>> conformance/interfaces/mq_send/11-1: link: PASS
>> conformance/interfaces/mq_send/4-2: build: PASS
>> conformance/interfaces/mq_send/4-2: link: PASS
>> conformance/interfaces/mq_send/3-1: build: PASS
>> conformance/interfaces/mq_send/3-1: link: PASS
>> conformance/interfaces/mq_send/5-2: build: PASS
>> conformance/interfaces/mq_send/5-2: link: PASS
>> conformance/interfaces/mq_send/6-1: build: PASS
>> conformance/interfaces/mq_send/6-1: link: PASS
>> conformance/interfaces/mq_send/1-1: build: PASS
>> conformance/interfaces/mq_send/1-1: link: PASS
>> conformance/interfaces/mq_send/12-1: build: PASS
>> conformance/interfaces/mq_send/12-1: link: PASS
>> conformance/interfaces/mq_send/5-1: build: PASS
>> conformance/interfaces/mq_send/5-1: link: PASS
>> /*****************************************************************/
>> Results:
>> /*****************************************************************/
>> conformance/interfaces/mq_send/10-1.test:execution:PASS
>> conformance/interfaces/mq_send/14-1.test:execution:PASS
>> conformance/interfaces/mq_send/12-1.test:execution:PASS
>> conformance/interfaces/mq_send/11-1.test:execution:PASS
>> conformance/interfaces/mq_send/9-1.test:execution:PASS
>> conformance/interfaces/mq_send/3-1.test:execution:PASS
>> conformance/interfaces/mq_send/4-3.test:execution:PASS
>> conformance/interfaces/mq_send/8-1.test:execution:PASS
>> conformance/interfaces/mq_send/7-1.test:execution:PASS
>> conformance/interfaces/mq_send/13-1.test:execution:PASS
>> conformance/interfaces/mq_send/1-1.test:execution:PASS
>> conformance/interfaces/mq_send/5-2.test:execution:PASS
>> conformance/interfaces/mq_send/5-1.test:execution:PASS
>> conformance/interfaces/mq_send/2-1.test:execution:PASS
>> conformance/interfaces/mq_send/6-1.test:execution:UNTESTED
>> conformance/interfaces/mq_send/4-1.test:execution:PASS
>> conformance/interfaces/mq_send/11-2.test:execution:PASS
>> conformance/interfaces/mq_send/4-2.test:execution:PASS
>> conformance/interfaces/mq_send/3-2.test:execution:PASS
>>
>> /*****************************************************************/
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_s=
end/5-1.c
>> b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.=
c =A0 =A0 2008-12-12
>> 18:26:25.000000000 +0530
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.=
c =A0 =A0 2009-08-07
>> 11:29:42.000000000 +0530
>> @@ -37,6 +37,7 @@
>> =A0#include <signal.h>
>> =A0#include <errno.h>
>> =A0#include "posixtest.h"
>> +#include "mq_send.h"
>>
>> =A0#define NAMESIZE 50
>> =A0#define MSGSTR "0123456789"
>> diff -Naurb a/testcases/open_posix_testsuite/include/mq_send.h
>> b/testcases/open_posix_testsuite/include/mq_send.h
>> --- a/testcases/open_posix_testsuite/include/mq_send.h =A0 =A0 =A0 =A019=
70-01-01
>> 05:30:00.000000000 +0530
>> +++ b/testcases/open_posix_testsuite/include/mq_send.h =A0 =A0 =A0 =A020=
09-08-07
>> 11:28:41.000000000 +0530
>> @@ -0,0 +1,92 @@
>> +
>> +/*
>> + * Copyright (c) 2002, Intel Corporation. All rights reserved.
>
> Can you please change this to:
> * Copyright (c) 2002, Intel Corporation.
>
> And then resend.

I am resending the same patch after this change.

Best regards,
Naresh Kamboju

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
+ * Copyright (c) 2002, Intel Corporation.
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

>
> Regards--
> Subrata
>
>> + * Created by: =A0julie.n.fleischer REMOVE-THIS AT intel DOT com
>> + * This file is licensed under the GPL license. =A0For the full content
>> + * of this license, see the COPYING file at the top level of this
>> + * source tree.
>> + */
>> +
>> +
>> +#include <sys/select.h>
>> +
>> +
>> +int sync_pipe_create(int fd[])
>> +{
>> + =A0 =A0 =A0 =A0return pipe (fd);
>> +}
>> +
>> +int sync_pipe_close(int fd[])
>> +{
>> + =A0 =A0 =A0 =A0int r =3D 0;
>> +
>> + =A0 =A0 =A0 =A0if (fd[0] !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D close (fd[0]);
>> + =A0 =A0 =A0 =A0if (fd[1] !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r |=3D close (fd[1]);
>> + =A0 =A0 =A0 =A0return r;
>> +}
>> +
>> +int sync_pipe_wait(int fd[])
>> +{
>> + =A0 =A0 =A0 =A0char buf;
>> + =A0 =A0 =A0 =A0int r;
>> +
>> + =A0 =A0 =A0 =A0if (fd[1] !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[1] =3D -1;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0r =3D read (fd[0], &buf, 1);
>> +
>> + =A0 =A0 =A0 =A0if ((r !=3D 1) || (buf !=3D 'A'))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> + =A0 =A0 =A0 =A0return 0;
>> +}
>> +
>> +int sync_pipe_wait_select(int fd[], long tv_sec)
>> +{
>> + =A0 =A0 =A0 =A0char buf;
>> + =A0 =A0 =A0 =A0int r;
>> + =A0 =A0 =A0 fd_set rfds;
>> + =A0 =A0 =A0 struct timeval tv;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 tv.tv_sec =3D tv_sec;
>> + =A0 =A0 =A0 tv.tv_usec =3D 0;
>> +
>> + =A0 =A0 =A0 =A0if (fd[1] !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[1] =3D -1;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 FD_ZERO(&rfds);
>> + =A0 =A0 =A0 FD_SET(fd[0], &rfds);
>> +
>> + =A0 =A0 =A0 r =3D select(fd[0] + 1, &rfds, NULL, NULL, &tv);
>> + =A0 =A0 =A0 err =3D errno;
>> +
>> + =A0 =A0 =A0 if (FD_ISSET(fd[0], &rfds)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sync_pipe_wait(fd);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return r ? err : -ETIMEDOUT;
>> +}
>> +
>> +
>> +int sync_pipe_notify(int fd[])
>> +{
>> + =A0 =A0 =A0 =A0char buf =3D 'A';
>> + =A0 =A0 =A0 =A0int r;
>> +
>> + =A0 =A0 =A0 =A0if (fd[0] !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[0] =3D -1;
>> + =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0r =3D write (fd[1], &buf, 1);
>> +
>> + =A0 =A0 =A0 =A0if (r !=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> + =A0 =A0 =A0 =A0return 0;
>> +}
>> diff -Naurb a/testcases/open_posix_testsuite/include/posixtest.h
>> b/testcases/open_posix_testsuite/include/posixtest.h
>> --- a/testcases/open_posix_testsuite/include/posixtest.h =A0 =A0 =A02009=
-08-06
>> 21:49:42.000000000 +0530
>> +++ b/testcases/open_posix_testsuite/include/posixtest.h =A0 =A0 =A02009=
-08-07
>> 11:28:41.000000000 +0530
>> @@ -15,86 +15,3 @@
>> =A0#define PTS_UNSUPPORTED 4
>> =A0#define PTS_UNTESTED =A0 =A05
>>
>> -
>> -#include <sys/select.h>
>> -
>> -
>> -int sync_pipe_create(int fd[])
>> -{
>> - =A0 =A0 =A0 =A0return pipe (fd);
>> -}
>> -
>> -int sync_pipe_close(int fd[])
>> -{
>> - =A0 =A0 =A0 =A0int r =3D 0;
>> -
>> - =A0 =A0 =A0 =A0if (fd[0] !=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D close (fd[0]);
>> - =A0 =A0 =A0 =A0if (fd[1] !=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r |=3D close (fd[1]);
>> - =A0 =A0 =A0 =A0return r;
>> -}
>> -
>> -int sync_pipe_wait(int fd[])
>> -{
>> - =A0 =A0 =A0 =A0char buf;
>> - =A0 =A0 =A0 =A0int r;
>> -
>> - =A0 =A0 =A0 =A0if (fd[1] !=3D -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[1]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[1] =3D -1;
>> - =A0 =A0 =A0 =A0}
>> -
>> - =A0 =A0 =A0 =A0r =3D read (fd[0], &buf, 1);
>> -
>> - =A0 =A0 =A0 =A0if ((r !=3D 1) || (buf !=3D 'A'))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> - =A0 =A0 =A0 =A0return 0;
>> -}
>> -
>> -int sync_pipe_wait_select(int fd[], long tv_sec)
>> -{
>> - =A0 =A0 =A0 =A0char buf;
>> - =A0 =A0 =A0 =A0int r;
>> - =A0 =A0 =A0 fd_set rfds;
>> - =A0 =A0 =A0 struct timeval tv;
>> - =A0 =A0 =A0 int err;
>> -
>> - =A0 =A0 =A0 tv.tv_sec =3D tv_sec;
>> - =A0 =A0 =A0 tv.tv_usec =3D 0;
>> -
>> - =A0 =A0 =A0 =A0if (fd[1] !=3D -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[1]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[1] =3D -1;
>> - =A0 =A0 =A0 =A0}
>> -
>> - =A0 =A0 =A0 FD_ZERO(&rfds);
>> - =A0 =A0 =A0 FD_SET(fd[0], &rfds);
>> -
>> - =A0 =A0 =A0 r =3D select(fd[0] + 1, &rfds, NULL, NULL, &tv);
>> - =A0 =A0 =A0 err =3D errno;
>> -
>> - =A0 =A0 =A0 if (FD_ISSET(fd[0], &rfds)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sync_pipe_wait(fd);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 return r ? err : -ETIMEDOUT;
>> -}
>> -
>> -
>> -int sync_pipe_notify(int fd[])
>> -{
>> - =A0 =A0 =A0 =A0char buf =3D 'A';
>> - =A0 =A0 =A0 =A0int r;
>> -
>> - =A0 =A0 =A0 =A0if (fd[0] !=3D -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close (fd[0]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd[0] =3D -1;
>> - =A0 =A0 =A0 =A0}
>> -
>> - =A0 =A0 =A0 =A0r =3D write (fd[1], &buf, 1);
>> -
>> - =A0 =A0 =A0 =A0if (r !=3D 1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> - =A0 =A0 =A0 =A0return 0;
>> -}
>
>

--000e0cd6a87c13660f04708f186d
Content-Type: application/octet-stream; name="ltp-fix-mq_send_5-1.patch"
Content-Disposition: attachment; filename="ltp-fix-mq_send_5-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fy333t500

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tcV9zZW5kLzUtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfc2VuZC81LTEuYw0KLS0tIGEvdGVzdGNhc2VzL29w
ZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfc2VuZC81LTEuYwky
MDA4LTEyLTEyIDE4OjI2OjI1LjAwMDAwMDAwMCArMDUzMA0KKysrIGIvdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfc2VuZC81LTEuYwkyMDA5
LTA4LTA3IDExOjI5OjQyLjAwMDAwMDAwMCArMDUzMA0KQEAgLTM3LDYgKzM3LDcgQEANCiAjaW5j
bHVkZSA8c2lnbmFsLmg+DQogI2luY2x1ZGUgPGVycm5vLmg+DQogI2luY2x1ZGUgInBvc2l4dGVz
dC5oIg0KKyNpbmNsdWRlICJtcV9zZW5kLmgiDQogDQogI2RlZmluZSBOQU1FU0laRSA1MA0KICNk
ZWZpbmUgTVNHU1RSICIwMTIzNDU2Nzg5Ig0KZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvaW5jbHVkZS9tcV9zZW5kLmggYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUvaW5jbHVkZS9tcV9zZW5kLmgNCi0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rl
c3RzdWl0ZS9pbmNsdWRlL21xX3NlbmQuaAkxOTcwLTAxLTAxIDA1OjMwOjAwLjAwMDAwMDAwMCAr
MDUzMA0KKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2luY2x1ZGUvbXFfc2Vu
ZC5oCTIwMDktMDgtMDcgMTE6Mjg6NDEuMDAwMDAwMDAwICswNTMwDQpAQCAtMCwwICsxLDkyIEBA
DQorDQorLyoNCisgKiBDb3B5cmlnaHQgKGMpIDIwMDIsIEludGVsIENvcnBvcmF0aW9uLg0KKyAq
IENyZWF0ZWQgYnk6ICBqdWxpZS5uLmZsZWlzY2hlciBSRU1PVkUtVEhJUyBBVCBpbnRlbCBET1Qg
Y29tDQorICogVGhpcyBmaWxlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBHUEwgbGljZW5zZS4gIEZv
ciB0aGUgZnVsbCBjb250ZW50DQorICogb2YgdGhpcyBsaWNlbnNlLCBzZWUgdGhlIENPUFlJTkcg
ZmlsZSBhdCB0aGUgdG9wIGxldmVsIG9mIHRoaXMNCisgKiBzb3VyY2UgdHJlZS4NCisgKi8NCisN
CisNCisjaW5jbHVkZSA8c3lzL3NlbGVjdC5oPg0KKw0KKw0KK2ludCBzeW5jX3BpcGVfY3JlYXRl
KGludCBmZFtdKQ0KK3sNCisgICAgICAgIHJldHVybiBwaXBlIChmZCk7DQorfQ0KKw0KK2ludCBz
eW5jX3BpcGVfY2xvc2UoaW50IGZkW10pDQorew0KKyAgICAgICAgaW50IHIgPSAwOw0KKw0KKyAg
ICAgICAgaWYgKGZkWzBdICE9IC0xKQ0KKyAgICAgICAgICAgICAgICByID0gY2xvc2UgKGZkWzBd
KTsNCisgICAgICAgIGlmIChmZFsxXSAhPSAtMSkNCisgICAgICAgICAgICAgICAgciB8PSBjbG9z
ZSAoZmRbMV0pOw0KKyAgICAgICAgcmV0dXJuIHI7DQorfQ0KKw0KK2ludCBzeW5jX3BpcGVfd2Fp
dChpbnQgZmRbXSkNCit7DQorICAgICAgICBjaGFyIGJ1ZjsNCisgICAgICAgIGludCByOw0KKw0K
KyAgICAgICAgaWYgKGZkWzFdICE9IC0xKSB7DQorICAgICAgICAgICAgICAgIGNsb3NlIChmZFsx
XSk7DQorICAgICAgICAgICAgICAgIGZkWzFdID0gLTE7DQorICAgICAgICB9DQorDQorICAgICAg
ICByID0gcmVhZCAoZmRbMF0sICZidWYsIDEpOw0KKw0KKyAgICAgICAgaWYgKChyICE9IDEpIHx8
IChidWYgIT0gJ0EnKSkNCisgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KKyAgICAgICAgcmV0
dXJuIDA7DQorfQ0KKw0KK2ludCBzeW5jX3BpcGVfd2FpdF9zZWxlY3QoaW50IGZkW10sIGxvbmcg
dHZfc2VjKQ0KK3sNCisgICAgICAgIGNoYXIgYnVmOw0KKyAgICAgICAgaW50IHI7DQorICAgICAg
IGZkX3NldCByZmRzOw0KKyAgICAgICBzdHJ1Y3QgdGltZXZhbCB0djsNCisgICAgICAgaW50IGVy
cjsNCisNCisgICAgICAgdHYudHZfc2VjID0gdHZfc2VjOw0KKyAgICAgICB0di50dl91c2VjID0g
MDsNCisNCisgICAgICAgIGlmIChmZFsxXSAhPSAtMSkgew0KKyAgICAgICAgICAgICAgICBjbG9z
ZSAoZmRbMV0pOw0KKyAgICAgICAgICAgICAgICBmZFsxXSA9IC0xOw0KKyAgICAgICAgfQ0KKw0K
KyAgICAgICBGRF9aRVJPKCZyZmRzKTsNCisgICAgICAgRkRfU0VUKGZkWzBdLCAmcmZkcyk7DQor
DQorICAgICAgIHIgPSBzZWxlY3QoZmRbMF0gKyAxLCAmcmZkcywgTlVMTCwgTlVMTCwgJnR2KTsN
CisgICAgICAgZXJyID0gZXJybm87DQorDQorICAgICAgIGlmIChGRF9JU1NFVChmZFswXSwgJnJm
ZHMpKSB7DQorICAgICAgICAgICAgICAgcmV0dXJuIHN5bmNfcGlwZV93YWl0KGZkKTsNCisgICAg
ICAgfQ0KKw0KKyAgICAgICByZXR1cm4gciA/IGVyciA6IC1FVElNRURPVVQ7DQorfQ0KKw0KKw0K
K2ludCBzeW5jX3BpcGVfbm90aWZ5KGludCBmZFtdKQ0KK3sNCisgICAgICAgIGNoYXIgYnVmID0g
J0EnOw0KKyAgICAgICAgaW50IHI7DQorDQorICAgICAgICBpZiAoZmRbMF0gIT0gLTEpIHsNCisg
ICAgICAgICAgICAgICAgY2xvc2UgKGZkWzBdKTsNCisgICAgICAgICAgICAgICAgZmRbMF0gPSAt
MTsNCisgICAgICAgIH0NCisNCisgICAgICAgIHIgPSB3cml0ZSAoZmRbMV0sICZidWYsIDEpOw0K
Kw0KKyAgICAgICAgaWYgKHIgIT0gMSkNCisgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KKyAg
ICAgICAgcmV0dXJuIDA7DQorfQ0KZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUvaW5jbHVkZS9wb3NpeHRlc3QuaCBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3Rz
dWl0ZS9pbmNsdWRlL3Bvc2l4dGVzdC5oDQotLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0
c3VpdGUvaW5jbHVkZS9wb3NpeHRlc3QuaAkyMDA5LTA4LTA2IDIxOjQ5OjQyLjAwMDAwMDAwMCAr
MDUzMA0KKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2luY2x1ZGUvcG9zaXh0
ZXN0LmgJMjAwOS0wOC0wNyAxMToyODo0MS4wMDAwMDAwMDAgKzA1MzANCkBAIC0xNSw4NiArMTUs
MyBAQA0KICNkZWZpbmUgUFRTX1VOU1VQUE9SVEVEIDQNCiAjZGVmaW5lIFBUU19VTlRFU1RFRCAg
ICA1DQogDQotDQotI2luY2x1ZGUgPHN5cy9zZWxlY3QuaD4NCi0NCi0NCi1pbnQgc3luY19waXBl
X2NyZWF0ZShpbnQgZmRbXSkNCi17DQotICAgICAgICByZXR1cm4gcGlwZSAoZmQpOw0KLX0NCi0N
Ci1pbnQgc3luY19waXBlX2Nsb3NlKGludCBmZFtdKQ0KLXsNCi0gICAgICAgIGludCByID0gMDsN
Ci0NCi0gICAgICAgIGlmIChmZFswXSAhPSAtMSkNCi0gICAgICAgICAgICAgICAgciA9IGNsb3Nl
IChmZFswXSk7DQotICAgICAgICBpZiAoZmRbMV0gIT0gLTEpDQotICAgICAgICAgICAgICAgIHIg
fD0gY2xvc2UgKGZkWzFdKTsNCi0gICAgICAgIHJldHVybiByOw0KLX0NCi0NCi1pbnQgc3luY19w
aXBlX3dhaXQoaW50IGZkW10pDQotew0KLSAgICAgICAgY2hhciBidWY7DQotICAgICAgICBpbnQg
cjsNCi0NCi0gICAgICAgIGlmIChmZFsxXSAhPSAtMSkgew0KLSAgICAgICAgICAgICAgICBjbG9z
ZSAoZmRbMV0pOw0KLSAgICAgICAgICAgICAgICBmZFsxXSA9IC0xOw0KLSAgICAgICAgfQ0KLQ0K
LSAgICAgICAgciA9IHJlYWQgKGZkWzBdLCAmYnVmLCAxKTsNCi0NCi0gICAgICAgIGlmICgociAh
PSAxKSB8fCAoYnVmICE9ICdBJykpDQotICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCi0gICAg
ICAgIHJldHVybiAwOw0KLX0NCi0NCi1pbnQgc3luY19waXBlX3dhaXRfc2VsZWN0KGludCBmZFtd
LCBsb25nIHR2X3NlYykNCi17DQotICAgICAgICBjaGFyIGJ1ZjsNCi0gICAgICAgIGludCByOw0K
LSAgICAgICBmZF9zZXQgcmZkczsNCi0gICAgICAgc3RydWN0IHRpbWV2YWwgdHY7DQotICAgICAg
IGludCBlcnI7DQotDQotICAgICAgIHR2LnR2X3NlYyA9IHR2X3NlYzsNCi0gICAgICAgdHYudHZf
dXNlYyA9IDA7DQotDQotICAgICAgICBpZiAoZmRbMV0gIT0gLTEpIHsNCi0gICAgICAgICAgICAg
ICAgY2xvc2UgKGZkWzFdKTsNCi0gICAgICAgICAgICAgICAgZmRbMV0gPSAtMTsNCi0gICAgICAg
IH0NCi0NCi0gICAgICAgRkRfWkVSTygmcmZkcyk7DQotICAgICAgIEZEX1NFVChmZFswXSwgJnJm
ZHMpOw0KLQ0KLSAgICAgICByID0gc2VsZWN0KGZkWzBdICsgMSwgJnJmZHMsIE5VTEwsIE5VTEws
ICZ0dik7DQotICAgICAgIGVyciA9IGVycm5vOw0KLQ0KLSAgICAgICBpZiAoRkRfSVNTRVQoZmRb
MF0sICZyZmRzKSkgew0KLSAgICAgICAgICAgICAgIHJldHVybiBzeW5jX3BpcGVfd2FpdChmZCk7
DQotICAgICAgIH0NCi0NCi0gICAgICAgcmV0dXJuIHIgPyBlcnIgOiAtRVRJTUVET1VUOw0KLX0N
Ci0NCi0NCi1pbnQgc3luY19waXBlX25vdGlmeShpbnQgZmRbXSkNCi17DQotICAgICAgICBjaGFy
IGJ1ZiA9ICdBJzsNCi0gICAgICAgIGludCByOw0KLQ0KLSAgICAgICAgaWYgKGZkWzBdICE9IC0x
KSB7DQotICAgICAgICAgICAgICAgIGNsb3NlIChmZFswXSk7DQotICAgICAgICAgICAgICAgIGZk
WzBdID0gLTE7DQotICAgICAgICB9DQotDQotICAgICAgICByID0gd3JpdGUgKGZkWzFdLCAmYnVm
LCAxKTsNCi0NCi0gICAgICAgIGlmIChyICE9IDEpDQotICAgICAgICAgICAgICAgIHJldHVybiAt
MTsNCi0gICAgICAgIHJldHVybiAwOw0KLX0NCg==
--000e0cd6a87c13660f04708f186d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd6a87c13660f04708f186d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd6a87c13660f04708f186d--

