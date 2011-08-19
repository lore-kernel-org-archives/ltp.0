Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QuR6e-0002SH-Ny
	for ltp-list@lists.sourceforge.net; Fri, 19 Aug 2011 15:35:36 +0000
Date: Fri, 19 Aug 2011 17:40:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110819154015.GA31650@saboteur.suse.cz>
References: <0b369e40d3928086a3e1145e2b3064a863e2bea6.1313379557.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b369e40d3928086a3e1145e2b3064a863e2bea6.1313379557.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] mm/vma01: correct return value if test fails
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> This patch fixes return value always being 0 in parent even if test
> fails. Using exit(value) instead of tst_XXX.

Yes, that is because there is plain exit(0); instead of tst_exit()
(which would return the value that is set by tst_resm()). And actually
the cleanest solution is not to use the tst_XXX interface in the child
at all (as noted in doc/style-guide.txt).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
