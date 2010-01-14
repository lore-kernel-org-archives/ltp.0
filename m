Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVVKV-0002Tg-BN
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 19:26:03 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVVKU-0007dg-3f
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 19:26:03 +0000
Received: by pxi38 with SMTP id 38so625101pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 11:25:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
References: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
Date: Thu, 14 Jan 2010 11:25:50 -0800
Message-ID: <364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
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

Hi Steve!

On Thu, Jan 14, 2010 at 9:16 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> I've just begun working with ltp on an embedded linux platform
> (OMAP3530, 256MB RAM, 8GB flash rootfs, ethernet, linux 2.6.32)
>
> I'm using the December 2009 Stable version of ltp.
>
> There was really only one glitch in the build process (looking for
> libraries in an odd location) and I am now in the process of running
> the test.

Please -- if you find bugs CC the list so I can resolve them as soon
as possible -- thanks :).

> I've found it necessary to disable a few tests because of hangs or
> running out of memory (all of the clone syscall tests, msgctl10 and
> 11, pipeio_5 and hackbench01)

hackbench has issues running on resource limited architectures.
msgctl10 also pounds the living stuffing out of the OS because it
allocates so many processes. The clone tests? Maybe...

> Is this typical for limited resource machines?

Yes, but we may be able to fine tune these points to be more
respecting for platforms with a lower amount of resources.

> The test is still running. =A0Most tests are passing but there are more
> failures than I would like to see. =A0Should I expect all of the tests
> to pass on a machine like this?

x86* is still the primary target architecture. I'd like to see the
failures, but yes my Fedora 12 VM is LTP `result clean', whereas the
MIPS and PPC 2.6.24* embedded devices at work have issues with some
tests due to architectural bugs, kernel bugs, and some test bugs.

Please let us know how it goes though so we can try and work out the
issues with your ARM embedded DUT.

Thanks!
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
