Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vgw87-0000YP-Sq
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 12:34:39 +0000
Date: Thu, 14 Nov 2013 13:34:25 +0100
From: chrubis@suse.cz
Message-ID: <20131114123425.GC13348@rei>
References: <5283773E.5080505@cn.fujitsu.com>
 <20131113160220.GA28712@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131113160220.GA28712@rei>
Subject: Re: [LTP] [PATCH] fs/ext4-new-features: add ext4-new-features tests
 to the default
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
> >  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> > diff --git a/testcases/kernel/fs/ext4-new-features/Makefile b/testcases/kernel/fs/ext4-new-features/Makefile
> > index 208b8a6..1ad1c3c 100644
> > --- a/testcases/kernel/fs/ext4-new-features/Makefile
> > +++ b/testcases/kernel/fs/ext4-new-features/Makefile
> > @@ -32,6 +32,7 @@ FILTER_OUT_DIRS		:= $(FFSBDIR)
> >  FFSB			:= $(FFSBDIR)/ffsb
> >  
> >  $(FFSB): $(FFSBDIR)
> > +	cd $^; ./configure
> >  	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
> >  	cp $(FFSBDIR)/ffsb ffsb
> 
> The way how ffsb is bundled in LTP is simply wrong, it shouldn't be in
> the source tree at all. What I would like to see is to:
> 
> 1. modify testcases that depends on it to return TCONF with
>    message that explains that ffsb must be installed to run
>    the testcases if ffsb is not found in PATH
> 
>    or alternatively use something different to create the
>    I/O load
> 
> 2. remove ffsb from the LTP git tree

Or at least the source tree should be moved to a proper place, there is
utils/benchmar/ directory for this purpose allready.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
