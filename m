Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WQGaa-0006is-82
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 13:31:24 +0000
Date: Wed, 19 Mar 2014 14:31:02 +0100
From: chrubis@suse.cz
Message-ID: <20140319133101.GA26802@rei>
References: <1392885919-27160-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140317180032.GB1807@rei> <53292C9E.6080207@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53292C9E.6080207@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] fcntl/fcntl31.c: add I/O availability signals
 test for fcntl(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > You can easily fix this problem if you read the byte from pipe in the parent
> > process (before or after the wait()).
> >
> >
> > And there is a small synchronization problem too. If the write() in the
> > signal_parent() is entered before the parent sleeps in sigtimedwait() the
> > signal is lost and the test fails.
> >
> > What we need to do is to ensure parents sleeps in sigtimedwait() before we
> > execute the write(). I guess that TST_PROCESS_STATE_WAIT() in child should work
> > here.
> 
> Thanks for pointing these two issues.
> My test work is not that complete, sorry.

Getting things right at first try is hard and everybody does mistakes...

Just keep up the good work you do ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
