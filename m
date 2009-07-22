Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTTxX-0003xY-JP
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:01:43 +0000
Received: from mail-px0-f174.google.com ([209.85.216.174])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTTxP-0001eC-OL
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:01:43 +0000
MIME-Version: 1.0
In-Reply-To: <364299f40907212138rb1f671eke3aabd6587c0f925@mail.gmail.com>
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<364299f40907210721q365aa8fdu21a1b2ff254bc60a@mail.gmail.com>
	<200907211728.56027.vapier@gentoo.org>
	<364299f40907212138rb1f671eke3aabd6587c0f925@mail.gmail.com>
Date: Tue, 21 Jul 2009 22:01:34 -0700
Message-ID: <364299f40907212201u64779636v91ff74c45c32c3f3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, ltp-list@lists.sf.net

On Tue, Jul 21, 2009 at 9:38 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Tue, Jul 21, 2009 at 2:28 PM, Mike Frysinger<vapier@gentoo.org> wrote:
>> On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
>>> I was tempted to fix the format string error, but I don't know what
>>> the potential implications are of switching the data type from
>>> u_int64_t to unsigned long long...
>>
>> dont do that. =A0just use the proper format string from inttypes.h.
>> uint64_t f;
>> printf("f =3D %"PRIu64"\n", f);
>>
>>> +/* Dummy function reference to avoid compiler warning from
>>> linux_syscall_numbers.h. */
>>> +extern void cleanup() { }
>>
>> this is incorrect for a few reasons. =A0it should read:
>> +/* Dummy function as syscall() from linux_syscall_numbers.h uses cleanu=
p() */
>> void cleanup() { }
>> -mike
>
> =A0 =A0Ok. I'll fix it again, recompile, and test.
> =A0 =A0Thanks for the review Mike :) (even though it's a bit post-mortem
> now). I do lack a bit when it comes to C coding style and that's one
> area that I want to improve upon.

Ok, new patch given Mike's review suggestion...

Fix compiler error for
testcases/kernel/syscalls/eventfd2/eventfd2_03.c noted by CAI Qian
w.r.t. the intermediate July release, as...
1. The necessary headers weren't being pulled in for waitpid.
2. gcc was complaining about -Wunused with cleanup.
3. The wrong format argument was being passed to printf.

Fix for 3 and suggestions on coding style made by Mike Frysinger.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

gcooper@orangebox /scratch/ltp-dev2/ltp $ cdiff
testcases/kernel/syscalls/eventfd2/eventfd2_03.c
Index: testcases/kernel/syscalls/eventfd2/eventfd2_03.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/eventfd2/eventfd2_03.c=
,v
retrieving revision 1.2
diff -u -r1.2 eventfd2_03.c
--- testcases/kernel/syscalls/eventfd2/eventfd2_03.c    6 Jul 2009
14:49:18 -0000       1.2
+++ testcases/kernel/syscalls/eventfd2/eventfd2_03.c    22 Jul 2009
05:00:37 -0000
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -44,6 +45,8 @@
 #define EFD_SEMLIKE (1 << 0)
 #endif

+/* Dummy function as syscall from linux_syscall_numbers.h uses cleanup(). =
*/
+void cleanup() { }

 static int eventfd2(int count, int flags) {
        return syscall(__NR_eventfd2, count, flags);
@@ -56,7 +59,7 @@
                perror("reading eventfd");
                exit(1);
        }
-       fprintf(stdout, "[%u] wait completed on %d: count=3D%llu\n",
+       fprintf(stdout, "[%u] wait completed on %d: count=3D%lu64\n",
                getpid(), fd, cntr);
 }

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
