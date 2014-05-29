Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wpzba-00036k-CA
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 12:38:46 +0000
Date: Thu, 29 May 2014 14:38:29 +0200
From: chrubis@suse.cz
Message-ID: <20140529123829.GB11334@rei.Home>
References: <1399548014.2102.21.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399548014.2102.21.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] setpriority/setpriority01.c: cleanup
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
> * Delete some useless commtents.
> * Move the test body from main() to setpriority_verify().
> * Expand tests([-20,19]).
> * Add tst_require_root for lowering priorities testes.
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
