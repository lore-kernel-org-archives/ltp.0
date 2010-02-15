Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NgvFr-00040a-UF
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:20:27 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NgvFr-0005B8-2L
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:20:27 +0000
Received: by pzk9 with SMTP id 9so2923969pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 23:20:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
	<4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
Date: Sun, 14 Feb 2010 23:20:20 -0800
Message-ID: <364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
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

On Sun, Feb 14, 2010 at 11:09 PM, vishwanath govind
<vishwa.hochihally@gmail.com> wrote:
> Garrett,
> =A0Thanks for your quick reply. I am using "ltp-full-20091231".
> Regards
> Vishwa
>
> On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>>
>> On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
>> <vishwa.hochihally@gmail.com> wrote:
>> >
>> > Hi,
>> > I am facing common issue which causing many of the LTP syscalls test
>> > cases
>> > to fail. I have taken mknod02 test to show this issue here. Definitely=
 I
>> > am
>> > missing something out here, could you guys please point me to right
>> > direction?=A0 Please let me know if you need some more info/log
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlog=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> > # ls /etc
>> > group=A0=A0 passwd
>> >
>> > # ./IDcheck.sh
>> > Checking for required user/group ids
>> > 'nobody' user id and group found.
>> > 'bin' user id and group found.
>> > 'daemon' user id and group found.
>> > Users group found.
>> > Sys group found.
>> > Required users/groups exist.
>> >
>> > # cat /etc/passwd
>> > root:x:0:0:root::
>> > nobody:x:99:99:nobody::
>> > bin:x:1:1:bin::
>> > daemon:x:2:2:daemon::
>> >
>> > #uname -a
>> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l
>> > GNU/Linux
>> >
>> > # ./mknod02
>> > mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/passwd
>>
>> What version of LTP is this?

That's a lousy diagnostic, as any one of the following errors could be
the culprit:

ERRORS
       0 or ENOENT or ESRCH or EBADF or EPERM or ...
              The given name or uid was not found.

       EINTR  A signal was caught.

       EIO    I/O error.

       EMFILE The maximum number (OPEN_MAX) of files was open already
in the calling process.

       ENFILE The maximum number of files was open already in the system.

       ENOMEM Insufficient memory to allocate passwd structure.

       ERANGE Insufficient buffer space supplied.

What are the permissions on the file and is there any way where you
could grab the latest copy of the file from git and try that out (the
patch is available at:
<http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.git;a=3Dpatc=
h;h=3DHEAD;hp=3D8686ad72fbe76a7de8fe8e93ef68a71fff8a049d>)?
Thanks!
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
