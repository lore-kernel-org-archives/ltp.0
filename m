Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VdK7U-0000iK-HU
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 13:23:04 +0000
Date: Mon, 4 Nov 2013 14:22:42 +0100
From: chrubis@suse.cz
Message-ID: <20131104132241.GA8505@rei>
References: <52721920.8080702@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52721920.8080702@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] acct/acct01.c: Add ELOOP ENAMETOOLONG EROFS
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> Add ELOOP, ENAMETOOLONG, EROFS error number test in acct01.c for acct(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Pushed thanks.

(I had to rebase the patch so that it applies on the top of the
 change Honggyu Kim has done to the testcase.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
