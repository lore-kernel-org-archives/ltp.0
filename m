Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRq89-0007VA-TJ
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 16:50:09 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRq88-0004xa-U5
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 16:50:09 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04Gh7OJ027359
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 09:43:07 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o04GnqvG054626
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 09:49:54 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o04GnogE012789
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 09:49:51 -0700
Date: Mon, 4 Jan 2010 10:49:54 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104164954.GB26962@us.ibm.com>
References: <4B421480.1040400@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B421480.1040400@petalogix.com>
Subject: Re: [LTP] clone tests fails
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
To: Michal Simek <michal.simek@petalogix.com>
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

Quoting Michal Simek (michal.simek@petalogix.com):
> Hi Mike,
> 
> I have one question about one your big patch
> 
> http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018
> 
> My question is why you add -1 in lib/cloner.c:65
> 
> +       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
> +                       clone_flags, arg);
> 
> In previous code in clone testcases was nothing like this.
> What reason have you had to add it?

Because the same thing was done in lots of places all over the
testsuite (and done wrong).  This consolidates them all.

> Of course the reason is that on Microblaze some tests failed.

How do they fail?  Does clone on Microblaze take the top of
stack?

-serge

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
