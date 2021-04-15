From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Apr 2021 13:05:32 +0200
Subject: [LTP] [PATCH] Modify the test logic of mincore.
In-Reply-To: <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
References: <20210330104613.1059-1-zhanglianjie@uniontech.com>
 <YHRcJOUer87SUn6v@yuki>
 <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
Message-ID: <YHgd/NDLJzz68uDl@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This does not make any sense, the kernel commit explicitly states that
> > all mapped pages are reported as in core. We do call mlock() in the
> > child, which will fault all the pages and lock them in memory. So the
> > test should work both before and after the fix as well.
> > 
> > The kernel commit in question weakened mincore() in a sense that it's
> > more likely to report pages in core than it previously was. Now all that
> > is needed is to fault the pages by reading some bytes from them to make
> > sure they are reported as in core.
> > 
> > If the test fails for you, something is probably broken at your end.
> > 
> 
> Using the CVE patch on mips, the test will fail because the child 
> process mlocks all pages, but the parent process cannot obtain these 
> pages through mincore and is locked.

Sounds like a kernel bug.

-- 
Cyril Hrubis
chrubis@suse.cz
