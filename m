Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSnk8-0003fa-Pu
	for ltp-list@lists.sourceforge.net; Tue, 03 Mar 2015 14:24:16 +0000
Date: Tue, 3 Mar 2015 15:23:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150303142335.GA22464@rei>
References: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
	<20150302130439.GA16543@rei>
	<1750098575.20916844.1425303360282.JavaMail.zimbra@redhat.com>
	<20150302134716.GA11619@rei>
	<951353219.21574463.1425379677968.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <951353219.21574463.1425379677968.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] sched_setparam/9-1: fix hang on -rt kernel
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
> > > I think you're right in scenario with single CPU.
> > > In theory, is it possible that set_affinity() would be dummy, and one of
> > > ncpu-1 children running with max FIFO priority would preempt parent
> > > allowing test_process() to run before its priority is changed?
> > 
> > Aren't the child proceesses forked with the same priority as the parent?
> > In this case they shouldn't get executed for the same reason unless they
> > are migrated other CPUs. But yes then it's a kind of unpredictable which
> > is the reason we have the affinity call there.
> 
> Would you prefer I rewrite that comment? Or are you OK with the patch as it is?

It would be better to make the comment more clear.

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
