Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YKpEa-0006ig-2S
	for ltp-list@lists.sourceforge.net; Mon, 09 Feb 2015 14:22:44 +0000
Date: Mon, 9 Feb 2015 15:22:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150209142225.GD7605@rei.suse.de>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-4-git-send-email-gux.fnst@cn.fujitsu.com>
	<20150209141952.GC7605@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150209141952.GC7605@rei.suse.de>
Subject: Re: [LTP] [PATCH v2 4/6] power_management: add uclinux check and
 move some check
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
> > index 9055964..0a66dc4 100755
> > --- a/testcases/kernel/power_management/runpwtests.sh
> > +++ b/testcases/kernel/power_management/runpwtests.sh
> > @@ -42,6 +42,7 @@ YES=0
> >  NO=1
> >  #List of reusable functions defined in pm_include.sh
> >  . pm_include.sh
> > +. pm_check_env.sh
> 
> Is the same check needed in more than one file?
> 
> Because if it's not there is no need to move it into separate file...

Ah, you split the file into separate testcases later. This change should
rather be part of that patch, or the reason why you move the check out
of the file should be part of the commit message for this patch.
Otherwise it does not make sense.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
