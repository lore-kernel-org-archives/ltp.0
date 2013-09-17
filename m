Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLy5J-00021a-K6
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 16:25:05 +0000
Date: Tue, 17 Sep 2013 18:25:23 +0200
From: chrubis@suse.cz
Message-ID: <20130917162523.GB14998@rei>
References: <1379418720-26529-1-git-send-email-alexey.kodanev@oracle.com>
	<20130917162159.GA14998@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130917162159.GA14998@rei>
Subject: Re: [LTP] [PATCH v3 2/2] device-drivers: block: fixes
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I wonder if it wouldn't be easier to enter the directory and make the
> kernel part Makefile to be noop if there is no kernel-devel package or
> if the kernel version is not new enough.
> 
> Ideally the makefile in the kernel part should look like:
> 
> 
> top_srcdir	?= ../../../..
> 
> include $(top_srcdir)/include/mk/env_pre.mk
> 
> REQ_VERSION_MAJOR       = 3
> REQ_VERSION_PATCH       = 7
> 
> MODULE_NAME = ltp_foo_bar
> 
> include $(top_srcdir)/include/mk/module.mk
> 
> 
> And the rest of the magic should be in the module.mk file.
> 
> Then:
> 
> 1) make in the dir is noop if devel package is missing or
>    version is too old
> 
>    - the parent Makefile has only subdirs defined, no need
>      for additional magic there
> 
> 2) module is build
> 
> 3) if module was build installed

     if module was build, i.e. the .ko file exist install it
     on install, dtto for clean

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
