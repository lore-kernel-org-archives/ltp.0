Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XikoF-0005VD-Gk
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 13:58:11 +0000
Date: Mon, 27 Oct 2014 14:57:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141027135740.GA11481@rei.suse.de>
References: <1413872345.17741.7.camel@G08JYZSD130126.localdomain>
	<1413872520.17741.10.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1413872520.17741.10.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v3 4/4] multicast/mc_opts: Some cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> * Rename 'opts.c' to 'mc_verify_opts.c' and some cleanup.
> * Rename 'opts_e.c' to 'mc_verify_opts_error.c' and some cleanup.

Patchset pushed, thanks.

PS: Please split patches into part that renames files and into
    part that changes the code next time. I had to diff the
    old version and new one manually to see what has been changed
    in them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
