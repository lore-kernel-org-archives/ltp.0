Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V6J2R-0000L8-L5
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 11:33:23 +0000
Date: Mon, 5 Aug 2013 13:33:19 +0200
From: chrubis@suse.cz
Message-ID: <20130805113319.GA8739@rei>
References: <20130731141915.GA2698@rei.scz.novell.com>
	<1375362489-27214-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130801160456.GA31753@rei.scz.novell.com>
	<51FB6D7F.3080507@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51FB6D7F.3080507@oracle.com>
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
> > What about passing file descriptors to function (-1 means no
> > redirection) and create a second function on the top of it that
> > opens the files, does the checks and the calls the tst_run_cmd?
> 
> So you propose creating two functions: one will accept (const char *) 
> arguments, the other - file descriptors. Yes?

I preffer to look at this as creating one bare function to do the work
(redirect, vfork + exec) and creating the final function on the top of
it.

Good thing about the desing is that we can keep the bare function very
simple.

> But do we really need this functionality in LTP (ie redirect cmd output 
> either to filename or to file descriptor)?

Well, it may be usefull to be able to redirect stdout of a command into
a pipe for example.

> What about modifying tst_run_cmd interface as I propose:
> tst_run_cmd_redirected(void (cleanup_fn)(void),
>                                          char *const argv[],
>                                          const char *stdout_path,
>                                          const char *stderr_path)
> but putting all the related to file descriptors' opening/closing in 
> parent's body.

That works as well.

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
