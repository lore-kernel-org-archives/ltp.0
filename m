Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MUZ94-0008DT-QM
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 04:46:06 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUZ8x-0000nS-He
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 04:46:06 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 4BC4F1B0B6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Jul 2009 21:45:53 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 24 Jul 2009 21:45:09 -0700
Message-ID: <8368651DACC1964480F951191B94A078E49F0B@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP]  modifying tests to use the configured tmp directory
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

One of our testing requirements forces us to use a user specified temporary directory. 

LTP provides the functions needed to do this (tst_tmpdir) and through the global variable $TMPDIR.

I've found a large amount of filesystem tests that do not honor this. Some of the tests have an argument you can pass in (such as a -d option for growfiles), and is set inside the runtest/scenario file (fs_inod01)

Does anyone have a preference on whether the tests should be modified to use the tst functions when possible, or use an optional argument?

Any comments appreciated,

Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
