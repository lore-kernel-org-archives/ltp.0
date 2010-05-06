Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA51w-0008SL-TB
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:38:36 +0000
Received: from mail-yx0-f191.google.com ([209.85.210.191])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA51v-0000nv-Q8
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:38:36 +0000
Received: by yxe29 with SMTP id 29so142982yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 10:38:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100506135312.GA12072@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
Date: Thu, 6 May 2010 10:38:07 -0700
Message-ID: <j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [04/12 FAILURE] LTP? sysctl03 test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Sachin P Sant <ssant@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

On Thu, May 6, 2010 at 6:53 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On May 5, 2010, at 11:56 PM, Subrata Modak wrote:
>>
>> > Subject: LTP=B6 sysctl03 test fails
>> >
>> > Issues Description Below:
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > # ./runltp -s sysctl03
>> > <<<test_output>>>
>> > sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Permiss=
ion denied
>> > sysctl03 =A0 =A02 =A0TFAIL =A0: =A0Expected EPERM, got 13
>> > sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Permiss=
ion denied
>> > <<<execution_status>>>
>> > initiation_status=3D"ok"
>> > duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
>> > cutime=3D0 cstime=3D0
>> > <<<test_end>>>
>>
>> =A0 =A0 =A0 Already known and recently discussed.
>
> Not only can things move glacially in kernel-land, but decisions not
> yet implemented can be changed.
>
> In the meantime, the sysctl's sit there as a potential subject for
> exploitation.
>
> So not meaning to be argumentative for its own sake, I nevertheless
> think it's better to fix the test than either to ignore or remove
> it. =A0Two untested patches below - the one just replaces EPERM with
> EACCESS. =A0The other removes the (imo misuided) notion that we can
> guess at the failing errno.

Except that the documentation (manpages) should explicitly state what
the failing conditions are for any given libcall and syscall. If not,
the Linux kernel devs and documentation team have failed to do their
job.

> An LSM could choose to return -EPERM
> after all, or perhaps even something different. =A0The thing that
> should scare us is if the call succeeds. =A0If we give any false
> positives, then true positives will seem less scary.

This will fail on older kernels as sysctl(2) always returned EPERM due
to the way it was improperly designed. Please see the previous thread
for more info: http://lkml.org/lkml/2010/3/4/354

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
