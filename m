Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1MxRO1-0004uT-8F
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 20:20:53 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1MxRO1-0004L3-2G@665xhf1.ch3.sourceforge.com>
Date: Mon, 12 Oct 2009 20:20:53 +0000
Subject: [LTP] [ ltp-Bugs-2877261 ] diotest failing with tmp dir creation
	errors
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
To: noreply@sourceforge.net

Bugs item #2877261, was opened at 2009-10-12 14:19
Message generated for change (Comment added) made by mrwenzel
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2877261&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: None
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: mrwenzel (mrwenzel)
Assigned to: Nobody/Anonymous (nobody)
Summary: diotest failing with tmp dir creation errors

Initial Comment:
If I start a default test run with runltp, all of the diotest runs except diotest1 will fail with an error that mkdtemp hit no such file or directory.  It appears that the tmp directory is getting removed somehow after the first test and then all the subsequent tests fail.  I can get around the problem by not specifying a tmp dir option to runltp and instead setting an environment variable for TDIRECTORY which according to tst_tmpdir code is not removed.

----------------------------------------------------------------------

>Comment By: mrwenzel (mrwenzel)
Date: 2009-10-12 14:20

Message:
Forgot to add; I'm using version ltp-full-20090831

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2877261&group_id=3382

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
