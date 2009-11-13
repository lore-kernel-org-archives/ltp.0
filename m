Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1N8y9B-0004nd-W8
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 15:33:13 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1N8y9B-0000Gy-Lu@d45xhf1.ch3.sourceforge.com>
Date: Fri, 13 Nov 2009 15:33:13 +0000
Subject: [LTP] [ ltp-Bugs-2897301 ] undefined variable in tcp4-uni-basic01
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

Bugs item #2897301, was opened at 2009-11-13 17:33
Message generated for change (Tracker Item Submitted) made by radolin
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2897301&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Network - Other Tests
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Radoslav Kolev (radolin)
Assigned to: Nobody/Anonymous (nobody)
Summary: undefined variable in tcp4-uni-basic01

Initial Comment:
I am using ltp-full-20091031

A lot of the TCP tests involving packet loss fail with this error:

./tcp4-uni-basic01: line 394: netem_param: unbound variable

The reason is that strict checking for undefined variables is enabled with "set -u", but the variable netem_param is not always defined before testing its contents.

The fix I have applied is to initialize the netem_param variable with an empty string. In  tcp4-uni-basic01 add around line 381:

netem_param=""

Now the tests pass without problem.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2897301&group_id=3382

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
