Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4vNA-0002k5-2W
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 16:05:04 +0000
Date: Thu, 1 Aug 2013 18:04:56 +0200
From: chrubis@suse.cz
Message-ID: <20130801160456.GA31753@rei.scz.novell.com>
References: <20130731141915.GA2698@rei.scz.novell.com>
	<1375362489-27214-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1375362489-27214-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 1/2 V2] tst_run_cmd: added support for stdout and
 stderr redirection
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> -	if (!pid)
> +	if (!pid) {
> +		/* redirecting stdout and stderr if needed */
> +		if (stdout_path != NULL) {
> +			child_stdout = open(stdout_path,
> +					OPEN_FLAGS, OPEN_MODE);
> +
> +			if (child_stdout == -1) {
> +				tst_resm(TWARN | TERRNO,
> +					"open() on %s failed at %s:%d: %s",
> +					stdout_path, __FILE__, __LINE__,
> +					strerror(errno));

You should not call the tst_resm() here for two reasons.

1. It is not designed to be called from a child of the main test process

2. It still may corrupt the parent memory although in this case it's
   not that likely (as it operates on FILE* used for the test output,
   note that ANY operation on FILE* may get it into inconsistent state
   in the parent later)

What about passing file descriptors to function (-1 means no
redirection) and create a second function on the top of it that
opens the files, does the checks and the calls the tst_run_cmd?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
