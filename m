Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XMEQF-00033i-NH
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 10:56:19 +0000
Date: Tue, 26 Aug 2014 12:55:16 +0200
From: chrubis@suse.cz
Message-ID: <20140826105516.GA28025@rei>
References: <0be2f82a131d32b119748e91a840cb038bf82960.1409046964.git.jstancek@redhat.com>
	<20140826100642.GA27928@rei>
	<1144259951.13045166.1409048187591.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1144259951.13045166.1409048187591.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] tst_ncpus_max: use kernel_max if available
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> These two are still open / under discussion:
>   [PATCH] sbrk02: check for ret code in setup()
>   [PATCH] mmap15: don't fail if mmap returns EINVAL
> 
> mmap15 looks like old issue, so it could wait after release.

Agreed.

> sbrk02 can loop indefinitely in setup(), which is worse IMO.

Ok.

So the issue there is that sbrk() does not fail in setup() because
the increment overflows.

Does it work if we stop increasing the increment before that happen? Or
does sbrk() fails to fail there?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
