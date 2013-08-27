Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEIqa-0004Gf-Gm
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 12:58:12 +0000
Date: Tue, 27 Aug 2013 14:58:14 +0200
From: chrubis@suse.cz
Message-ID: <20130827125814.GJ10995@rei.Home>
References: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
	<20130821102436.GA3894@rei> <20130821134121.GA4729@rei>
	<92780376.1937886.1377095931551.JavaMail.root@redhat.com>
	<20130821150624.GA5035@rei>
	<1843973614.1971535.1377606877922.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1843973614.1971535.1377606877922.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as
 writers
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > > This should really work and I've been told by our filesystem guy that
> > > > this really looks like bug in the kernel (assuming that I haven't
> > > > overlooked something in the test source).
> > > 
> > > Do you know about any doc/source that says why it should work?
> > > In my search I only came across that man page, which seems to go in
> > > opposite way.
> > 
> > I simply asked Jan Kara.
> 
> I brought this to attention of some local FS guys as well.
> I found I can trigger it on physical system too (24CPU Amd Opteron) as long as
> dio_sparse runs on ext4. I couldn't do the same with xfs.
> 
> I could trigger it quite easily with kernels going back to 3.3 and also
> with latest upstream 3.11-rc7 just by running:
> env TMPDIR=/mnt/ext4 ./dio_sparse  -a 4k -w 4k -s 2k -n 2
> in loop for couple minutes.

I thinked about the strace a bit and it looks to me like some dirty
memory buffer was reused without being cleared (the reader seen
something that appeared to be part of the strace output that presumbly
was being saved to the disk). Which may be real bug because you may
happen to see content of a file (that is being written to the disk) you
have no permission to read. But you probably know that allready.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
