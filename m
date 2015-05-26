Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxAQ9-0007Wg-3f
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 08:41:09 +0000
Date: Tue, 26 May 2015 10:40:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150526084019.GA2940@rei.suse.de>
References: <1432541376-15153-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150525085128.GA2586@rei.suse.de> <55642D9D.6050707@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55642D9D.6050707@oracle.com>
Subject: Re: [LTP] [RFC PATCH] tst_checkpoint_destroy
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
> Ok, we can do it this way.
> 
> One question regarding the typedef of futex_t. As of now the futex_t 
> type is defined in two places:
>   * testcases/kernel/syscalls/futex/futextest.h
>   * lib/tst_checkpoint.h
> 
> If I put unmap() in tst_rmdir(), I will add futex_t to tst_tmpdir.c 
> either, so it will be the third occurrence.
> 
> It seems it would be good to move the typedef of futex_t into a common 
> header.
> 
> I'm unsure which one to use :) Or just create include/lapi/futex.h?

Header in lapi sounds good, I should have probably done so when I was
rewriting the checkpoint interface.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
