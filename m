Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OTsUJ-0000v0-8f
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 08:17:43 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTsUI-0005VZ-6D
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 08:17:43 +0000
Received: by iwn34 with SMTP id 34so820461iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 30 Jun 2010 01:17:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
References: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
	<AANLkTimZ-GQtuu-_1pB_Llzrr46CE0EbEFnd_OnjnjmF@mail.gmail.com>
	<AANLkTim0JhFpvTVlo-DMkhjdWzcuf1ob3nUWpkK-vT9y@mail.gmail.com>
	<AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
Date: Wed, 30 Jun 2010 01:17:36 -0700
Message-ID: <AANLkTinQK4_5EoY7bXLd5tCam-j5NpYAkeZrIhF7J9NJ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Not cloning all the files from ltp-dev
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

On Tue, Jun 29, 2010 at 4:52 AM, vishwanath govind
<vishwa.hochihally@gmail.com> wrote:
> Hi,
> I am facing one more issue now. I am able to build but not able to install
> properly. Here are my steps. Since=A0I am working on server,=A0 root perm=
isision
> is restricted and=A0have 777 permission on=A0directory that i am working.=
 There
> is no autconf/aclocal=A0tools too
>
> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
> # cd ltp
> # cp include/config.h.default=A0 include/config.h
> #cp include/mk/config.mk.default=A0=A0 include/mk/config.mk
> # Mention the PATH for cross-compiler path for CC, AR, STRIP etc and also
> prefix(/home/vgovinda/ltp_install')
> # make
> # make install
>
> Here it's not able to create `/projects/test/ltp/ltp_install` and why is =
it
> creating dir /share instead of /home/vgovinda/ltp_install/share.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Makefile:176: warning: overriding commands for target
> `//home/vgovinda/ltp_install'
> Makefile:106: warning: ignoring old commands for target
> `//home/vgovinda/ltp_install'
> make: Circular //home/vgovinda/ltp_install <- //home/vgovinda/ltp_install
> dependency dropped.
> make -C "doc" \
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -f "/projects/test/ltp/doc/=
Makefile" install
> make[1]: Entering directory `/projects/test/ltp/doc'
> make[2]: Entering directory `/projects/test/ltp/doc/man1'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:90: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: overriding commands for target
> `/home/vgovinda/ltp_install'
> ../../include/mk/env_post.mk:91: warning: ignoring old commands for target
> `/home/vgovinda/ltp_install'
> mkdir -p "/share/man/man1"
> mkdir: cannot create directory `/share': Permission denied
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Any thoughts on this would be appriciated?
>
> Regards
> Vishwa
>
> On Mon, Jun 28, 2010 at 2:33 PM, vishwanath govind
> <vishwa.hochihally@gmail.com> wrote:
>>
>> Thanks Garrett.
>> Regards
>> Vishwa
>>
>> On Mon, Jun 28, 2010 at 1:22 PM, Garrett Cooper <yanegomi@gmail.com>
>> wrote:
>>>
>>> On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind
>>> <vishwa.hochihally@gmail.com> wrote:
>>> > Hi,
>>> > =A0I have tried=A0to clone the latest LTP source through GIT but miss=
ing
>>> > "configure" file in it.
>>> >
>>> > Here are my steps:
>>> >
>>> > =A0 # git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
>>> >
>>> > =A0# ls ltp
>>> > COPYING=A0 ChangeLog=A0=A0 INSTALL=A0=A0 Makefile.release=A0 README.l=
tp-devel.in
>>> > TODO=A0=A0=A0=A0=A0=A0=A0=A0=A0 doc=A0=A0=A0=A0=A0=A0=A0=A0 include=
=A0 ltp-devel.spec.in=A0 m4=A0=A0 result
>>> > runltp=A0=A0=A0=A0=A0=A0=A0=A0 runtest=A0 testcases=A0=A0=A0 tools=A0=
 ver_linux
>>> > CREDITS=A0 IDcheck.sh=A0 Makefile=A0 README=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 README.mk-devel
>>> > configure.ac=A0 execltp.in=A0 lib=A0=A0=A0=A0=A0 ltpmenu=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 pan
>>> > runalltests.sh
>>> > runltplite.sh=A0 scripts=A0 testscripts=A0 utils
>>> > Why is "configure" file is missing here?
>>> >
>>> > Please let me know your thoughts?
>>>
>>> configure should never be checked in to git.
>>>
>>> Read INSTALL for more details on how to generate it.

1. Please bottom post.
2. This looks indicative of one using make 3.80 with older sources of
LTP. What happens when you do make all instead of make in the first
invocation (sorry.. it's been a while since I've seen this problem, as
I fixed it a while ago).

Thanks,
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
