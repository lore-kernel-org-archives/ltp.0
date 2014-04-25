Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1Wdgeu-0000un-G5
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 13:59:20 +0000
Received: from smtp-out3.electric.net ([72.35.12.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wdget-0002in-Ju
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 13:59:20 +0000
Received: from 1Wdgem-0002T8-U5 by out3c.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1Wdgen-0002VX-Ta
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 06:59:13 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3c.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1Wdgem-0002T8-U5
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 06:59:12 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Fri, 25 Apr 2014 13:59:03 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C1C306C01@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ip_tests.sh: don't use hardcoded eth0
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi, Simon!

> Could anyone help to review this?

At least one of the existing network scripts does this, not sure which one.
It annoyed my lab-mates when it started sending on an interface I didn't want it to send on.

I'd like to see documented in the top-level INSTALL that the hostname needs to corresponds to the network-interface intended for test traffic.
(That would go with the rest of the network-test preparation instructions.)
And also that other tests which hard-code eth0 or any other interface also do this check.
Maybe an environment variable can specify preference, then fall back to hostname check like you propose in your patch?

Joseph

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
