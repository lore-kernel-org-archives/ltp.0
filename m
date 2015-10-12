From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Oct 2015 19:43:16 +0200
Subject: [LTP] [PATCH v3] fcntl/fcntl32.c: add F_SETLEASE and F_WRLCK
 argument test
In-Reply-To: <5614ED3A.10609@cn.fujitsu.com>
References: <55EFA462.5010608@cn.fujitsu.com>
 <1442307339-16873-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20150930164132.GC8256@rei.suse.cz> <5614ED3A.10609@cn.fujitsu.com>
Message-ID: <20151012174315.GA24472@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Same as the second one. I would preffer figuring out that the fcntl() is
> > unsupported by actually trying to use it.
> > 
> 
> It will return EAGAIN when we actually use it, I don't think it's a reasonable errno,
> since on ramfs or tmpfs, when opening or creating a new file, the dentry->d_count
> will get an extra count to be 2 but not 1. Please have a look at the following link:
> http://www.gossamer-threads.com/lists/linux/kernel/913113

Hmm, so the kernel thinks that the file has been opened two times
allready and returns EAGAIN when we try the lock. It may be better to
just to skip these filesystems as you did then, since it's unlikely that
somebody will fix this in kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
