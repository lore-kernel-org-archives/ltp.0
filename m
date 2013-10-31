Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vbtpk-0002De-Tg
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 15:06:52 +0000
Date: Thu, 31 Oct 2013 16:06:32 +0100
From: chrubis@suse.cz
Message-ID: <20131031150632.GB20620@rei.Home>
References: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
	<1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1608129004.16193796.1383140734531.JavaMail.root@redhat.com>
	<52720CC8.7070000@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52720CC8.7070000@oracle.com>
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
There are child/parent synchronization primitives in the LTP library.
See include/tst_checkpoint.h and lib/tests/tst_checkpoint_child.c.

All that is needed is to initialize checkpoint, call wait in parent and
once child is ready call signal in child. That will fix the first race.

Once child signals the parent it needs to wait till the parent executes
the test, simple pause() in child and kill() from parent should fix this
part.

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
