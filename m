Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVXJl-00027v-01
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:33:25 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVXJk-0008T6-6q
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:33:24 +0000
Received: by pwj11 with SMTP id 11so4696218pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 13:33:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e088bd91001141302l291261a7p366ac54659534a9c@mail.gmail.com>
References: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
	<364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
	<5e088bd91001141302l291261a7p366ac54659534a9c@mail.gmail.com>
Date: Thu, 14 Jan 2010 13:33:16 -0800
Message-ID: <364299f41001141333v714a43ecv9d3e90c0ef6b2cba@mail.gmail.com>
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

On Thu, Jan 14, 2010 at 1:02 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Thu, Jan 14, 2010 at 11:25 AM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>
>>> There was really only one glitch in the build process (looking for
>>> libraries in an odd location) and I am now in the process of running
>>> the test.
>>
>> Please -- if you find bugs CC the list so I can resolve them as soon
>> as possible -- thanks :).
>
> I redid the build and everything worked perfectly, so that initial
> glitch was probably my fault!

Well, you never know... it always does help to learn where things went
wrong so processes and methods can be improved...

>> x86* is still the primary target architecture. I'd like to see the
>> failures, but yes my Fedora 12 VM is LTP `result clean', whereas the
>> MIPS and PPC 2.6.24* embedded devices at work have issues with some
>> tests due to architectural bugs, kernel bugs, and some test bugs.
>>
>> Please let us know how it goes though so we can try and work out the
>> issues with your ARM embedded DUT.
>
> I've got the results of the 1st run. =A0What is the normal way to share
> the results?

Pastebin?
Thanks :),
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
