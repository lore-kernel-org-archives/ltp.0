Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wkvf0-0005bq-FB
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 13:25:22 +0000
Date: Thu, 15 May 2014 15:25:10 +0200
From: chrubis@suse.cz
Message-ID: <20140515132510.GA29670@rei.Home>
References: <1397208419-27737-1-git-send-email-alexey.kodanev@oracle.com>
	<3992309.8rLpXb3keE@vapier> <20140418094328.GA11147@rei>
	<20140423154353.GA16286@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140423154353.GA16286@rei.suse.cz>
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
> > > On Fri 11 Apr 2014 13:26:59 Alexey Kodanev wrote:
> > > > +backup_cflags="$CFLAGS"
> > > > +CFLAGS="-Wold-style-definition"
> > > 
> > > this isn't really safe.  the CFLAGS might have critical settings in there that 
> > > impact linking.  why not just append ?
> > 
> > We can also change the AC_LINK_IFELSE() to AC_COMPILE_IFELSE().
> > 
> > Given this is not critical (the worst case is that old style warnings
> > are not enabled) this could wait after the release.
> 
> The freeze has been lifted up, feel free to push fix if you want :)

I've just pushed a fix that appends the CFLAGS instead of replacing
them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
