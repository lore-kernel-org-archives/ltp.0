Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNwC0-0007nK-9H
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:57:44 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNwBv-00047P-Er
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:57:44 +0000
Received: by yxe33 with SMTP id 33so5168180yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 14:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090706215111.GA32310@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<200907021435.48510.vapier@gentoo.org>
	<20090702203253.GI19135@count0.beaverton.ibm.com>
	<200907021809.18522.vapier@gentoo.org>
	<20090706215111.GA32310@count0.beaverton.ibm.com>
Date: Mon, 6 Jul 2009 14:57:30 -0700
Message-ID: <364299f40907061457k1fab116o4633e63f90a2e3b1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Remove bashisms (WAS Re: [PATCH 4/4] netns:
	Change interpretters from sh to bash)
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Jiri Palecek <jpalecek@web.de>, Jiri Palecek <jirka@debian.linux.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

On Mon, Jul 6, 2009 at 2:51 PM, Matt Helsley<matthltc@us.ibm.com> wrote:
> On Thu, Jul 02, 2009 at 06:09:16PM -0400, Mike Frysinger wrote:
>> On Thursday 02 July 2009 16:32:53 Matt Helsley wrote:
>> > On Thu, Jul 02, 2009 at 02:35:46PM -0400, Mike Frysinger wrote:
>> > > in general, converting sh to bash is a bad idea as it can cause issues
>> > > for us embedded peeps.
>> >
>> > I suppose that's because of the memory bash consumes. Is there anything
>> > else it does which is bad for embedded?
>>
>> there is memory and disk usage concerns, but there are also systems that cant
>> run bash at all (e.g. systems without fork() -- all no-mmu Linux ports)
>> -mike
>
> Here's that updated patch which hopefully should be able to replace 3
> and 4 of my recent series. Unfortunately I haven't had a chance to test it so
> I'm posting it in case someone else does. As the original author of the
> patch Jiri is welcome to add his signoff as well.
>
> From: Jiri Palecek <jirka@web.de>
>
> This patch removes a bunch of bashisms.
>
> It was originally written by Jiri Palecek but lacked changes
> requested by Mike Frysinger.
>
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

Hi Matt,
    Please see the comments I just made to his first diff submitted
back in May 25th. Many of the comments I made there apply to this
change as well.
Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
