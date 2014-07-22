Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X9b5V-0008T0-E4
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 14:30:41 +0000
Date: Tue, 22 Jul 2014 16:30:00 +0200
From: chrubis@suse.cz
Message-ID: <20140722143000.GA22955@rei>
References: <1405230591-19166-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140715142426.GB28667@rei> <53CCA4B9.2070005@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53CCA4B9.2070005@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib/tst_res.c: introduce
 tst_record_childstatus()
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
> >> In case we need do real test work in child porcess, it is OK for child process
> >> to use tst_resm(), tst_brkm() or tst_exit(). Parent process can use
> >> tst_record_childstatus() to make child process's test results propagated to parent
> >> process correctly.
> >>
> >> Meanwhile we reset T_exitval to 0 for child process in tst_fork(), which will
> >> make child process can record test results with tst_resm() or tst_brkm() correctly.
> > 
> > Looks technically correct to me. The only caveat is that you have to
> > decide to use either tst_* interface in child or plain exit() and do not
> > to mix them.
> Yeah, Or I should write some notes about using tst_* interfaces in child process in Test Writing Guidelines.
> And sorry for the delay, I was busy last week.

Yes, this patch would need more changes into the Test Writing Guidelines
anyway...

> > Also as the code si now we don't have to reset the T_exitval because
> > what we do now is or the flags form child to add them to the paren't
> > flags (which will be set anyway if the child has started with nonzero
> > flags).
> 
> Ah, you are right.
> But I think reseting T_exitval is necessary, at least we should give child process
> a clean test environment...
> Assume a simple case:
>   Parent already has TFAIL set, then it fork() a child to have some
> other test work and everything is OK in child, child only calls tst_resm(TPASS,...),
> then in child, T_exitval will have TPASS and TFAIL set. Finally, child calls
> tst_exit() to report the test results, in this case, child will return a 
> non-zero value, it seems child exits abnormally, though it does not affect the final
> test results, it is still not reasonable, obviously 0 value is reasonable for child, 
> after all child does not do any wrong.

Yes, it's better to reset it but it's not really necessary.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
