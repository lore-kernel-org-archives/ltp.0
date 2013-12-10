Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VqIJt-0000AI-J1
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 08:05:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VqIJr-0005yQ-R1
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 08:05:29 +0000
Message-ID: <1386662708.2253.5.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Tue, 10 Dec 2013 16:05:08 +0800
In-Reply-To: <1984791658.2366560.1386662045610.JavaMail.root@redhat.com>
References: <1386590786.2041.6.camel@G08JYZSD130126>
	<121189672.2070796.1386605732731.JavaMail.root@redhat.com>
	<1984791658.2366560.1386662045610.JavaMail.root@redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v3 2/2] clone/clone08.c: Add new flags
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, 2013-12-10 at 02:54 -0500, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
> > From: "Jan Stancek" <jstancek@redhat.com>
> > To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
> > Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Monday, 9 December, 2013 5:15:32 PM
> > Subject: Re: [LTP] [PATCH v3 2/2] clone/clone08.c: Add new flags
> > 
> > 
> > 
> > I was running v3 with only "CLONE_THREAD" testcase enabled:
> > -       {"CLONE_PARENT", CLONE_PARENT | CLONE_VM | SIGCHLD, NULL,
> > -        child_clone_parent},
> > -       {"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | CLONE_VM | SIGCHLD, NULL,
> > -        child_clone_child_settid},
> > -       {"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD,
> > NULL,
> > -        child_clone_parent_settid},
> > -#ifdef CLONE_STOPPED
> > -       {"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
> > -        test_clone_stopped, child_clone_stopped},
> > -#endif
> > 
> > and I see it failing/crashing sometimes. I usually see one of these failures:
> > 
> > 1. clone08     4  TBROK  :  Failed to read from pipe at clone08.c:168:
> > errno=EAGAIN(11): Resource temporarily unavailable
> > 2. clone08     1  TBROK  :  The other end of the pipe was closed unexpectedly
> > at clone08.c:168
> > 3. clone08     4  TPASS  :  test CLONE_THREAD success
> >    clone08     1  TBROK  :  unexpected signal 11 received (pid = 8234).
> >    clone08     2  TBROK  :  Remaining cases broken
> >    clone08     1  TFAIL  :  son process exits error
> > 4. no error, but test doesn't execute as many times as specified on command
> > line
> > 5. clone08     1  TBROK  :  unexpected signal 4 received (pid = 28936).
> 
> Some of above are caused by multiple threads reusing same stack area.
> Trouble is that with single master child you can't be sure when
> CLONE_THREAD child finished using its stack.
> 
> The idea I mentioned in v2 was basically what you did, but the loop for testcases
> would be outside master child - which means spawning master_child for each testcase.
> 
> I'm travelling these days, but I can have a look at idea above later this week
> and see how viable it is.
> 

OK, thanks. I am working on it.

Best regards,
Zeng

> Regards,
> Jan
> 
> > 
> > Regards,
> > Jan
> > 
> > ------------------------------------------------------------------------------
> > Sponsored by Intel(R) XDK
> > Develop, test and display web and hybrid apps with a single code base.
> > Download it for free now!
> > http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 



------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
