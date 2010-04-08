Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NztsE-0007Kd-BO
	for ltp-list@lists.sourceforge.net; Thu, 08 Apr 2010 15:42:30 +0000
Date: Thu, 8 Apr 2010 17:48:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100408154826.GA24955@saboteur.suse.cz>
References: <20100402185908.GA478@saboteur.suse.cz>
	<g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix fs_perms tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > #!/bin/true
> >
> > Or maybe more robust:
> >
> > #!/bin/sh
> > true
> >
> > But I'm not sure if there is always /bin/true (as it's buildin in most of the
> > shells) or if I it's good idea to add dependecy for /bin/sh. But this would
> > avoid compiling dummy C program and copying it from $LTPROOT/testcases/bin/.
> >
> > Or we could do some trickery to embed the "dummy" binary file into the code as
> > array.
> 
> It could just be an empty file, or one with just a shebang. Example:
> 
> [gcooper@bayonetta ~]$ ./bar
> [gcooper@bayonetta ~]$ echo $?
> 0
> [gcooper@bayonetta ~]$ cat bar
> #!/bin/sh
> 
> `:' is an alternative to `true' too.

I did a little research what is going on when file is executed (and what is
standardized by POSIX).

Accordingly to posix standard, path to sh cannot be assumed /bin/sh either
/usr/bin/sh. However when file is executed by execlp() and kernel returns
ENOEXEC (because no binfmt handler was found for such file) it end up executed
by sh. So empty file (and wrong path to sh in shebang) should be safe as far as
kernel returns ENOEXEC (and as far as I understand sys_execve and friends from
linux/fs/exec.c this is true in case nobody plays with binfmt handlers) and
maybe may fail in very non standart enviroments. The most robust way seems to
be to look for sh in $PATH and create shebang accordingly.

Any thoughts?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
