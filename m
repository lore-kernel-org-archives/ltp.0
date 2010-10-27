Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB47b-0002fg-RP
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:24:47 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB47b-0001of-1W
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:24:47 +0000
Received: by yxe42 with SMTP id 42so297525yxe.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:24:41 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 12:24:41 +0100
Message-ID: <AANLkTimEXJFo6vDOxKb_Q=_F92Rcr_xU289N18M6khVu@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] Shell usage on embedded targets
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

In our embedded rootfs we have both /bin/sh provided by busybox (i.e.
a true sh) and also a /bin/bash compiled from bash.

This causes a pain as typically full systems use a symlink from sh to
bash. This breaks runltp (and probably other scritps) as they use
getopts which I *think* is technically a bash-only builtin? I've
currently re-written the hashbangs before copying to the system. For
those googling I did :
   find . -type f | xargs perl -pi -e 's/bin\/sh/bin\/bash/g'

I can't get my head around what a 'neat' solution would be other than
rewriting all to bash but I'm guessing that isn't a favoured choice
for most people? I would expect a fair response would be "don't do odd
things with your target" ;-)

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
