Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQvwv-00028J-Dt
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 09:08:57 +0000
Date: Tue, 1 Oct 2013 11:09:20 +0200
From: chrubis@suse.cz
Message-ID: <20131001090920.GA11945@rei.suse.cz>
References: <1380266492-7199-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130930163452.GB5370@rei.suse.cz> <524A665C.7040202@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <524A665C.7040202@oracle.com>
Subject: Re: [LTP] [PATCH] tools: added tst_kvercmp2 binary
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Well the whole ltpapicmd.c code is a bit hairy. I would personaly like
> > to see the main being split into functions but that may be done in
> > separate patches.
> >
> Ok. Where these function should be placed? In ltpapicmd.c? Or separate
> *.h and *.c file?
> 
> I would prefer ltpapicmd.c

I would just pull them out of the main(), there is no reason to split
it into several files.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
