Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NiWfP-00057k-P5
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:29:27 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiWfO-0006QJ-0e
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 17:29:27 +0000
Received: by pwi5 with SMTP id 5so277179pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Feb 2010 09:29:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b9fdcd01002190231l6f61844ek68b5b61be7d8719@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
	<364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
	<4b9fdcd01002142359w4b275c73s91ea258eee1de146@mail.gmail.com>
	<364299f41002150018p1a6888b6r4cb95731deffcd0b@mail.gmail.com>
	<4b9fdcd01002152325w6bee8349t173c6f0afd935070@mail.gmail.com>
	<364299f41002152330r15274a12p4630be799f88b9d4@mail.gmail.com>
	<4b9fdcd01002180355j571da4c5hce9c1dde0ee28f26@mail.gmail.com>
	<364299f41002180403h12737e7fk27836d964eb5dcd4@mail.gmail.com>
	<4b9fdcd01002190231l6f61844ek68b5b61be7d8719@mail.gmail.com>
Date: Fri, 19 Feb 2010 09:29:19 -0800
Message-ID: <364299f41002190929g9fdc716w28d262fb6c94f9e0@mail.gmail.com>
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Fri, Feb 19, 2010 at 2:31 AM, vishwanath govind
<vishwa.hochihally@gmail.com> wrote:
> Garret,
> =A0Thanks for your help and appreciated, using strace found that it missi=
ng
> libnss* files. So i copied them to target lib and it started working. I
> believe=A0these libnss* files=A0direct it to=A0look for /etc/passwd file =
for the
> given user name records.
> Regards
> Vishwa
>
> On Thu, Feb 18, 2010 at 5:33 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>
>> On Thu, Feb 18, 2010 at 3:55 AM, vishwanath govind
>> <vishwa.hochihally@gmail.com> wrote:
>> > Garret,
>> >>>Do you have an alternative means of checking, like with perl,
>> > python, etc?
>> >
>> > Finally=A0I cross-compiled Python and =A0got=A0it workin on my target =
device.
>> > is
>> > it possible to use python and parse /etc/passwd file for getpwnam()
>> > funtion.
>> > I believe if it=A0returns uid and gid of the given user is more than
>> > enough
>> > correct?
>>
>> python -c 'import pwd; print pwd.getpwnam("nobody")'
>>
>> should produce a tuple, like:
>>
>> gcooper@orangebox ~ $ python -c 'import pwd; print pwd.getpwnam("nobody"=
)'
>> pwd.struct_passwd(pw_name=3D'nobody', pw_passwd=3D'x', pw_uid=3D65534,
>> pw_gid=3D65534, pw_gecos=3D'nobody', pw_dir=3D'/', pw_shell=3D'/bin/fals=
e')
>>
>> >>>Do you need to update your shadow password db setup?
>> > =A0I dont have shadow password db setup in filesystem but ported openL=
DAP
>> > to
>> > my target device, is=A0this help me ? The target device doen't have
>> > ethernet
>> > controller support so i cann't communicate to host. Curently=A0passwd =
and
>> > group files in /etc directory as i mentioned above.
>>
>> Err... that wasn't required :\. I was just wondering if you originally
>> set it up, but it was broken because it couldn't talk to the ldap
>> server or something... oh well...if it's trying to lookup the username
>> in ldap and failing, that would be interesting as well.
>>
>> One avenue we haven't tried yet is ltrace/strace though. That would
>> tie down the actual root cause a bit better.
>>
>> > Please let me know your thoughts.
>>
>> Thanks!
>> -Garrett
>>
>> > On Tue, Feb 16, 2010 at 1:00 PM, Garrett Cooper <yanegomi@gmail.com>
>> > wrote:
>> >>
>> >> On Mon, Feb 15, 2010 at 11:25 PM, vishwanath govind
>> >> <vishwa.hochihally@gmail.com> wrote:
>> >> > I have initramfs file system built using Busybox-1.16.0 and didn't
>> >> > setup
>> >> > the
>> >> > ldap/nis. I have few files in /etc like passwd,group and syslogd co=
nf
>> >> > files.But getpwnam() should search local repository(/etc/passwd fil=
e)
>> >> > and
>> >> > returns a pointer to a struct passwd, correct?. Do i really need to
>> >> > setup
>> >> > ldap/NIS to make it work getpwnam() funtion? The device i am using
>> >> > has
>> >> > memory restriction to add more stuff to filesystem and its very
>> >> > minimal.
>> >> > So
>> >> > please guide me what are the minimal things need to setup to get
>> >> > getpwnam()
>> >> > function working? Please correct me if i am wrong here.
>> >> >
>> >> > Regards
>> >> > Vishwa
>> >> >
>> >> > On Mon, Feb 15, 2010 at 1:48 PM, Garrett Cooper <yanegomi@gmail.com>
>> >> > wrote:
>> >> >>
>> >> >> On Sun, Feb 14, 2010 at 11:59 PM, vishwanath govind
>> >> >> <vishwa.hochihally@gmail.com> wrote:
>> >> >> > Yes, I checked this before, It return errorno "0". Somehow mknod=
02
>> >> >> > won't
>> >> >> > display the errorno when it=A0exit with "tst_brkm(TBROK, cleanup,
>> >> >> > "%s
>> >> >> > not
>> >> >> > in
>> >> >> > /etc/passwd", LTPUSER)"=A0but I have similar tests return errorn=
o 0.
>> >> >> > I
>> >> >> > see
>> >> >> > "nobody" user=A0and uid/gid -99=A0is present in /etc/passwd file=
. Do=A0I
>> >> >> > need
>> >> >> > to
>> >> >> > enable anything in KERNEL config or /etc?
>> >> >> >
>> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > <<<test_start>>>
>> >> >> > tag=3Dnftw01 stime=3D1170483127
>> >> >> > cmdline=3D"nftw01"
>> >> >> > contacts=3D""
>> >> >> > analysis=3Dexit
>> >> >> > <<<test_output>>>
>> >> >> > nobody not found in /etc/passwd: No such file or directory
>> >> >> > <<<execution_status>>>
>> >> >> > initiation_status=3D"ok"
>> >> >> > duration=3D0 termination_type=3Dexited termination_id=3D1 corefi=
le=3Dno
>> >> >> > cutime=3D1 cstime=3D2
>> >> >> > <<<test_end>>>
>> >> >> > <<<test_start>>>
>> >> >> > tag=3Dnftw6401 stime=3D1170483127
>> >> >> > cmdline=3D"nftw6401"
>> >> >> > contacts=3D""
>> >> >> > analysis=3Dexit
>> >> >> > <<<test_output>>>
>> >> >> > change_owner: nobody not found in /etc/passwd: No such file or
>> >> >> > directory
>> >> >> > <<<execution_status>>>
>> >> >> > initiation_status=3D"ok"
>> >> >> > duration=3D0 termination_type=3Dexited termination_id=3D1 corefi=
le=3Dno
>> >> >> > cutime=3D2 cstime=3D1
>> >> >> > <<<test_end>>>
>> >> >> >
>> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3Dend=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > Regards
>> >> >> > Vishwa
>> >> >> >
>> >> >> > On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper
>> >> >> > <yanegomi@gmail.com>
>> >> >> > wrote:
>> >> >> >>
>> >> >> >> On Sun, Feb 14, 2010 at 11:09 PM, vishwanath govind
>> >> >> >> <vishwa.hochihally@gmail.com> wrote:
>> >> >> >> > Garrett,
>> >> >> >> > =A0Thanks for your quick reply. I am using "ltp-full-20091231=
".
>> >> >> >> > Regards
>> >> >> >> > Vishwa
>> >> >> >> >
>> >> >> >> > On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper
>> >> >> >> > <yanegomi@gmail.com>
>> >> >> >> > wrote:
>> >> >> >> >>
>> >> >> >> >> On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
>> >> >> >> >> <vishwa.hochihally@gmail.com> wrote:
>> >> >> >> >> >
>> >> >> >> >> > Hi,
>> >> >> >> >> > I am facing common issue which causing many of the LTP
>> >> >> >> >> > syscalls
>> >> >> >> >> > test
>> >> >> >> >> > cases
>> >> >> >> >> > to fail. I have taken mknod02 test to show this issue here.
>> >> >> >> >> > Definitely I
>> >> >> >> >> > am
>> >> >> >> >> > missing something out here, could you guys please point me
>> >> >> >> >> > to
>> >> >> >> >> > right
>> >> >> >> >> > direction?=A0 Please let me know if you need some more
>> >> >> >> >> > info/log
>> >> >> >> >> >
>> >> >> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> >> >> > # ls /etc
>> >> >> >> >> > group=A0=A0 passwd
>> >> >> >> >> >
>> >> >> >> >> > # ./IDcheck.sh
>> >> >> >> >> > Checking for required user/group ids
>> >> >> >> >> > 'nobody' user id and group found.
>> >> >> >> >> > 'bin' user id and group found.
>> >> >> >> >> > 'daemon' user id and group found.
>> >> >> >> >> > Users group found.
>> >> >> >> >> > Sys group found.
>> >> >> >> >> > Required users/groups exist.
>> >> >> >> >> >
>> >> >> >> >> > # cat /etc/passwd
>> >> >> >> >> > root:x:0:0:root::
>> >> >> >> >> > nobody:x:99:99:nobody::
>> >> >> >> >> > bin:x:1:1:bin::
>> >> >> >> >> > daemon:x:2:2:daemon::
>> >> >> >> >> >
>> >> >> >> >> > #uname -a
>> >> >> >> >> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010
>> >> >> >> >> > armv6l
>> >> >> >> >> > GNU/Linux
>> >> >> >> >> >
>> >> >> >> >> > # ./mknod02
>> >> >> >> >> > mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/=
passwd
>> >> >> >> >>
>> >> >> >> >> What version of LTP is this?
>> >> >> >>
>> >> >> >> That's a lousy diagnostic, as any one of the following errors
>> >> >> >> could
>> >> >> >> be
>> >> >> >> the culprit:
>> >> >> >>
>> >> >> >> ERRORS
>> >> >> >> =A0 =A0 =A0 0 or ENOENT or ESRCH or EBADF or EPERM or ...
>> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0The given name or uid was not found.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 EINTR =A0A signal was caught.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 EIO =A0 =A0I/O error.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 EMFILE The maximum number (OPEN_MAX) of files was o=
pen
>> >> >> >> already
>> >> >> >> in the calling process.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 ENFILE The maximum number of files was open already=
 in the
>> >> >> >> system.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 ENOMEM Insufficient memory to allocate passwd struc=
ture.
>> >> >> >>
>> >> >> >> =A0 =A0 =A0 ERANGE Insufficient buffer space supplied.
>> >> >> >>
>> >> >> >> What are the permissions on the file and is there any way where
>> >> >> >> you
>> >> >> >> could grab the latest copy of the file from git and try that out
>> >> >> >> (the
>> >> >> >> patch is available at:
>> >> >>
>> >> >> Nope... you sure your ldap / nis isn't busted?
>> >>
>> >> =A0 =A0No.. heh. I was just wondering if you had it partially setup b=
ut
>> >> it was broken somehow.
>> >> =A0 =A0Do you have an alternative means of checking, like with perl,
>> >> python, etc? Do you need to update your shadow password db setup?

Good to hear!
All the best,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
