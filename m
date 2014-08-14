Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHtJn-00083m-C0
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 11:35:43 +0000
Date: Thu, 14 Aug 2014 13:34:46 +0200
From: chrubis@suse.cz
Message-ID: <20140814113446.GA24148@rei.suse.de>
References: <1408005051-22700-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<2112239769.7076776.1408015701225.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2112239769.7076776.1408015701225.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] sparc64 syscall definitions' fixes
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
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> > 1. Changed '__sparc64__' to 'defined(__sparc__) && defined(__arch64__)'
> > 2. Removed non-implemented syscall numbers from sparc64.in (in accordance
> >    to linux-stable/arch/sparc/include/uapi/asm/unistd.h)
> > 2. Re-executed regen.sh
> > 
> > Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> > ---
> > Hi!
> > 
> > I forgot to send it with earlier "SPARC fixes" series.
> > 
> > I will be more than happy, if it gets reviewed before the forthcoming
> > release.
> 
> Appears to match arch/sparc/kernel/systbls_64.S, ACK.

Looks good to me as well. Please push this (as well as oom fixes).

BTW: I'm finished with the tst_acquire_device() conversion, looking at
     the patches at the mailing list I want to get in the containers
     cleanup and tst_tmpdir fixes before the pre release freeze and
     testing. Is there anything else that should be part of the next
     release?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
