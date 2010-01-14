Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVXKd-0008MO-1c
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:34:19 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVXKc-0004dx-20
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:34:18 +0000
Received: by mail-pz0-f193.google.com with SMTP id 31so85611pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 13:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001141333v714a43ecv9d3e90c0ef6b2cba@mail.gmail.com>
References: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
	<364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
	<5e088bd91001141302l291261a7p366ac54659534a9c@mail.gmail.com>
	<364299f41001141333v714a43ecv9d3e90c0ef6b2cba@mail.gmail.com>
Date: Thu, 14 Jan 2010 13:34:17 -0800
Message-ID: <364299f41001141334q50820482id4c12aa8a3759634@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp on OMAP3 embedded linux systems
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
To: Steve Sakoman <sakoman@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 1:33 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Jan 14, 2010 at 1:02 PM, Steve Sakoman <sakoman@gmail.com> wrote:
>> On Thu, Jan 14, 2010 at 11:25 AM, Garrett Cooper <yanegomi@gmail.com> wr=
ote:
>>
>>>> There was really only one glitch in the build process (looking for
>>>> libraries in an odd location) and I am now in the process of running
>>>> the test.
>>>
>>> Please -- if you find bugs CC the list so I can resolve them as soon
>>> as possible -- thanks :).
>>
>> I redid the build and everything worked perfectly, so that initial
>> glitch was probably my fault!
>
> Well, you never know... it always does help to learn where things went
> wrong so processes and methods can be improved...
>
>>> x86* is still the primary target architecture. I'd like to see the
>>> failures, but yes my Fedora 12 VM is LTP `result clean', whereas the
>>> MIPS and PPC 2.6.24* embedded devices at work have issues with some
>>> tests due to architectural bugs, kernel bugs, and some test bugs.
>>>
>>> Please let us know how it goes though so we can try and work out the
>>> issues with your ARM embedded DUT.
>>
>> I've got the results of the 1st run. =A0What is the normal way to share
>> the results?
>
> Pastebin?

Actually there's an ltp-results mailing list. Please feel free to use
that, but definitely CC me because I don't subscribe to the list.
Cheers!
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
