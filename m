Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ywo7Q-0003jO-9r
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2015 08:52:20 +0000
Date: Mon, 25 May 2015 10:51:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150525085128.GA2586@rei.suse.de>
References: <1432541376-15153-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432541376-15153-1-git-send-email-stanislav.kholmanskikh@oracle.com>
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
> As of now, if we run test cases which use the tst_checkpoint framework on NFS,
> they will fail with errors like:
> 
> creat07     0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed: remove(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed; errno=66: Directory not empty
> 
> This happens because we keep the futex page mapped while tst_rmdir() is running.
> 
> So on we need to unmap the page before tst_rmdir().
> 
> What do you think about the proposed solution?

Why don't we hide this from user and unmap() the file in the tst_rmdir()
if checkpoint was initialized?

Otherwise I'm all for this fix.

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
