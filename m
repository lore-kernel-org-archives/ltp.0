Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NgwAG-00012J-FP
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 08:18:44 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NgwAF-0007eZ-Ic
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 08:18:44 +0000
Received: by pzk9 with SMTP id 9so2963884pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Feb 2010 00:18:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b9fdcd01002142359w4b275c73s91ea258eee1de146@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
	<4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
	<364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
	<4b9fdcd01002142359w4b275c73s91ea258eee1de146@mail.gmail.com>
Date: Mon, 15 Feb 2010 00:18:37 -0800
Message-ID: <364299f41002150018p1a6888b6r4cb95731deffcd0b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] facing issue "TBROK : nobody not in /etc/passwd"
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
To: vishwanath govind <vishwa.hochihally@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Feb 14, 2010 at 11:59 PM, vishwanath govind
<vishwa.hochihally@gmail.com> wrote:
> Yes, I checked this before, It return errorno "0". Somehow mknod02 won't
> display the errorno when it=A0exit with "tst_brkm(TBROK, cleanup, "%s not=
 in
> /etc/passwd", LTPUSER)"=A0but I have similar tests return errorno 0. I see
> "nobody" user=A0and uid/gid -99=A0is present in /etc/passwd file. Do=A0I =
need to
> enable anything in KERNEL config or /etc?
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <<<test_start>>>
> tag=3Dnftw01 stime=3D1170483127
> cmdline=3D"nftw01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> nobody not found in /etc/passwd: No such file or directory
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D1 cstime=3D2
> <<<test_end>>>
> <<<test_start>>>
> tag=3Dnftw6401 stime=3D1170483127
> cmdline=3D"nftw6401"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> change_owner: nobody not found in /etc/passwd: No such file or directory
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D2 cstime=3D1
> <<<test_end>>>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3Dend=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Regards
> Vishwa
>
> On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>>
>> On Sun, Feb 14, 2010 at 11:09 PM, vishwanath govind
>> <vishwa.hochihally@gmail.com> wrote:
>> > Garrett,
>> > =A0Thanks for your quick reply. I am using "ltp-full-20091231".
>> > Regards
>> > Vishwa
>> >
>> > On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper <yanegomi@gmail.com>
>> > wrote:
>> >>
>> >> On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
>> >> <vishwa.hochihally@gmail.com> wrote:
>> >> >
>> >> > Hi,
>> >> > I am facing common issue which causing many of the LTP syscalls test
>> >> > cases
>> >> > to fail. I have taken mknod02 test to show this issue here.
>> >> > Definitely I
>> >> > am
>> >> > missing something out here, could you guys please point me to right
>> >> > direction?=A0 Please let me know if you need some more info/log
>> >> >
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dl=
og=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > # ls /etc
>> >> > group=A0=A0 passwd
>> >> >
>> >> > # ./IDcheck.sh
>> >> > Checking for required user/group ids
>> >> > 'nobody' user id and group found.
>> >> > 'bin' user id and group found.
>> >> > 'daemon' user id and group found.
>> >> > Users group found.
>> >> > Sys group found.
>> >> > Required users/groups exist.
>> >> >
>> >> > # cat /etc/passwd
>> >> > root:x:0:0:root::
>> >> > nobody:x:99:99:nobody::
>> >> > bin:x:1:1:bin::
>> >> > daemon:x:2:2:daemon::
>> >> >
>> >> > #uname -a
>> >> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l
>> >> > GNU/Linux
>> >> >
>> >> > # ./mknod02
>> >> > mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/passwd
>> >>
>> >> What version of LTP is this?
>>
>> That's a lousy diagnostic, as any one of the following errors could be
>> the culprit:
>>
>> ERRORS
>> =A0 =A0 =A0 0 or ENOENT or ESRCH or EBADF or EPERM or ...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0The given name or uid was not found.
>>
>> =A0 =A0 =A0 EINTR =A0A signal was caught.
>>
>> =A0 =A0 =A0 EIO =A0 =A0I/O error.
>>
>> =A0 =A0 =A0 EMFILE The maximum number (OPEN_MAX) of files was open alrea=
dy
>> in the calling process.
>>
>> =A0 =A0 =A0 ENFILE The maximum number of files was open already in the s=
ystem.
>>
>> =A0 =A0 =A0 ENOMEM Insufficient memory to allocate passwd structure.
>>
>> =A0 =A0 =A0 ERANGE Insufficient buffer space supplied.
>>
>> What are the permissions on the file and is there any way where you
>> could grab the latest copy of the file from git and try that out (the
>> patch is available at:

Nope... you sure your ldap / nis isn't busted?
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
