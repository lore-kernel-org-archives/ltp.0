Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lmr@redhat.com>) id 1Npi2h-0007OC-DT
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 13:03:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Npi2g-0003z5-9l
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 13:03:11 +0000
From: Lucas Meneghel Rodrigues <lmr@redhat.com>
In-Reply-To: <364299f41003102111u7b24fd76i25b97c292d026af1@mail.gmail.com>
References: <364299f41003102111u7b24fd76i25b97c292d026af1@mail.gmail.com>
Date: Thu, 11 Mar 2010 10:03:00 -0300
Message-ID: <1268312580.2518.12.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [LTP] Remove libevent?
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, 2010-03-10 at 21:11 -0800, Garrett Cooper wrote:
> Hi all,
>     I just looked at the latest libevent, and I'm typically not one to
> suggest this, but because libevent switched over to libtool in the 2.x
> release (which is a pain in the ass to integrate), I think we just
> drop the libevent testcase(s). I assume the maintainers run their
> testcases on a subset of Unix machines, so it would just be an
> annoying earmark that LTP has to maintain a dead // useless version of
> libevent (eventually our version will go out of date and the code that
> we have will bear little relevance and may be more buggy than the
> latest version which should have appropriate tests and be executed and
> triaged appropriately upstream).

+1. Of course I am not in a position of saying something about what it
should be done, but I totally agree that LTP should strive in keeping
only well maintainted tests. It's harmful to keep unmantained code, it
bitrots and tends to make everyone's life difficult.

> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



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
