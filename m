From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 May 2016 11:31:04 +0200
Subject: [LTP] [PATCH] syscalls/umount2_{02,
	03}: Retry umount2() on EBUSY
In-Reply-To: <796579473.1980137.1462178144845.JavaMail.zimbra@redhat.com>
References: <20160428163954.GA29437@rei>
 <796579473.1980137.1462178144845.JavaMail.zimbra@redhat.com>
Message-ID: <20160502093104.GA11884@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This should be last fix for umount2() testcases failing with unexpected
> > EBUSY.
> > 
> > This patch adds umount2.h header that defined inline umount2_retry()
> > function that retries umount2() only in case of EBUSY.
> > 
> > The umount2_01 does not need to be fixed since it uses MNT_DETACH that
> > does lazy umount and hence it does not race with background probing.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Is the culprit here also some background daemons? If so, ACK.

Yes, still the same offender gnome gvfs-trash. I will updated the patch
changelog to make this clear.

-- 
Cyril Hrubis
chrubis@suse.cz
