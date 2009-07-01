Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sukadev@linux.vnet.ibm.com>) id 1MMQ5b-0005wX-9m
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 17:28:51 +0000
Received: from [32.97.110.151] (helo=e33.co.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MM5zI-0003tF-EN
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 20:01:02 +0000
Date: Wed, 1 Jul 2009 12:56:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <20090701195605.GA23307@us.ibm.com>
References: <20090701165923.GC3237@in.ibm.com>
	<20090701182005.GC17998@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090701182005.GC17998@us.ibm.com>
Subject: Re: [LTP] [PATCH] Fix pidns14 test case
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sf.net, "M. Mohan Kumar" <mohan@in.ibm.com>, sachinp@in.ibm.com

Serge E. Hallyn [serue@us.ibm.com] wrote:
| Quoting M. Mohan Kumar (mohan@in.ibm.com):
| > [PATCH] pidns14
| > 
| > Container-init may be immune to unhandled fatal signals (like SIGUSR1)
| > even if they are from ancestor namespace. SIGKILL/SIGSTOP are the only
| > reliable signals to a container-init from ancestor namespace. Make sure
| > that container-init will not respond to signals other than
| > SIGKILL/SIGSTOP
| 
| Hmm?  This may or may not be right...  but you start out by saying 'may be
| immune to', then provide a patch making the testcase TFAIL if is not immune
| to.  So at the very least anyone on a slightly older kernel will get TFAILs.
| 
| I don't think that immunity to SIGUSR1 from ancestor pidns is something we
| want to guarantee, it's just what is happening.  The proper thing is to
| not depend on either getting or not getting SIGUSR1, in my opinion.  Suka?

Yes we did confirm that there is a test for SIGKILL from parent ns.
We discussed in the bug report on whether to drop or modify the test,
but leaned towards modifying the test bc if SIGUSR1 does kill a container
init, then something has changed in the sig_ignored() checks in the kernel.

Hmm, not a very strong reason to keep the test.  Lets just drop the test :-)

Sukadev

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
