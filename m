Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmirG-0005Mb-26
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 12:09:26 +0000
Date: Tue, 20 May 2014 14:09:13 +0200
From: chrubis@suse.cz
Message-ID: <20140520120913.GA28216@rei.suse.cz>
References: <1400580620-15769-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400580620-15769-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib: safe_stdio.c,
 tst_virt.c: delete the redundant code
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Since tst_brkm() can break remaining test cases, the code
> after this function is redundant.

Good catch, pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
