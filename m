Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB3a3-0000IS-JA
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 10:50:07 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3a2-0003wJ-NU
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 10:50:07 +0000
Received: by ywo32 with SMTP id 32so277907ywo.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 03:50:01 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 11:44:02 +0100
Message-ID: <AANLkTim=Q-2z4Ms4fZhaFReVJWnmnRg0+eZWBKfaoJXZ@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] LTP on embedded systems re-visited
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
To: ltp-list@lists.sourceforge.net

Hi all,

Sorry I just realised I posted the previous message without a proper
introduction email! So, Hello! I'm running LTP on an embedded ARM
target and thought it would be worth bringing up what looks like an
occasional on-off discussion for this list!

I've got quite a lot of interesting discussion points but
fundamentally I think there's a reasonable case for writing an
"embedded LTP HOWTO" separate to the current HOWTO. This is to cover
the differences in cross compiling environment, running remotely,
busybox compat, test subset configuration etc. Is it worth me spending
some time collating my notes from current experiences into a doc to
submit? Looking in the archives, in 2008 Shane Volpe was looking into
doing something similar but I couldn't find any eventual output from
this?

Cheers,

~Pev

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
