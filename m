Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbFW3-0005Hf-Ut
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 15:13:27 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbFVy-00071r-5j
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 15:13:27 +0000
Message-ID: <4A82DC0A.3050502@canonical.com>
Date: Wed, 12 Aug 2009 10:13:14 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <4A7AEE38.60101@canonical.com>
	<364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
In-Reply-To: <364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
Subject: Re: [LTP] fix lib6 test building
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett Cooper wrote:
> On Thu, Aug 6, 2009 at 7:52 AM, Paul Larson<paul.larson@canonical.com> wrote:
>> The lib6 tests seem to fail the first pass through building for me
>> because ranlib does not seem to get set correctly at any point.  This
>> seems to fix it up for me.
> 
> Fixed on HEAD moments ago:
> 
> gcooper@orangebox /scratch/ltp-dev2/ltp $ cvs diff
> testcases/network/lib6/Makefile
> Index: testcases/network/lib6/Makefile
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/network/lib6/Makefile,v
> retrieving revision 1.6
> diff -r1.6 Makefile
> 25a26,27
>> RANLIB                ?= ranlib
The patch you checked in does not correct the build failure.

Thanks,
Paul Larson

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
