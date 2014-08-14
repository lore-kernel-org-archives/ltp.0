Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHtVl-000072-2E
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 11:48:05 +0000
Date: Thu, 14 Aug 2014 13:47:08 +0200
From: chrubis@suse.cz
Message-ID: <20140814114708.GA25631@rei.suse.de>
References: <1408005051-22700-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<2112239769.7076776.1408015701225.JavaMail.zimbra@redhat.com>
	<20140814113446.GA24148@rei.suse.de>
	<1812950696.7079740.1408016386101.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1812950696.7079740.1408016386101.JavaMail.zimbra@redhat.com>
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
> > BTW: I'm finished with the tst_acquire_device() conversion, looking at
> >      the patches at the mailing list I want to get in the containers
> >      cleanup and tst_tmpdir fixes before the pre release freeze and
> >      testing. Is there anything else that should be part of the next
> >      release?
> 
> If you can have a look at:
>   [PATCH] syslog-lib: add SystemLogSocketName to rsyslog.conf
> This one has been bothering me for some time.

Added to the list as well as profil01 rewrite.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
