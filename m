Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VC9zK-0005j1-Bb
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 15:06:22 +0000
Date: Wed, 21 Aug 2013 17:06:24 +0200
From: chrubis@suse.cz
Message-ID: <20130821150624.GA5035@rei>
References: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
	<20130821102436.GA3894@rei> <20130821134121.GA4729@rei>
	<92780376.1937886.1377095931551.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92780376.1937886.1377095931551.JavaMail.root@redhat.com>
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
> > I've looked at the test and what it does is:
> > 
> > 1. create file and make sure it's empty
> > 2. truncate it to defined size
> > 3. parent starts writing zeroes to it with O_DIRECT
> > 4. childs reads it and expect to get zeroes at any time
> 
> Hi,
> 
> That looks correct, here's an strace excerpt:
> 
> 04:05:38.464923 open("/tmp/dio_sparse", O_RDWR|O_CREAT|O_EXCL|O_DIRECT, 0600) = 5
> 04:05:38.464985 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f7583c0da10) = 22242
> Process 22242 attached
> [pid 22242] 04:05:38.465142 open("/tmp/dio_sparse", O_RDONLY) = 6
> [pid 22234] 04:05:38.465369 ftruncate(5, 2048 <unfinished ...>
> [pid 22242] 04:05:38.465400 lseek(6, 0, SEEK_SET <unfinished ...>
> [pid 22234] 04:05:38.465458 <... ftruncate resumed> ) = 0
> [pid 22242] 04:05:38.465474 <... lseek resumed> ) = 0
> [pid 22234] 04:05:38.465509 write(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096 <unfinished ...>
> [pid 22242] 04:05:38.465540 read(6, "04:05:14.921896 execve(\"./dio_sp"..., 4096) = 2048
> [pid 22242] 04:05:38.482378 fstat(1, {st_mode=S_IFREG|0644, st_size=14502, ...}) = 0
> [pid 22242] 04:05:38.482419 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f7583c18000
> [pid 22242] 04:05:38.482473 write(1, "dummy not zero at 0, 0x30\n", 26dummy not zero at 0, 0x30
> ) = 26

So the read gets something that looks like part of the strace? How is
that even possible?

> > This should really work and I've been told by our filesystem guy that
> > this really looks like bug in the kernel (assuming that I haven't
> > overlooked something in the test source).
> 
> Do you know about any doc/source that says why it should work?
> In my search I only came across that man page, which seems to go in
> opposite way.

I simply asked Jan Kara.

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
