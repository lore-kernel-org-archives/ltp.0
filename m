Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PB3y1-0001wl-F1
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:14:53 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3y0-0000YP-Jj
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:14:53 +0000
Received: by wwb17 with SMTP id 17so2607739wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:14:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTim=Q-2z4Ms4fZhaFReVJWnmnRg0+eZWBKfaoJXZ@mail.gmail.com>
References: <AANLkTim=Q-2z4Ms4fZhaFReVJWnmnRg0+eZWBKfaoJXZ@mail.gmail.com>
Date: Wed, 27 Oct 2010 04:14:46 -0700
Message-ID: <AANLkTimdbXkhGdrauwbV43Z7qkNMk7rWLjc0KQjY0Ckb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP on embedded systems re-visited
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 3:44 AM, David Peverley <pev@sketchymonkey.com> wrote:
> Hi all,
>
> Sorry I just realised I posted the previous message without a proper
> introduction email! So, Hello! I'm running LTP on an embedded ARM
> target and thought it would be worth bringing up what looks like an
> occasional on-off discussion for this list!
>
> I've got quite a lot of interesting discussion points but
> fundamentally I think there's a reasonable case for writing an
> "embedded LTP HOWTO" separate to the current HOWTO. This is to cover
> the differences in cross compiling environment, running remotely,
> busybox compat, test subset configuration etc. Is it worth me spending
> some time collating my notes from current experiences into a doc to
> submit? Looking in the archives, in 2008 Shane Volpe was looking into
> doing something similar but I couldn't find any eventual output from
> this?

    Sure. Multiple folks run LTP on embedded platforms on the list (I
used to run it on MIPS and PowerPC, but no longer work with the group
that developed on Linux, so I don't have access to that hardware), but
no one that I know of who uses busybox on the list (or at least hasn't
spoken up about using it recently).
    There are issues with shell portability and utilities that once
upon a time some folks who actively developed on the list (Cyril,
Mike, me) tried to track down and fix, but interest seems to have
waned. If you find any issues, please point them out and I'll try to
resolve them one at a time.
Thanks!
-Garrett

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
