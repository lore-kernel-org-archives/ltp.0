Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZktE-0004gC-Vq
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 17:41:53 +0000
Date: Mon, 14 Apr 2014 19:41:05 +0200
From: chrubis@suse.cz
Message-ID: <20140414174105.GA26543@rei>
References: <20140414192212.3c97cc76@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140414192212.3c97cc76@mats-desktop>
Subject: Re: [LTP] Problems with cross-compiling
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I've been using Yocto, which does cross-compiling. It has support for
> compiling LTP, but I've noticed it has a couple of patches. I found
> that one patch was needed for actually compile LTP, which applies to
> the file utils/Makefile.
> 
> The patch is for an older version of LTP, but I re-implemented it for
> the new version. Looking at the following rule:
> 
> $(FFSB): $(abs_srcdir)/$(FFSBDIR)
>         mkdir -p $(FFSBDIR)
>         cd $(FFSBDIR) && "$^/configure" && $(MAKE) top_srcdir="$^" all
> 
> This calls configure without parameters, which is most likely wrong for
> a cross-compile environment. It is this configure that fails. By simple
> removing it, everything works within Yocto.
> 
> Is there any reason for keeping this configure here? Or should I make
> a patch for removing it?

The ffsb configure should be called from the top-level configure the
same way it's done for the realtime directory.

Does following work for cross-compilation?

1. Remove the configure from the Makefile
2. Add AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2]) into the configure.ac
3. Regenerate top level configure by make autotools
4. ./configure && make

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
