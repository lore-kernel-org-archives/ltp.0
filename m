Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NGZXg-0000AY-GH
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 14:53:56 +0000
Date: Fri, 4 Dec 2009 15:54:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091204145439.GA8628@saboteur.suse.cz>
References: <20091116151656.GB16811@schrodinger.suse.cz>
	<20091203152731.GA10251@refried.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091203152731.GA10251@refried.org>
Subject: Re: [LTP] [RFC] utstest.h
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
To: Nate Straz <nate-ltp@refried.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is one of the many features that were included in the original
> libraries which no one in the community really explored.  The purpose of
> TEST_PAUSE is to allow multiple tests to complete their setup steps
> before being released at the same time.  This allows tests to hammer
> syscalls at relatively the same time and test race conditions.

Yes, but the question here is if this must be done this way. And if anybody
uses this.

And also this interface is not used in all tests. Quick greping shows that it's
used moslty in testcases/kernel/ (there are 12 test outside this directory) and
in about 56% of tests there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
