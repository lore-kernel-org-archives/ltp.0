Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VqI91-0001OZ-AH
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 07:54:15 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VqI8z-0006He-QU
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 07:54:15 +0000
Date: Tue, 10 Dec 2013 02:54:05 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1984791658.2366560.1386662045610.JavaMail.root@redhat.com>
In-Reply-To: <121189672.2070796.1386605732731.JavaMail.root@redhat.com>
References: <1386590786.2041.6.camel@G08JYZSD130126>
	<121189672.2070796.1386605732731.JavaMail.root@redhat.com>
MIME-Version: 1.0
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
> Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 9 December, 2013 5:15:32 PM
> Subject: Re: [LTP] [PATCH v3 2/2] clone/clone08.c: Add new flags
> 
> 
> 
> I was running v3 with only "CLONE_THREAD" testcase enabled:
> -       {"CLONE_PARENT", CLONE_PARENT | CLONE_VM | SIGCHLD, NULL,
> -        child_clone_parent},
> -       {"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | CLONE_VM | SIGCHLD, NULL,
> -        child_clone_child_settid},
> -       {"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD,
> NULL,
> -        child_clone_parent_settid},
> -#ifdef CLONE_STOPPED
> -       {"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
> -        test_clone_stopped, child_clone_stopped},
> -#endif
> 
> and I see it failing/crashing sometimes. I usually see one of these failures:
> 
> 1. clone08     4  TBROK  :  Failed to read from pipe at clone08.c:168:
> errno=EAGAIN(11): Resource temporarily unavailable
> 2. clone08     1  TBROK  :  The other end of the pipe was closed unexpectedly
> at clone08.c:168
> 3. clone08     4  TPASS  :  test CLONE_THREAD success
>    clone08     1  TBROK  :  unexpected signal 11 received (pid = 8234).
>    clone08     2  TBROK  :  Remaining cases broken
>    clone08     1  TFAIL  :  son process exits error
> 4. no error, but test doesn't execute as many times as specified on command
> line
> 5. clone08     1  TBROK  :  unexpected signal 4 received (pid = 28936).

Some of above are caused by multiple threads reusing same stack area.
Trouble is that with single master child you can't be sure when
CLONE_THREAD child finished using its stack.

The idea I mentioned in v2 was basically what you did, but the loop for testcases
would be outside master child - which means spawning master_child for each testcase.

I'm travelling these days, but I can have a look at idea above later this week
and see how viable it is.

Regards,
Jan

> 
> Regards,
> Jan
> 
> ------------------------------------------------------------------------------
> Sponsored by Intel(R) XDK
> Develop, test and display web and hybrid apps with a single code base.
> Download it for free now!
> http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
