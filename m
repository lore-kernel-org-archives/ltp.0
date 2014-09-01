Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XOTYA-0007yp-1E
	for ltp-list@lists.sourceforge.net; Mon, 01 Sep 2014 15:29:46 +0000
Date: Mon, 1 Sep 2014 17:29:33 +0200
From: chrubis@suse.cz
Message-ID: <20140901152932.GB27694@rei.suse.cz>
References: <fa6666c6075baadeaaa53f7cf8536ab65daf8b51.1409310860.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa6666c6075baadeaaa53f7cf8536ab65daf8b51.1409310860.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] ustat: check for ENOSYS
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
> ustat(2) says:
>   ustat() is deprecated and has only been provided for compatibility.
>   All new programs should use statfs(2) instead.
> 
> Detect if ustat() is deprecated by checking that errno is ENOSYS,
> and end with TCONF in that case.

Acked.

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
