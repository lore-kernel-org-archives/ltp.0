Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vbv8G-0005Yz-9V
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 16:30:04 +0000
Date: Thu, 31 Oct 2013 17:29:44 +0100
From: chrubis@suse.cz
Message-ID: <20131031162944.GE20620@rei.Home>
References: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
	<1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1608129004.16193796.1383140734531.JavaMail.root@redhat.com>
	<52720CC8.7070000@oracle.com> <20131031150632.GB20620@rei.Home>
	<52727305.5070806@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52727305.5070806@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] setpgid03: use SIGUSR1 instead of sleep
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> 
> But I need an exec() in the second case.

I've overlooked the second case, however checkpoint works for this one
as well. You need to build a helper binary setpgid03_child.c that would
call the signal function and then do the wait.

The checkpoint interface is build on the top of unix sockets so it does
not matter whether the process was forked, execed or started from
termial. All that is needed is correct CWD (which is inherited both on
fork and exec) so that the socked special file is found.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
