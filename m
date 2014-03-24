Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WS58v-00070E-Cs
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 13:42:21 +0000
Date: Mon, 24 Mar 2014 14:41:56 +0100
From: chrubis@suse.cz
Message-ID: <20140324134156.GA5660@rei.suse.cz>
References: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1390298574-2966-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140203170843.GA4298@rei> <532BC78F.9050208@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <532BC78F.9050208@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 3/3] fcntl/fcntl31.c: add I/O availability
 signals test for fcntl(2)
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
> > +}
> > +
> > +static void wait_io_ready(void)
> > +{
> > +	pid_t child;
> > +	int i;
> > +
> > +	fflush(stdout);
> > You should use tst_flush() or tst_fork() instead.
> >
> > Note: I've just added the tst_fork() and updated the test writing
> >       guidelines.
> >
> >> +	child = FORK_OR_VFORK();
> > The rest of the testcase would not run on uClinux so there is no reason
> > to use FORK_OR_VFORK() instead of fork().
> You said that the rest of the testcase would not run on uClinux, so
> we should use fork or tst_fork() directly.
> 
> Now I couldn't figure it out why the rest of the testcase would not run on uClinux,
> Makefile in syscalls does not filter out the fcntl directory. Could you give me some
> hint about this :-)

There is no fork() on uClinux, you have to emulate it using vfork()
which starts a new process but the memory of the two processes is still
shared (because there is no MMU) and if you do anything else than exec()
the result is undefined. To overcome this testcases ported to uClinux
self exec itself with special parameter that tells the test to run the
child function directly. Look at the lib/self_exec.c source.

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
