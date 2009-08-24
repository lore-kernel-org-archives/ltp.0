Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mfiw8-0006IQ-SF
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 23:26:52 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mfiw3-0007cS-Hm
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 23:26:52 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1413842qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Aug 2009 16:26:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1251012586.16822.44.camel@subratamodak.linux.ibm.com>
References: <364299f40908221131h75bad0bdm85d5831cf8bddeda@mail.gmail.com>
	<1251012586.16822.44.camel@subratamodak.linux.ibm.com>
Date: Mon, 24 Aug 2009 16:26:40 -0700
Message-ID: <364299f40908241626v22effcd2p5ab84bc4f81e9352@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Schedule for makefile-infra-rework to hit HEAD
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
To: subrata@linux.vnet.ibm.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sun, Aug 23, 2009 at 12:29 AM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Sat, 2009-08-22 at 11:31 -0700, Garrett Cooper wrote:
>> Hi all,
>> =A0 =A0 Given the fact that the intermediate date has already passed for
>> the August snapshot, the earliest date that I can have this hit the
>> tree is right after the August release. I want a full cycle of testing
>> to be done for any and all nits to be worked out with my changes, so
>> committing now would be foolish.
>> =A0 =A0 I'm working on out-of-buildtree support, as I found a few nits
>> during this process so I'll commit the critical items as soon as
>> possible. Would anyone oppose me committing after the August snapshot
>> given that it works at the same level of functionality as the current
>> version (and improves upon it in a number of other areas)?
>
> Let me try the basic sanity checking. I would update you Garret.

Ok. I'm really close to finishing off out-of-buildtree support (~1.5
weeks with my other work), so I hope to add that seemingly `minor'
functionality before committing next month. It required some changes
to master_rules.mk because I wasn't approaching the problem correctly
100% in some areas, and some of the code wasn't as portable as it
should have been, and plus I wasn't following auto[conf|make]
convention 100%.

I'll recommit to the branch and generate another standard diff and an
rdiff so folks can run patch directly.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
