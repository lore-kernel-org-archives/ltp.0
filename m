Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NSMXw-0003zZ-1P
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 03:26:56 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSMXv-0003no-3g
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 03:26:56 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o063Jn12026564
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:19:49 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o063QjST108132
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:26:45 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o063Qif3027605
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:26:45 -0700
Date: Tue, 5 Jan 2010 21:26:44 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100106032644.GB8157@us.ibm.com>
References: <4B421480.1040400@petalogix.com>
	<20100104164954.GB26962@us.ibm.com>
	<4B4226E9.6000309@petalogix.com> <20100104174925.GA1208@us.ibm.com>
	<4B43E1CD.2050609@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B43E1CD.2050609@web.de>
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
To: Jiri Palecek <jpalecek@web.de>
Cc: Nathan T Lynch <natlynch@us.ibm.com>, vapier@gentoo.org, ltp-list@lists.sourceforge.net

Quoting Jiri Palecek (jpalecek@web.de):
> Serge E. Hallyn napsal(a):
> >Quoting Michal Simek (michal.simek@petalogix.com):
> >>Serge E. Hallyn wrote:
> >>>Quoting Michal Simek (michal.simek@petalogix.com):
> >>>>Hi Mike,
> >>>>
> >>>>I have one question about one your big patch
> >>>>
> >>>>http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018
> >>>>
> >>>>My question is why you add -1 in lib/cloner.c:65
> >>>>
> >>>>+       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
> >>>>+                       clone_flags, arg);
> >>>>
> >>>>In previous code in clone testcases was nothing like this.
> >>>>What reason have you had to add it?
> >>>
> >>>Because the same thing was done in lots of places all over the
> >>>testsuite (and done wrong).  This consolidates them all.
> >>
> >>
> >>I don't have anything against consolidation. I just want to know why
> >>there is that -1 which weren't in any clone testcases. Nothing more
> >>nothing less.
> >
> >ooooh.  Because if we've done stack = malloc(stack_size), then
> >stack+stack_size is 1 above the the top of stack.
> 
> If the value of the parameter is the stack pointer of the created
> thread, it shouldn't matter - the address should never be used (read
> or written).
> 
> Michal, I suspect the failures you see are somehow related to
> alignment (that your architecture doesn't like odd addresses). Is
> that right? Under x86, the address gets aligned (so some of the
> space is unused).
> 
> Perhaps both of these behaviors should be tested by LTP?

Gah, yes, Nathan had mentioned arches where this matters (including
some power?).  Nathan, did you have a generic fix for this in
userspace?  Should always be safe to do
	(stack + stack_size - 1) & ~0xf
?

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
