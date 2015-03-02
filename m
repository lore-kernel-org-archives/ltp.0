Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSQ8y-0000FS-BY
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 13:12:20 +0000
Date: Mon, 2 Mar 2015 14:11:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302131136.GB16543@rei>
References: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
	<8508ffa01798c137e7c2c50a7fd97e74702cc569.1425033440.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8508ffa01798c137e7c2c50a7fd97e74702cc569.1425033440.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] sched_setparam/10-1: remove testcase
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
Cc: jkastner@redhat.com, ltp-list@lists.sourceforge.net

Hi!
> As in 9-1, this hangs on -rt kernel, because alarm(2)
> never fires.
> 
> In case it runs on single cpu system, it's pretty
> much same as 9-1: child process of higher priority
> preempts parent.
> 
> In case it runs on 2+ CPUs, it doesn't matter that
> one child is able to preempt parent, shared value
> is going to be increased regardless in all other
> children.

Acked, this test is broken on 2+ CPUs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
