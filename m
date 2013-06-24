Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur5MS-0007cm-V9
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 11:55:08 +0000
Date: Mon, 24 Jun 2013 13:56:35 +0200
From: chrubis@suse.cz
Message-ID: <20130624115635.GB1638@rei>
References: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
	<201306221415.17130.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201306221415.17130.vapier@gentoo.org>
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
> > +/* declared in tst_tmpdir.c */
> > +const char *tst_get_startwd(void);
> 
> use a proper header instead.  extern func decls only leads to bit rot and hard 
> to debug crashes.

This is internal only API for the LTP lib that does not have a proper
header (I was too lazy to create a header for the function that is used
only once). I can fix that if desired.

> use fork()+execvp() instead.  there's no need to normalize to a string and 
> then run through a shell.
> 
> wonder if we should add a util func for this ...

That sounds like good idea.

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
