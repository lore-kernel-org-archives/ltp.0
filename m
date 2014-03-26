Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSpQ6-0007Ws-Gf
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 15:07:10 +0000
Date: Wed, 26 Mar 2014 16:06:39 +0100
From: chrubis@suse.cz
Message-ID: <20140326150639.GB10878@rei.suse.cz>
References: <20140310125058.GA10346@rei>
	<1395516807-27706-1-git-send-email-gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395516807-27706-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: Re: [LTP] [PATCH] build: fix out-of-tree build
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -$(FFSB): $(FFSBDIR)
> -	cd $^; ./configure
> -	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
> -	cp $(FFSBDIR)/ffsb ffsb
> +unexport MAKEFLAGS
> +
> +$(FFSB): $(abs_srcdir)/$(FFSBDIR)
> +	mkdir -p $(FFSBDIR)
> +	cd $(FFSBDIR) && "$^/configure" && $(MAKE) all

The GNU Make manual suggests to use $(MAKE) all MAKEFLAGS= instead of
the unexport, the rest looks ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
