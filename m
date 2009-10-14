Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyB0Q-0004Jp-UO
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 21:03:34 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyB0O-0001eJ-3W
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 21:03:34 +0000
Received: by pzk26 with SMTP id 26so160331pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 14:03:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 14:03:26 -0700
Message-ID: <364299f40910141403mc5e784bpa8c76113a95edbbf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 12] check_envval is looking for the locale command
	(doesn't exist on all systems)
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
To: LTP list <ltp-list@lists.sourceforge.net>

    I'm seeing a lot of output from network_stress.log with the following lines:

/tests/ltp/output/network_stress.whole-output.log:/tests/ltp/testcases/bin/check_envval:
line 48: locale: command not found

    Looks like the test needs to be integrated with cmdlib.sh and
check for the command before continuing.

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
