Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MlUli-0000qL-1W
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 21:31:58 +0000
Received: from qw-out-1920.google.com ([74.125.92.150])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlUlZ-00065b-Se
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 21:31:57 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1200361qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 Sep 2009 14:31:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1252478989.5006.9.camel@subratamodak.linux.ibm.com>
References: <4AA67D12.5010602@in.ibm.com> <4AA7391B.4020804@cn.fujitsu.com>
	<4AA73AB0.9020202@in.ibm.com>
	<1252478989.5006.9.camel@subratamodak.linux.ibm.com>
Date: Wed, 9 Sep 2009 14:31:42 -0700
Message-ID: <364299f40909091431w5726183bq147ccb482fd61ecc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP : Fix connectors event_generator program : gen_fork
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Suzuki Poulose <suzuki@in.ibm.com>

On Tue, Sep 8, 2009 at 11:49 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-09-09 at 10:48 +0530, Suzuki Poulose wrote:
>> Li Zefan wrote:
>> > Suzuki Poulose wrote:
>> >> Hi,
>> >>
>> >> There is a testcase issue in the event_generator code. The gen_fork()=
 is
>> >> called to generate the fork event.
>> >>
>> >> The child process prints the following message:
>> >>
>> >> static inline void gen_fork(void)
>> >> {
>> >> =A0 =A0 =A0 =A0 pid_t pid;
>> >> =A0 =A0 =A0 =A0 int status;
>> >>
>> >> =A0 =A0 =A0 =A0 pid =3D fork();
>> >> =A0 =A0 =A0 =A0 if (pid =3D=3D 0) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("fork parent: %d, child: %d\n"=
, getppid(),
>> >> getpid());
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(0);
>> >> =A0 =A0 =A0 =A0 } else if (pid < 0) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "fork() failed\n");
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> >> =A0 =A0 =A0 =A0 }
>> >> }
>> >>
>> >> Now the parent process just exits after this call. So, if the child
>> >> doesn't get to run before parent exits, the child will see the ppid as
>> >> 1, that of INIT and this contradicts the actual data. Hence the test =
fails.
>> >>
>> >> Attached patch fixes the issue. I have verified the same. Please appl=
y.
>> >>
>> >
>> > Thanks for fixing it.
>> >
>> > Acked-by: Li Zefan <lizf@cn.fujitsu.com>
>> >
>> > But you forgot to add your Signed-off-by in the patch. ;)
>> >
>> Ah! Thanks for catching that ! Re-attaching it ;)
>>
>> Thanks
>>
>> Suzuki
>> plain text document attachment
>> (connectors-gen_fork-wait-for-child.diff)
>> gen_fork() event should wait until the child exits. Otherwise the child =
would see INIT as the parent and
>> end up in collecting wrong information to compare with.
>>
>>
>> Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
>
> Thanks.
>
> Regards--
> Subrata
>
>> Acked-by: Li Zefan <lizf@cn.fujitsu.com>
>>
>> Index: ltp/testcases/kernel/connectors/pec/event_generator.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ltp.orig/testcases/kernel/connectors/pec/event_generator.c =A0 =A0 =
=A0 =A02008-10-22 13:40:31.000000000 +0000
>> +++ ltp/testcases/kernel/connectors/pec/event_generator.c =A0 =A0 2009-0=
9-08 13:52:14.000000000 +0000
>> @@ -25,6 +25,9 @@
>> =A0#include <stdlib.h>
>> =A0#include <stdio.h>
>> =A0#include <pwd.h>
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>> +
>> =A0#include "test.h"
>>
>> =A0#define DEFAULT_EVENT_NUM =A0 =A0 =A0 1
>> @@ -94,6 +97,7 @@
>> =A0static inline void gen_fork(void)
>> =A0{
>> =A0 =A0 =A0 pid_t pid;
>> + =A0 =A0 int status;
>>
>> =A0 =A0 =A0 pid =3D fork();
>> =A0 =A0 =A0 if (pid =3D=3D 0) {
>> @@ -102,6 +106,8 @@
>> =A0 =A0 =A0 } else if (pid < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "fork() failed\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 } else { =A0/* Parent should wait for the child */
>> + =A0 =A0 =A0 =A0 =A0 =A0 wait(&status);
>> =A0 =A0 =A0 }
>> =A0}

Sorry -- this really could have been done `better' with waitpid
because you wouldn't need the extra status field.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
