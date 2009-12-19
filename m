Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLrFT-0001wD-0a
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:48:59 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLrFM-0003FS-Gl
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:48:58 +0000
Received: by pzk31 with SMTP id 31so2476535pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 20:48:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <op.u45xf7bsu2flwt@debian>
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
	<200912041406.40770.vapier@gentoo.org>
	<op.u4fxyb2ou2flwt@marcela-gaxm89c>
	<200912042358.59830.vapier@gentoo.org> <op.u45xf7bsu2flwt@debian>
Date: Fri, 18 Dec 2009 20:48:46 -0800
Message-ID: <364299f40912182048g28dbdc8ata19243d36d471aa9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

2009/12/18 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Sat, 05 Dec 2009 05:58:59 +0100, Mike Frysinger <vapier@gentoo.org>
> wrote:
>
>> On Friday 04 December 2009 20:19:13 Ji=F8=ED Pale=E8ek wrote:
>>> On Fri, 04 Dec 2009 20:06:40 +0100, Mike Frysinger <vapier@gentoo.org>
>>>
>>> wrote:
>>> > On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
>>> >> the makefiles install all files with executable mode by default. This
>>> >> patch
>>> >> =A0changes it for some of the Makefiles, that install data files, wh=
ich
>>> >> =A0should IMHO not be executable. The change makes INSTALL_MODE deci=
de
>>> the
>>> >> =A0actual mode when it is expanded inside the install rule (depending
>>> on
>>> >> $@,
>>> >> =A0which is the install target name).
>>> >
>>> > that's pretty fugly way to go about it. =A0let's go the more natural
>>> route
>>> > and
>>> > have the common code default to $(INSTALL_MODE_$@) and if that's
>>> unset,
>>> > use
>>> > the default $(INSTALL_MODE).
>>>
>>> Sorry, but I don't agree with that. This is a function-like approach
>>> which
>>> is not any less "natural" than what you propose - and it makes no
>>> demands
>>> on anyone who doesn't need it, and gives great power to those who need
>>> it.
>>
>> your solution requires non-obvious delayed evaluation that isnt
>> straightforward. =A0mine is explicit, unambiguous, and already in use by
>> many
>> other projects that ltp is related to.
>
> ... and weak.
>
>>> The main reason I don't like the INSTALL_MODE_$@ thing, is that eg.
>>> INSTALL_TARGETS can contain wildcards (eg. dir/*.ext), and there cannot
>>> be
>>> any such thing as $(INSTALL_MODE_dir/*.ext). You would have to enumerate
>>> all data files - or all program files - which would be a chore esp. if
>>> any
>>> of these isn't known in the makefile until "make all" is ran.
>>
>> so fix install targets to expand the globs at make time and not shell
>> time.
>> i.e. something like INSTALL_TARGETS :=3D $(wildcard $(INSTALL_TARGETS))
>
> We do that currently, but this doesn't change the problem in any way. The
> problem is that if I am able to write
>
> INSTALL_TARGETS :=3D 1* 2*
>
> I want to be able to specify that the files in 1* are executables and
> files in 2* are not, without having to enumerate them all. This is
> impossible with your "explicit" solution.
>
> I would be happy with something like
>
> EXECUTABLES :=3D 1*

    I like that proposal a lot :). Maybe have an extension to the
install define that defaults to 00644 by default, but can be
overridden by an optional argument added to the define, e.g.

define generate_install_rule

$(1)INSTALL_MODE ?=3D 00664

ifneq ($(4),)
$(1)INSTALL_MODE :=3D $(4)
endef

#...

endef

Some of the testcases that require CAP_CHOWN for seteuid need
different install bits than the rest. Or maybe a different method of
installation should be used here?
Thanks,
-Garrett

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
