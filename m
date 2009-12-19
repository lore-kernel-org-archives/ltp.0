Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLogq-0001ni-Ob
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:04 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLogj-0004zq-3B
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:04 +0000
Date: Sat, 19 Dec 2009 03:05:18 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
	<200912041406.40770.vapier@gentoo.org>
	<op.u4fxyb2ou2flwt@marcela-gaxm89c>
	<364299f40912042239w56b6d771ic32ba98907162d34@mail.gmail.com>
Message-ID: <op.u45xe5plu2flwt@debian>
In-Reply-To: <364299f40912042239w56b6d771ic32ba98907162d34@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hello,

I'm sorry it took me some time to get to this.

On Sat, 05 Dec 2009 07:39:10 +0100, Garrett Cooper <yanegomi@gmail.com>  =

wrote:

> On Fri, Dec 4, 2009 at 5:19 PM, Ji=F8=ED Pale=E8ek <jpalecek@web.de> wrot=
e:
>> On Fri, 04 Dec 2009 20:06:40 +0100, Mike Frysinger <vapier@gentoo.org>
>> wrote:
>>
>>> On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
>>>> the makefiles install all files with executable mode by default. This
>>>> patch
>>>> =A0changes it for some of the Makefiles, that install data files, which
>>>> =A0should IMHO not be executable. The change makes INSTALL_MODE decide=
  =

>>>> the
>>>> =A0actual mode when it is expanded inside the install rule (depending =
on
>>>> $@,
>>>> =A0which is the install target name).
>>>
>>> that's pretty fugly way to go about it. =A0let's go the more natural  =

>>> route
>>> and
>>> have the common code default to $(INSTALL_MODE_$@) and if that's unset,
>>> use
>>> the default $(INSTALL_MODE).
>>
>> Sorry, but I don't agree with that. This is a function-like approach  =

>> which
>> is not any less "natural" than what you propose - and it makes no  =

>> demands
>> on anyone who doesn't need it, and gives great power to those who need  =

>> it.
>>
>> The main reason I don't like the INSTALL_MODE_$@ thing, is that eg.
>> INSTALL_TARGETS can contain wildcards (eg. dir/*.ext), and there cannot  =

>> be
>> any such thing as $(INSTALL_MODE_dir/*.ext). You would have to enumerate
>> all data files - or all program files - which would be a chore esp. if  =

>> any
>> of these isn't known in the makefile until "make all" is ran.
>>
>> OTOH I would agree on some method to automagically determine the correct
>> mode.
>
>     We can do it one of a few ways...
>     1. Anything not going into $(datarootdir), $(libdir), $(mandir),
> etc (e.g. bin, testcases/bin, etc) should be 00664.

You meant 755? (ie. not $(mandir) etc. -> 755).

>     2. We can filter by extension, e.g. INSTALL_TARGETS with
> extensions like .py, .sh, etc can have 00755.

I think 1 is not satisfactory here, given that we install some datafiles  =

in testcases/bin.

2 would be possible if it would work for most cases automatically and  =

allowed a simple way of fixing corner cases.

I thought we could engage "file" command in determining what is what, but  =

it may be really an overkill.

Regards
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
