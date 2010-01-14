Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sakoman@gmail.com>) id 1NVWpe-0007Fo-Ci
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:02:18 +0000
Received: from qw-out-1920.google.com ([74.125.92.149])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVWpd-0006Yu-IT
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:02:18 +0000
Received: by qw-out-1920.google.com with SMTP id 14so29296qwa.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 13:02:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
References: <5e088bd91001140916n6b6d9979m3847be14d86c7920@mail.gmail.com>
	<364299f41001141125v56ef5ac0sfa58acd70b6e7775@mail.gmail.com>
Date: Thu, 14 Jan 2010 13:02:04 -0800
Message-ID: <5e088bd91001141302l291261a7p366ac54659534a9c@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 11:25 AM, Garrett Cooper <yanegomi@gmail.com> wrote:

>> There was really only one glitch in the build process (looking for
>> libraries in an odd location) and I am now in the process of running
>> the test.
>
> Please -- if you find bugs CC the list so I can resolve them as soon
> as possible -- thanks :).

I redid the build and everything worked perfectly, so that initial
glitch was probably my fault!

> x86* is still the primary target architecture. I'd like to see the
> failures, but yes my Fedora 12 VM is LTP `result clean', whereas the
> MIPS and PPC 2.6.24* embedded devices at work have issues with some
> tests due to architectural bugs, kernel bugs, and some test bugs.
>
> Please let us know how it goes though so we can try and work out the
> issues with your ARM embedded DUT.

I've got the results of the 1st run.  What is the normal way to share
the results?

Steve

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
