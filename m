Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVBGB-0004yi-PR
	for Ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:00:15 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVBG9-00033k-HK
	for Ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:00:15 +0000
Received: by pzk31 with SMTP id 31so2241465pzk.28
	for <Ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 14:00:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263412888.2410.30.camel@plars-t500>
References: <1263226258.2410.24.camel@plars-t500>
	<364299f41001110943q4c476dc7n6dbf1fcf8b05c57d@mail.gmail.com>
	<1263412888.2410.30.camel@plars-t500>
Date: Wed, 13 Jan 2010 14:00:07 -0800
Message-ID: <364299f41001131400u700c490dgd95dc24302b95484@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Fix for make autotools
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
To: Paul Larson <paul.larson@canonical.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Wed, Jan 13, 2010 at 12:01 PM, Paul Larson <paul.larson@canonical.com> w=
rote:
> Can we go ahead and push this in, or is there a problem you see with it?
> I also tested with older automake in karmic (automake 1.11) and it had
> no problems there.
>
> Thanks,
> Paul Larson
>
> On Mon, 2010-01-11 at 09:43 -0800, Garrett Cooper wrote:
>> On Mon, Jan 11, 2010 at 8:10 AM, Paul Larson <paul.larson@canonical.com>=
 wrote:
>> > Make autotools seems to break on more recent versions without this.
>> >
>> > Signed-off-by: Paul Larson <paul.larson@canonical.com>
>> > ---
>> > diff --git a/include/mk/automake.mk b/include/mk/automake.mk
>> > index e23d5d4..889e6cf 100644
>> > --- a/include/mk/automake.mk
>> > +++ b/include/mk/automake.mk
>> > @@ -59,7 +59,7 @@ include:
>> > =A0 =A0 =A0 =A0mkdir -p "$@"
>> >
>> > =A0m4/ltp-version.m4: ChangeLog
>> > - =A0 =A0 =A0 sed -n '1{s:LTP-:AC_DEFUN([LTP_VERSION],[:;s:$$:]):;p;q}=
' $< > $@
>> > + =A0 =A0 =A0 sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$$:]):;p;q=
}' $< > $@
>> >
>> > =A0.PHONY: automake
>> > =A0AUTOMAKE_FILES :=3D config.guess config.sub install-sh missing stam=
p-h1
>>
>> Hi Paul,
>> =A0 =A0 What version of automake and m4 are you using?
>> Thanks,
>> -Garrett

    Thanks for the reminder :] -- I'll commit it later on tonight!
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
