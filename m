Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkC54-0008Bd-5h
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 12:45:14 +0000
Date: Tue, 13 May 2014 14:44:12 +0200
From: chrubis@suse.cz
Message-ID: <20140513124411.GA20155@rei>
References: <1399978979-20072-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399978979-20072-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] lib/tst_sig.c: output signal name when got
 unexpected signal
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When testcase is killed by unexpected signal, usually it just prints
> signal's value.
> 	fcntl30     1  TBROK  :  unexpected signal 2 received (pid = 6714).
> 	fcntl30     2  TBROK  :  Remaining cases broken
> 
> Here we also print signal's name to output more informative message.
> 	fcntl30     1  TBROK  :  unexpected signal SIGINT(2) received (pid = 9872).
> 	fcntl30     2  TBROK  :  Remaining cases broken
> 
> In this patch, we also add two new tst_ functions to convert errno or signal
> to its name. The prototype is below:
>     const char *tst_strsig(int sig);   returns signal name given signal number
>     const char *tst_strerrno(int err); returns errno name given errno number

I've added two simple tests to lib/tests/ and pushed, thanks.

Will you send a patch to add these two to Test Writing Guidelines?

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
