Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N0ySj-000166-1l
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2009 14:16:21 +0000
Date: Thu, 22 Oct 2009 15:56:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091022135647.GA631@schrodinger.suse.cz>
References: <OF87E660BB.5D2E0F9D-ON85257655.005F2225-86257655.005F2F51@us.ibm.com>
	<364299f40910201401q7d1a6c67k32198b5487b5db92@mail.gmail.com>
	<OF5B77612C.4E892873-ON85257656.00664FFD-86257656.00666FA8@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF5B77612C.4E892873-ON85257656.00664FFD-86257656.00666FA8@us.ibm.com>
Subject: Re: [LTP] Fw: LTP vs. SLES11 -- Some FAILs.
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
To: Robert Paulsen <rpaulsen@us.ibm.com>
Cc: ltp-list@lists.sf.net

Hi!
> Thank for the reply. A couple of follow-up questions:
> 
>    If the tests are not written to the LTP standards why are they accepted
>    into he LTP? At least they should not be included in the default set of
>    tests that get run.
>    Is there any formal acceptance testing before a new/changed test is
>    accepted into the LTP?
> 

Well, ltp is quite old and some parts are legacy from old times, some parts are
just badly written and there is no manpower to fix that in short amount of
time. Instead of that we are trying to fix ltp incrementally. So when some test
are constantly reporting failures they are most likely broken. One sane way how
to intepret results from ltp is to compare results between kernel/system
updates and watch for changes (this generates half to half chance to catch real
bugs caused by changes in codebase the rest are just broken tests that needs to
be fixed).

-- 
Cyril Hrubis
chrubis@suse.cz

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
