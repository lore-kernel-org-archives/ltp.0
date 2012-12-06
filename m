Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TgYzS-0003cs-5w
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 10:47:38 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TgYzP-0003gK-8M
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 10:47:38 +0000
Date: Thu, 6 Dec 2012 05:47:29 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1066768064.11351529.1354790849174.JavaMail.root@redhat.com>
In-Reply-To: <50C06D55.2020903@mips.com>
MIME-Version: 1.0
Subject: Re: [LTP] clone03/06 randomly crashing
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
To: Pete/Piet Delaney <piet@mips.com>
Cc: ltp-list@lists.sourceforge.net, Chris Dearman <chris@mips.com>



----- Original Message -----
> From: "Pete/Piet Delaney" <piet@mips.com>
> To: "Carmelo AMOROSO" <carmelo.amoroso@st.com>
> Cc: ltp-list@lists.sourceforge.net, "Chris Dearman" <chris@mips.com>
> Sent: Thursday, 6 December, 2012 11:03:01 AM
> Subject: Re: [LTP] clone03/06 randomly crashing
> 
> On 12/06/2012 01:43 AM, chrubis@suse.cz wrote:
> > Hi!
> >>> It appears to be ltp-pan, which sees the child as orphan.
> >>> When I added "-d 511", I've got some additional output:
> >>>
> >>> <<<execution_status>>>
> >>> initiation_status="ok"
> >>> duration=0 termination_type=exited termination_id=0 corefile=no
> >>> cutime=0 cstime=0
> >>> <<<test_end>>>
> >>> pids still running:
> >>> orphans still running: -26125
> >>> clone03     1  TBROK  :  unexpected signal 15 received (pid =
> >>> 26126).
> >>> clone03     2  TBROK  :  Remaining cases broken
> >>>
> >>> pan was signaled with sig 2...
> >>>   propagating sig 2 to orphaned pgrp -26125
> >>> orphans still running:
> >>>
> >>> I'll send a patch, that adds wait() to parent.
> Could ya send me a copy of the patch to try.
> I've been experiencing a problem with clone06
> on Android LTP testing this evening. Would likely
> save me some time to see and try the patch.

I've met 2 issues, details are linked in description:
https://github.com/linux-test-project/ltp/commit/db68aaa3bbc7c42f15535cc77e81691940f7b1bc
https://github.com/linux-test-project/ltp/commit/443d16ede4dd9074faa00a98b8f9cdf22e5c168f

Regards,
Jan


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
