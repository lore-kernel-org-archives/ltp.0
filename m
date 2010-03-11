Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NpagE-0006w3-7j
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 05:11:30 +0000
Received: from mail-iw0-f191.google.com ([209.85.223.191])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpagD-0002bA-KF
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 05:11:30 +0000
Received: by iwn29 with SMTP id 29so5316353iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 21:11:24 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 10 Mar 2010 21:11:24 -0800
Message-ID: <364299f41003102111u7b24fd76i25b97c292d026af1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Remove libevent?
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

Hi all,
    I just looked at the latest libevent, and I'm typically not one to
suggest this, but because libevent switched over to libtool in the 2.x
release (which is a pain in the ass to integrate), I think we just
drop the libevent testcase(s). I assume the maintainers run their
testcases on a subset of Unix machines, so it would just be an
annoying earmark that LTP has to maintain a dead // useless version of
libevent (eventually our version will go out of date and the code that
we have will bear little relevance and may be more buggy than the
latest version which should have appropriate tests and be executed and
triaged appropriately upstream).
Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
