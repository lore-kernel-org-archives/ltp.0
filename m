Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sakoman@gmail.com>) id 1NVY4K-00048s-Ta
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 22:21:32 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVY4H-0004x5-Vp
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 22:21:32 +0000
Received: by qw-out-1920.google.com with SMTP id 14so59383qwa.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 14:21:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e088bd91001141356s5703c677uc55d32b5fd5d8df7@mail.gmail.com>
References: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
	<364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
	<5e088bd91001141302l291261a7p366ac54659534a9c@mail.gmail.com>
	<364299f41001141333v714a43ecv9d3e90c0ef6b2cba@mail.gmail.com>
	<5e088bd91001141356s5703c677uc55d32b5fd5d8df7@mail.gmail.com>
Date: Thu, 14 Jan 2010 14:20:59 -0800
Message-ID: <5e088bd91001141420k3fb02aealadde94c4d2352bba@mail.gmail.com>
From: Steve Sakoman <sakoman@gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 1:56 PM, Steve Sakoman <sakoman@gmail.com> wrote:

>>> I've got the results of the 1st run. =A0What is the normal way to share
>>> the results?
>>
>> Pastebin?
>
> Here you go:
>
> http://pastebin.com/m483f4087

That seems to have truncated most of the results :-)

Let's try again:

http://www.sakoman.com/testresults/LTP_RUN_ON-2010_Jan_13-09h_31m_03s.log

Steve


>
> I ran the test with:
>
> ./runltp -d /opt/ltp
>
> And disabled the tests that gave me hang/oom errors:
>
> cloneXX (all)
> msgctl10
> msgctl11
> pipio_5
> hackbench01
>
> Let me know what you think! =A0I noticed that some of the final tests
> failed because the cron package was missing. =A0I'll fix that on the
> next run.
>
> Steve
>

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
