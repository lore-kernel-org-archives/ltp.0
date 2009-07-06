Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqSm-00057X-TH
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:50:40 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqSl-0002Uf-W9
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:50:40 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090701195605.GA23307@us.ibm.com>
References: <20090701165923.GC3237@in.ibm.com>
	<20090701182005.GC17998@us.ibm.com> <20090701195605.GA23307@us.ibm.com>
Date: Mon, 06 Jul 2009 21:20:23 +0530
Message-Id: <1246895423.4887.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix pidns14 test case
Reply-To: subrata@linux.vnet.ibm.com
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: "M. Mohan Kumar" <mohan@in.ibm.com>, sachinp@in.ibm.com, ltp-list@lists.sf.net

Suka,

So, what should i do finally ?? Drop this ?

Regards--
Subrata

On Wed, 2009-07-01 at 12:56 -0700, Sukadev Bhattiprolu wrote: 
> Serge E. Hallyn [serue@us.ibm.com] wrote:
> | Quoting M. Mohan Kumar (mohan@in.ibm.com):
> | > [PATCH] pidns14
> | > 
> | > Container-init may be immune to unhandled fatal signals (like SIGUSR1)
> | > even if they are from ancestor namespace. SIGKILL/SIGSTOP are the only
> | > reliable signals to a container-init from ancestor namespace. Make sure
> | > that container-init will not respond to signals other than
> | > SIGKILL/SIGSTOP
> | 
> | Hmm?  This may or may not be right...  but you start out by saying 'may be
> | immune to', then provide a patch making the testcase TFAIL if is not immune
> | to.  So at the very least anyone on a slightly older kernel will get TFAILs.
> | 
> | I don't think that immunity to SIGUSR1 from ancestor pidns is something we
> | want to guarantee, it's just what is happening.  The proper thing is to
> | not depend on either getting or not getting SIGUSR1, in my opinion.  Suka?
> 
> Yes we did confirm that there is a test for SIGKILL from parent ns.
> We discussed in the bug report on whether to drop or modify the test,
> but leaned towards modifying the test bc if SIGUSR1 does kill a container
> init, then something has changed in the sig_ignored() checks in the kernel.
> 
> Hmm, not a very strong reason to keep the test.  Lets just drop the test :-)
> 
> Sukadev


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
