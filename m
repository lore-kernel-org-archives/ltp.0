Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcWpY-0005O2-Tr
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 09:17:32 +0000
Date: Tue, 22 Apr 2014 11:16:40 +0200
From: chrubis@suse.cz
Message-ID: <20140422091639.GA2269@rei>
References: <53552199.6040004@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53552199.6040004@oracle.com>
Subject: Re: [LTP] OpenPosix mmap_11-4 fails
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> I observe that mmap_11-4 fails in my x86 environment with:
> 
> Test FAILED: Modification of the partial page at the end of an object is 
> written out

I've seen some failures lately too but haven't had time to look into
these yet.

> I did some googling and found that you rose this problem in 2012:
> http://linux-kernel.2935.n7.nabble.com/Partialy-mapped-page-stays-in-page-cache-after-unmap-td379857.html
> 
> I'm interested what you meant in your patch for the mmap's manual page 
> by "In some cases, this could be fixed by calling msync(2) before the 
> unmap takes place;"
> 
> What are these "some cases"?

That depends on whether is the mmaped file backed up by a disk based
filesystem or not.

Mapped pages are stored in a cache, so if you modify content of a page
that is beyond the mapping but inside the last page the data stays there
till they are written back to the disk and reloaded into the cache
(which can be forced by the msync()). For memory backed filesystems
(tmpfs etc) msync() is no-op because there is no permanent storage to
write the data to, so the rest of partial page is never cleared.

> I took your test program from the man thread and executed it on KVM and 
> on an Sun Ultra 45.
> 
> Here are the results:
> 
> 1. Debian 7 + KVM + 3.2.0-4-amd64
>   * without msync() it fails
>   * with msync() it fails
> 
> 2. Debian 7 + Ultra + 3.2.0-4-sparc64-smp
>   * without msync() it fails
>   * with msync() it passes (!!!)
> 
> So it looks like msync() on x86 doesn't help us. The question here if 
> it's a linux+x86 bug or not...

Is the /tmp/ filesystem the same?

> Could you check your test program and mmap_11-4 in your environment?

Added to my TODO but I'm not sure if I can get to this till the end of
the week.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
