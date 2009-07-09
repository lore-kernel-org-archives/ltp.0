Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MOjG8-00086S-R0
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 02:21:16 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOjG2-00083P-EJ
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 02:21:16 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id DBBE91AD3A
	for <ltp-list@lists.sourceforge.net>;
	Wed,  8 Jul 2009 19:21:06 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 8 Jul 2009 19:14:48 -0700
Message-ID: <8368651DACC1964480F951191B94A078D013BE@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] Tests hanging on multi-core x86 machines
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

Has anyone noticed the following tests hanging intermittently on their multicore machines? The kernel being used is 2.6.28 (i686)


ppoll01
ptrace06
mq_timedrecieve01

These are all tests from Crackerjack and are fairly new. Most of the time these tests pass(or fail), but there's about a 10% chance the processes hang. For all I know there may be many other tests that exhibit the same thing, but I haven't stumbled upon it yet.  

Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


 

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
