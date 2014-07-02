Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2Jnt-00082l-LP
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 12:38:25 +0000
Date: Wed, 2 Jul 2014 14:38:00 +0200
From: chrubis@suse.cz
Message-ID: <20140702123800.GA2469@rei.scz.novell.com>
References: <1404113603-19192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140701135509.GA25542@rei.scz.novell.com>
	<53B3D2E2.8030406@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B3D2E2.8030406@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syscalls: fix testcases which take TCONF as TFAIL
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
> >> +	} else {
> >> +		tst_brkm(TBROK, cleanup, "child process terminated "
> >> +				 "abnormally. status: %d", status);
> >> +	}
> > 
> > The child code uses exit(1) directly, which coincidentally maps to the
> > TFAIL but we should be consistent and better use 1 here or TFAIL in the
> > child code.
> > 
> > Also this would be better written as a switch statement
> > 
> > 	switch (ret) {
> > 	case TPASS:
> > 		...
> > 	break;
> > 	case TCONF:
> > 		...
> > 	break;
> > 	default:
> > 		tst_resm(TFAIL, "...");
> > 	}
> 
> OK. And I'd like to introduce two new function tst_reset_exitval() and tst_record_childstatus().
> Here are some explanations:
> Some test cases need do real test work in child process and parent process deal with the test results.
> Usually it is not recommended to use tst_* interfaces in child process, because child process's test
> results are not propagated to parent process correctly. But if child process call tst_exit() to report
> the test results, I think it is OK.
> 
> And the big problem prohibits us to call tst_brkm(cleanup, ...) in child process is that child
> and parent process share the directory created by tst_tmpdir(). Though child and parent process
> share many other kernel resources, but mostly they are based on kernel COW mechanism. So if we can
> remove the tst_rmdir() operation in cleanup() or put it elsewhere, I think we are free to call
> tst_brkm(cleanup,..) interface, thanks.

You can fix that by having a separate cleanup for the child and for the
parent. The child should only clean up what has been allocated there
anyway.

One problem that is still there is that the printing to stdout is not
synchronized between the parent and the child and because the output is
block buffered (in case the output is captured to a file) the messages
will be printed in wrong order or even intermixed up badly. This is only
problem in a case that both parent and child does something that may
produce output, but we have such testcases.

One solution for this is flushing the output after each test message,
but this has been deemed too obtrusive because this will slown down I/O
and may possibly affect the test results.

I will have a look at the test library and try to figure out if there
are any more possible problems; I do not remeber more at the moment.

While I agree that creating a function to propagate a return value from
a child is a good idea, I don't like the tst_reset_exitval() function. I
guess that since we have tst_fork() (which is needed to flush the output
stream anyway) we can add the code to reset the exitval there or even
let the library handle the forking(), because that code repeats over and
over...

Or gave up on printing the messages in the child and return just the
exit status from the function executed by child like below.

int child_function(void)
{
	....

	if (test_failed)
		return TFAIL;

	return TPASS;
}


/*
 * Here the function would do tst_fork(), executes the child_function
 * and exits with return value from the child function.
 *
 * The parent meanwhile waits for the child to exit a reports the
 * status.
 */
tst_resm_chld(child_function, "Child passed message",
              "Child failed message");

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
