Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MvnWh-0007j0-JJ
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 07:35:03 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvnWb-0000KW-5u
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 07:35:03 +0000
Received: by pxi9 with SMTP id 9so5567214pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Oct 2009 00:34:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9d696240910071655n747a5772h2a834f11a3bd6bb9@mail.gmail.com>
References: <b9d696240910071415y74717dcelfb3aa368e2fe8f4c@mail.gmail.com>
	<364299f40910071602h2eb2bba1u6b4af52d44efd950@mail.gmail.com>
	<b9d696240910071655n747a5772h2a834f11a3bd6bb9@mail.gmail.com>
Date: Thu, 8 Oct 2009 00:34:51 -0700
Message-ID: <364299f40910080034h1987f264ra526d7c496e70b24@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] cgroupstats.h present but cannot be compiled
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 7, 2009 at 4:55 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> attached.
>
> On Wed, Oct 7, 2009 at 4:02 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>>
>> On Wed, Oct 7, 2009 at 2:15 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
>> > When running configure for the latest LTP (Sept 2009) I see the
>> > following
>> > warnings:
>> >
>> > configure: WARNING: linux/cgroupstats.h: present but cannot be compiled
>> > configure: WARNING: linux/cgroupstats.h:=A0=A0=A0=A0 check for missing
>> > prerequisite
>> > headers?
>> > configure: WARNING: linux/cgroupstats.h: see the Autoconf documentation
>> > configure: WARNING: linux/cgroupstats.h:=A0=A0=A0=A0 section "Present =
But Cannot
>> > Be
>> > Compiled"
>> > configure: WARNING: linux/cgroupstats.h: proceeding with the
>> > preprocessor's
>> > result
>> > configure: WARNING: linux/cgroupstats.h: in the future, the compiler
>> > will
>> > take precedence
>> > configure: WARNING:=A0=A0=A0=A0 ##
>> > ------------------------------------------------
>> > ##
>> > configure: WARNING:=A0=A0=A0=A0 ## Report this to
>> > ltp-results@lists.sourceforge.net
>> > ##
>> > configure: WARNING:=A0=A0=A0=A0 ##
>> > ------------------------------------------------
>> > ##
>> > checking for linux/cgroupstats.h... yes
>>
>> Need config.log

    Hmmm... we need asm/types.h specified before that header is
included and linux/taskstats.h
    I'll see about fixing it sometime earlier next week.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
