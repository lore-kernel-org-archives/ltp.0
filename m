Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wb5LD-0002Gp-T3
	for ltp-list@lists.sourceforge.net; Fri, 18 Apr 2014 09:44:15 +0000
Date: Fri, 18 Apr 2014 11:43:28 +0200
From: chrubis@suse.cz
Message-ID: <20140418094328.GA11147@rei>
References: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
	<3992309.8rLpXb3keE@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3992309.8rLpXb3keE@vapier>
Subject: Re: [LTP] [PATCH] configure: add configure check for GCC
 -Wold-style-definition
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> On Fri 11 Apr 2014 13:26:59 Alexey Kodanev wrote:
> > +backup_cflags="$CFLAGS"
> > +CFLAGS="-Wold-style-definition"
> 
> this isn't really safe.  the CFLAGS might have critical settings in there that 
> impact linking.  why not just append ?

We can also change the AC_LINK_IFELSE() to AC_COMPILE_IFELSE().

Given this is not critical (the worst case is that old style warnings
are not enabled) this could wait after the release.

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
