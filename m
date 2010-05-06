Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA5MH-0008GV-58
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:59:37 +0000
Received: from mail-iw0-f200.google.com ([209.85.223.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA5ME-0002V5-CP
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:59:37 +0000
Received: by iwn38 with SMTP id 38so173951iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 10:59:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100506175512.GA25514@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
	<j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
	<20100506175512.GA25514@us.ibm.com>
Date: Thu, 6 May 2010 10:59:28 -0700
Message-ID: <k2v364299f41005061059rf51273ffk7c8c9755b92427e5@mail.gmail.com>
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
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Michael Kerrisk <mtk.manpages@gmail.com>

On Thu, May 6, 2010 at 10:55 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Thu, May 6, 2010 at 6:53 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
>> > Quoting Garrett Cooper (yanegomi@gmail.com):
>> >> On May 5, 2010, at 11:56 PM, Subrata Modak wrote:
>> >>
>> >> > Subject: LTP=B6 sysctl03 test fails
>> >> >
>> >> > Issues Description Below:
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > # ./runltp -s sysctl03
>> >> > <<<test_output>>>
>> >> > sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Perm=
ission denied
>> >> > sysctl03 =A0 =A02 =A0TFAIL =A0: =A0Expected EPERM, got 13
>> >> > sysctl03 =A0 =A01 =A0TFAIL =A0: =A0Expected EPERM (1), got 13: Perm=
ission denied
>> >> > <<<execution_status>>>
>> >> > initiation_status=3D"ok"
>> >> > duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno
>> >> > cutime=3D0 cstime=3D0
>> >> > <<<test_end>>>
>> >>
>> >> =A0 =A0 =A0 Already known and recently discussed.
>> >
>> > Not only can things move glacially in kernel-land, but decisions not
>> > yet implemented can be changed.
>> >
>> > In the meantime, the sysctl's sit there as a potential subject for
>> > exploitation.
>> >
>> > So not meaning to be argumentative for its own sake, I nevertheless
>> > think it's better to fix the test than either to ignore or remove
>> > it. =A0Two untested patches below - the one just replaces EPERM with
>> > EACCESS. =A0The other removes the (imo misuided) notion that we can
>> > guess at the failing errno.
>>
>> Except that the documentation (manpages) should explicitly state what
>> the failing conditions are for any given libcall and syscall. If not,
>> the Linux kernel devs and documentation team have failed to do their
>> job.
>
> So since we're all member of the doc team, send a patch for sysctl(2)
> manpage ERRORS section :)
>
> (mtk cc:d as this is probably news to him)

I already have a bug outstanding for it:
https://bugzilla.kernel.org/show_bug.cgi?id=3D15446

>> > An LSM could choose to return -EPERM
>> > after all, or perhaps even something different. =A0The thing that
>> > should scare us is if the call succeeds. =A0If we give any false
>> > positives, then true positives will seem less scary.
>>
>> This will fail on older kernels as sysctl(2) always returned EPERM due
>
> Sorry - what will fail?

Read through the link, and you will understand why your new proposed
patch with fail with a false negative.

> I think you're saying the first patch will, and I agree, which is why
> I advocate the second one i pasted in.
>
>> to the way it was improperly designed. Please see the previous thread
>> for more info: http://lkml.org/lkml/2010/3/4/354

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
