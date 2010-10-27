Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB4Ae-0006y2-Gk
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:27:56 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB4Ad-0004iY-BG
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:27:56 +0000
Received: by yxe42 with SMTP id 42so299520yxe.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:27:50 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 12:27:49 +0100
Message-ID: <AANLkTi=4D4yhyXoH4XWvi9NWjrZS9gaDeW+YcedHb5Mp@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] realtime test use of hostname with busybox
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

Another one... The realtime test script :
   testcases/realtime/scripts/setenv.sh

uses "hostname --short" which isn't supported by busybox. "hostname
-s" is supported but gives "hostname: unknown host". Given that every
other script uses "hostname" as-is I reckon it would be reasonable to
match that usage in this script too?

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
