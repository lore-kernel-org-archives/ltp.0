Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MevNL-0007E0-IY
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 18:31:39 +0000
Received: from qw-out-1920.google.com ([74.125.92.144])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MevNE-0001dJ-Nb
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 18:31:39 +0000
Received: by qw-out-1920.google.com with SMTP id 5so822342qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 22 Aug 2009 11:31:26 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 22 Aug 2009 11:31:26 -0700
Message-ID: <364299f40908221131h75bad0bdm85d5831cf8bddeda@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Schedule for makefile-infra-rework to hit HEAD
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi all,
    Given the fact that the intermediate date has already passed for
the August snapshot, the earliest date that I can have this hit the
tree is right after the August release. I want a full cycle of testing
to be done for any and all nits to be worked out with my changes, so
committing now would be foolish.
    I'm working on out-of-buildtree support, as I found a few nits
during this process so I'll commit the critical items as soon as
possible. Would anyone oppose me committing after the August snapshot
given that it works at the same level of functionality as the current
version (and improves upon it in a number of other areas)?
Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
