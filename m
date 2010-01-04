Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRr3n-0004Yf-Qm
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:49:43 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRr3l-0005RZ-J1
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:49:43 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04Hl2uN008122
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 10:47:02 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o04HnQFF231760
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 10:49:28 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o04HnMQ6019957
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 10:49:22 -0700
Date: Mon, 4 Jan 2010 11:49:25 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104174925.GA1208@us.ibm.com>
References: <4B421480.1040400@petalogix.com>
	<20100104164954.GB26962@us.ibm.com>
	<4B4226E9.6000309@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B4226E9.6000309@petalogix.com>
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
> Serge E. Hallyn wrote:
> >Quoting Michal Simek (michal.simek@petalogix.com):
> >>Hi Mike,
> >>
> >>I have one question about one your big patch
> >>
> >>http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018
> >>
> >>My question is why you add -1 in lib/cloner.c:65
> >>
> >>+       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
> >>+                       clone_flags, arg);
> >>
> >>In previous code in clone testcases was nothing like this.
> >>What reason have you had to add it?
> >
> >Because the same thing was done in lots of places all over the
> >testsuite (and done wrong).  This consolidates them all.
> 
> 
> I don't have anything against consolidation. I just want to know why
> there is that -1 which weren't in any clone testcases. Nothing more
> nothing less.

ooooh.  Because if we've done stack = malloc(stack_size), then
stack+stack_size is 1 above the the top of stack.

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
