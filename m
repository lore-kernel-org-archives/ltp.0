Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLohH-0001pC-3x
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:31 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLohA-0001cu-Pr
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:31 +0000
Date: Sat, 19 Dec 2009 03:05:57 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
	<200912041406.40770.vapier@gentoo.org>
	<op.u4fxyb2ou2flwt@marcela-gaxm89c>
	<200912042358.59830.vapier@gentoo.org>
Message-ID: <op.u45xf7bsu2flwt@debian>
In-Reply-To: <200912042358.59830.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Don't install datafiles with executable mode
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Sat, 05 Dec 2009 05:58:59 +0100, Mike Frysinger <vapier@gentoo.org>  =

wrote:

> On Friday 04 December 2009 20:19:13 Ji=F8=ED Pale=E8ek wrote:
>> On Fri, 04 Dec 2009 20:06:40 +0100, Mike Frysinger <vapier@gentoo.org>
>>
>> wrote:
>> > On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
>> >> the makefiles install all files with executable mode by default. This
>> >> patch
>> >>  changes it for some of the Makefiles, that install data files, which
>> >>  should IMHO not be executable. The change makes INSTALL_MODE decide  =

>> the
>> >>  actual mode when it is expanded inside the install rule (depending  =

>> on
>> >> $@,
>> >>  which is the install target name).
>> >
>> > that's pretty fugly way to go about it.  let's go the more natural  =

>> route
>> > and
>> > have the common code default to $(INSTALL_MODE_$@) and if that's  =

>> unset,
>> > use
>> > the default $(INSTALL_MODE).
>>
>> Sorry, but I don't agree with that. This is a function-like approach  =

>> which
>> is not any less "natural" than what you propose - and it makes no  =

>> demands
>> on anyone who doesn't need it, and gives great power to those who need  =

>> it.
>
> your solution requires non-obvious delayed evaluation that isnt
> straightforward.  mine is explicit, unambiguous, and already in use by  =

> many
> other projects that ltp is related to.

... and weak.

>> The main reason I don't like the INSTALL_MODE_$@ thing, is that eg.
>> INSTALL_TARGETS can contain wildcards (eg. dir/*.ext), and there cannot  =

>> be
>> any such thing as $(INSTALL_MODE_dir/*.ext). You would have to enumerate
>> all data files - or all program files - which would be a chore esp. if  =

>> any
>> of these isn't known in the makefile until "make all" is ran.
>
> so fix install targets to expand the globs at make time and not shell  =

> time.
> i.e. something like INSTALL_TARGETS :=3D $(wildcard $(INSTALL_TARGETS))

We do that currently, but this doesn't change the problem in any way. The  =

problem is that if I am able to write

INSTALL_TARGETS :=3D 1* 2*

I want to be able to specify that the files in 1* are executables and  =

files in 2* are not, without having to enumerate them all. This is  =

impossible with your "explicit" solution.

I would be happy with something like

EXECUTABLES :=3D 1*

   Jiri Palecek

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
