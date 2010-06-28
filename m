Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OT98x-0003qh-Bc
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 07:52:39 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OT98w-0004ra-5b
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 07:52:39 +0000
Received: by iwn9 with SMTP id 9so1133385iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Jun 2010 00:52:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
References: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
Date: Mon, 28 Jun 2010 00:52:32 -0700
Message-ID: <AANLkTimZ-GQtuu-_1pB_Llzrr46CE0EbEFnd_OnjnjmF@mail.gmail.com>
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

On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind
<vishwa.hochihally@gmail.com> wrote:
> Hi,
> =A0I have tried=A0to clone the latest LTP source through GIT but missing
> "configure" file in it.
>
> Here are my steps:
>
> =A0 # git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
>
> =A0# ls ltp
> COPYING=A0 ChangeLog=A0=A0 INSTALL=A0=A0 Makefile.release=A0 README.ltp-d=
evel.in
> TODO=A0=A0=A0=A0=A0=A0=A0=A0=A0 doc=A0=A0=A0=A0=A0=A0=A0=A0 include=A0 lt=
p-devel.spec.in=A0 m4=A0=A0 result
> runltp=A0=A0=A0=A0=A0=A0=A0=A0 runtest=A0 testcases=A0=A0=A0 tools=A0 ver=
_linux
> CREDITS=A0 IDcheck.sh=A0 Makefile=A0 README=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 README.mk-devel
> configure.ac=A0 execltp.in=A0 lib=A0=A0=A0=A0=A0 ltpmenu=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 pan=A0 runalltests.sh
> runltplite.sh=A0 scripts=A0 testscripts=A0 utils
> Why is "configure" file is missing here?
>
> Please let me know your thoughts?

configure should never be checked in to git.

Read INSTALL for more details on how to generate it.

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
