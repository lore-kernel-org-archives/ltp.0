Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MIwrc-0005ZV-5T
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 03:40:04 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIwrb-0007g7-0g
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 03:40:04 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 7A6791AB22
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 20:40:00 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 22 Jun 2009 20:34:46 -0700
Message-ID: <8368651DACC1964480F951191B94A078BC0BBA@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] Reasoning behind Ltp-pan etc installed under /opt/ltp
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

Can someone explain to me the reasoning for the several LTP binaries/includes/tools/libs etc are now installed onto /opt/ltp via PREFIX additions to these makefiles?

I don't see runltp using these at all, instead they use ${LTPROOT} version which are set to the directory they are built by default.

Thanks,





 

------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
