Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rkz4p-0005kO-9d
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 14:22:55 +0000
Date: Wed, 11 Jan 2012 15:34:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120111143418.GB7146@saboteur.suse.cz>
References: <20120111125642.GD7143@saboteur.suse.cz>
	<aa1139e7-47d6-40d4-8406-4cef27343f29@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa1139e7-47d6-40d4-8406-4cef27343f29@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > I still think that this is a workaround for something that should be
> > either avoided or fixed on different level.
> 
> I'm not sure we can avoid it (stdout is buffered by default),
> but I agree that we can probably do better than fixing it per-test.
> 
> Here's a smaller reproducer:
> 
> cat > a.c <<EOF
> #include <stdio.h>
> int main()
> {
>     printf("hello world\n");
>     fork();fork();
>     return 0;
> }
> EOF
> 
> gcc a.c
> ./a.out | cat
> hello world
> hello world
> hello world
> hello world
> 

I see, each of the forked processes still have the "hello world\n" in
the buffer which is printed from each of them after respective buffer is
flushed.

There are two ways to fix this, either create tst_fork() that flushes
the buffers before forking. This may be problematic as there is a need
for replacing fork() with tst_fork() in several testcases.

Or we could flush the output after each test message is printed with
tst_resm(). That is IMHO ideal solution. The only drawback is that this
may interfere with timings in some testcases (but testcases that expects
exacts timings are usually broken anyway).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
