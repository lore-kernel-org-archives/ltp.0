Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Tj9di-0001yI-6l
	for ltp-list@lists.sourceforge.net; Thu, 13 Dec 2012 14:19:54 +0000
Date: Thu, 13 Dec 2012 15:19:46 +0100
From: chrubis@suse.cz
Message-ID: <20121213141946.GA10891@rei>
References: <153425741.15364762.1355407029689.JavaMail.root@redhat.com>
	<626133251.15365547.1355407159471.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <626133251.15365547.1355407159471.JavaMail.root@redhat.com>
Subject: Re: [LTP] Add easy to use API for parent-child synchronization.
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
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> am I reading it correctly, that you can only use it for single
> parent and child pair because the pipe name is pre-defined?

There is only one hardcoded pipe to keep the interface simple as I
haven't found testcase that would require more that this (that doesn't
mean there is none).

> Could be name of the pipe passed in tst_checkpoint_init()?
> The testcase I have in mind is 'waitid02' which spawns multiple children.

That shouldn't be a problem as far as you don't need to distinguish
between the childrens. Just call TST_CHECKPOINT_PARENT_WAIT() the number
of children you need to to wait for and it should work.

Each children would then write exactly one character to the fifo once
it's ready and the parent would wait until all childrens signaled that
they are ready.

Or even better we can easily create second version of parent wait that
would have number of children as an argument.

If you need something more complicated (i.e. synchronize several
childrens and parent) we can easily add filename parameter to the
checkpoint init and default to the current behavior if NULL is passed.

-- 
Cyril Hrubis
chrubis@suse.cz

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
