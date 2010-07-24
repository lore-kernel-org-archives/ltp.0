Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OcT2C-0006lm-P6
	for ltp-list@lists.sourceforge.net; Sat, 24 Jul 2010 00:56:12 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OcT2B-0000BT-SB
	for ltp-list@lists.sourceforge.net; Sat, 24 Jul 2010 00:56:12 +0000
MIME-Version: 1.0
In-Reply-To: <20100723232020.GA56564@medusa.sis.pasteur.fr>
References: <20100723171717.GA54890@medusa.sis.pasteur.fr>
	<AANLkTik=DJ+0NsMoD-ucZZtVrsaiBHeVEMmh-3GEixD+@mail.gmail.com>
	<20100723184824.GA55142@medusa.sis.pasteur.fr>
	<FE807C4F-FBEF-4F35-A53D-95290C6B0CC9@gmail.com>
	<20100723232020.GA56564@medusa.sis.pasteur.fr>
Date: Fri, 23 Jul 2010 17:56:06 -0700
Message-ID: <AANLkTi=4edWhRnuOQUSBPvcUax7cfS+J+ZS-9XtjYGkn@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] abort01 testcase cleanup
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>, Garrett Cooper <yaneurabeya@gmail.com>

On Fri, Jul 23, 2010 at 4:20 PM, Nicolas Joly <njoly@pasteur.fr> wrote:
> On Fri, Jul 23, 2010 at 03:03:45PM -0700, Garrett Cooper wrote:
>> On Jul 23, 2010, at 11:48 AM, Nicolas Joly wrote:
>>
>> > On Fri, Jul 23, 2010 at 10:56:58AM -0700, Garrett Cooper wrote:
>> >> On Fri, Jul 23, 2010 at 10:17 AM, Nicolas Joly <njoly@pasteur.fr> wro=
te:
>> >>>
>> >>> Hi,
>> >>>
>> >>> The attached patch do some cleanup in the abort01 testcase ...
>> >>>
>> >>> 1) The attempt to remove the generated core is wrong. The hard-coded
>> >>> =A0 `core' name is bad and the test temporary directory removal alre=
ady
>> >>> =A0 take care of this.
>> >>>
>> >>> 2) Make the test fail gracefully if the running environment does not
>> >>> =A0 allow generating core files.
>> >>>
>> >>> njoly@lanfeust [syscalls/abort]> ./abort01
>> >>> abort01 =A0 =A0 1 =A0TPASS =A0: =A0Test passed
>> >>> njoly@lanfeust [syscalls/abort]> (ulimit -c 0 && ./abort01)
>> >>> abort01 =A0 =A0 1 =A0TCONF =A0: =A0core file size limit must be grea=
ter than 0.
>> >>>
>> >>> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
>> >>
>> >> Looks ok, but is there any particular reason why you removed the unli=
nk(2) call?
>> >
>> > The `unlink("core")' one ?
>> >
>> > Well, at least RHEL do use `proc.<pid>' when generating core file
>> > names ... Not speaking about admins that might have configured it to
>> > use another scheme.
>> >
>> > IMO, relying on a specific name, for a configurable system, is a bad
>> > idea; and can only lead to problems.
>> >
>> > By example, this test from mkdir09.c cannot succeed on most RHEL
>> > systems:
>> >
>> > =A0 =A0 =A0 =A0/* Check for core file in test directory. */
>> > =A0 =A0 =A0 =A0if (access("core", 0) =3D=3D 0) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TWARN, "\tCore file found in t=
est directory.");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
>> > =A0 =A0 =A0 =A0}
>>
>> Yeah. Perhaps it might be a good idea to integrate a tool into LTP which=
 detects corefile names, like what's described here: http://aplawrence.com/=
Linux/limit_core_files.html .
>
> If there is a real need, why not; but for the current use in syscall
> testcases, it seems a little overkill.
>
> testcases/kernel/syscalls/abort/abort01.c
> testcases/kernel/syscalls/kill/kill11.c
> testcases/kernel/syscalls/mallopt/mallopt01.c
> testcases/kernel/syscalls/waitpid/waitpid02.c
> testcases/kernel/syscalls/waitpid/waitpid05.c
> =A0Remove core files that may have been created during the test
> =A0... The temp test directory removal can/do already remove them.
>
> testcases/kernel/syscalls/mkdir/mkdir09.c
> testcases/kernel/syscalls/setrlimit/setrlimit01.c
> =A0Check that a childs does not have created a core file
> =A0... Could be tested from child process status instead.

    It's not required to fix this testcase (and I'll commit this once
I get back home), but it really should be added.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
