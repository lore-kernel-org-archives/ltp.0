Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MBWD1-00029U-1b
	for ltp-list@lists.sourceforge.net; Tue, 02 Jun 2009 15:47:27 +0000
Date: Tue, 2 Jun 2009 17:47:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090602154713.GA14907@schrodinger.suse.cz>
References: <20090601193622.GA690@schrodinger.suse.cz>
	<20090602.074642.226786039.caiqian@cclom.cn>
	<20090602001451.GA19251@schrodinger.suse.cz>
	<20090602.105034.226785759.caiqian@cclom.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090602.105034.226785759.caiqian@cclom.cn>
Subject: Re: [LTP] [chrubis@suse.cz: Re: [PATCH] fix missing return
	in	several files.]
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

> > I'm passing NULL to tst_brkm, so we should never enter this code.  But
> > tst_brkm() calls tst_exit() in some circumstances so we should either add
> > __atribute__ ((noreturn)) to tst_brkm too or remove tst_exit() from it.
> > 
> 
> OK. How about we do,
> 
>     	tst_resm(TCONF, "libaio missing");
> 	tst_exit();
> 
> instead of,
> 
> 	tst_brkm(TCONF, NULL, "libaio missing");
> 	tst_exit();
> 
> since I can't see the reason to use tst_brkm() in this case?

Sounds reasonable for this case, but I still think we should rethink which
tst_* functions calls exit() or tst_exit() and if they needs __attribute__
((noreturn)).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
