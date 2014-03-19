Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WQGdO-0003UG-Iq
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 13:34:20 +0000
Date: Wed, 19 Mar 2014 14:33:56 +0100
From: chrubis@suse.cz
Message-ID: <20140319133356.GB26802@rei>
References: <20140318193156.GD15827@tarantula.localdomain>
	<1529764.55jJe8A1P6@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1529764.55jJe8A1P6@vapier>
Subject: Re: [LTP] update ffsb autotools files for aarch64
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
> > The autotools files for ffsb -- utils/ffsb-6.0-rc2/config.guess and
> > utils/ffsb-6.0-rc2/config.sub -- do not understand aarch64 and it fails
> > to build:
> 
> we probably should have our build auto-copy the top level config.{sub,guess} 
> files into subdirs when we unpack them sine we know those will be up to date.

Hmm, can't we just symlink them?

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
