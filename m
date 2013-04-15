Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1URnYi-0002zI-JS
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 17:51:16 +0000
Date: Mon, 15 Apr 2013 19:51:47 +0200
From: chrubis@suse.cz
Message-ID: <20130415175147.GC2405@rei>
References: <1365125797-31405-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<201304050053.46087.vapier@gentoo.org>
	<20130405090851.GC18134@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130405090851.GC18134@rei.Home>
Subject: Re: [LTP] [PATCH] getdents01: don't compare first entry to "."
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > this test isn't really useful after your change.  you've basically validated 
> > that the a valid fd and a large enough buffer was passed to the kernel and 
> > that's it.
> > 
> > you should have it walk the results to try and find an "." and ".." entry.
> 
> Yes, that would be even better. Or we can get even more creative and
> create a file or two in the setup and expect them to be in the listing.

FYI: I've just commited a patch that creates file, directory and symlink
     and makes sure that these are included in the listing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
