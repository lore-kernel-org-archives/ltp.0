Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur8u7-0003w5-Dl
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:42:07 +0000
Date: Mon, 24 Jun 2013 17:43:33 +0200
From: chrubis@suse.cz
Message-ID: <20130624154333.GB2808@rei>
References: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
	<201306221415.17130.vapier@gentoo.org> <20130624115635.GB1638@rei>
	<201306241136.07004.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201306241136.07004.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tst_module: create new library functions for
 kernel modules
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
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net, vasily.isaenko@oracle.com

Hi!
> > > use a proper header instead.  extern func decls only leads to bit rot and
> > > hard to debug crashes.
> > 
> > This is internal only API for the LTP lib that does not have a proper
> > header (I was too lazy to create a header for the function that is used
> > only once). I can fix that if desired.
> 
> if it's meant as an internal-to-the-lib func, then we should start a
> header to hold that kind of code.  we can easily enforce it too by
> having the lib Makefile define some macro that the header will check
> and error out if it isn't present.

Agreed, I will fix that ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
