Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WS61l-0006NT-5B
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 14:39:01 +0000
Date: Mon, 24 Mar 2014 15:38:36 +0100
From: chrubis@suse.cz
Message-ID: <20140324143835.GA6138@rei.suse.cz>
References: <CACwVHNonCpBcvNSwVCt=2Sdm_nOROszqpOF-h+L_9z29EQTsnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACwVHNonCpBcvNSwVCt=2Sdm_nOROszqpOF-h+L_9z29EQTsnw@mail.gmail.com>
Subject: Re: [LTP] About msgsnd05 Test Case Return Value Check
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
To: Sandy Sun <a22017@motorola.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> We found msgsnd05 doesn't check the test result from child thread in parent
> thread, otherwise parent thread will always return 0 even when the result
> of the child thread is failed.

The test is indeed wrong. The tst_resm() called from the child is not
propagated to the parent exit value at all and as it is the parent will
return zero exit status even if the testcase has failed.

Slightly better fix would be to remove all the tst_* interface from the
child and do tst_resm(PASS/FAIL, ...) in the parent (calling cleanup
callback from tst_brkm() in child process would result in unexpected
failures in the parent too).

We usually settle to using fprintf(stderr, ...) in the child to report
details about the failure and propagate failure via the child exit
status.

If you are interested I've wrote a bit of documentation about correct
usage of the LTP tst_* interface:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
