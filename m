Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1MZ7cE-0006US-1H
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 18:23:02 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZ7c8-0000ZT-Vh
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 18:23:01 +0000
From: Lucio Correia <ljhc@br.ibm.com>
In-Reply-To: <OFC57A047B.CF64D210-ON852575FB.007EFB24-852575FB.0081AD79@us.ibm.com>
References: <OFC57A047B.CF64D210-ON852575FB.007EFB24-852575FB.0081AD79@us.ibm.com>
Date: Thu, 06 Aug 2009 14:55:17 -0300
Message-Id: <1249581317.9358.11.camel@lucio-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] eventfd2_03
Reply-To: ljhc@br.ibm.com
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
To: Mark Ver <markver@us.ibm.com>
Cc: ltp-list@lists.sf.net

On Wed, 2009-07-22 at 19:36 -0400, Mark Ver wrote:
> Hi,
> 
> Just recently downloaded the 20090630 version LTP. But it looks like
> there is a new testcase "eventfd2_03" included as part of default
> which is getting a compile problem and causing the LTP build to abort
> on s390x architecture:
> 

Hi Mark,

I sent a patch to fix this issue for ppc on July 1st:

http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg07222.html

This patch also fixes some issues with the test suite, and I believe you
will just need to define the correct syscall number in the .in file for
s390x.

Regards,

-- 
Lucio Correia
Software Engineer
IBM LTC Brazil


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
