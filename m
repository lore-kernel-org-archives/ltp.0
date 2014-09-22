Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XW3Cj-0005hc-14
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 12:58:57 +0000
Date: Mon, 22 Sep 2014 14:58:39 +0200
From: chrubis@suse.cz
Message-ID: <20140922125839.GA11314@rei.suse.cz>
References: <1411009276-1720-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1411009276-1720-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runtest/containers: fix errors in
 netns_par_chld_ftp testcase that takes TCONF as TFAIL
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
> In test case 'testcases/kernel/containers/netns/netns_par_chld_ftp.sh', if iproute tools
> do not support setting network namespaces, child process will return TCONF, but parent
> process took this as TFAIL wrongly.
> 
> So in testcases/lib/test.sh, we introduce tst_record_childstatus()'s shell version, please
> see doc/test-writing-guidelines.txt for detailed information this function, it helps to
> propagate child process result(child exit status) to the parent process correctly.
> 
> In this patch, we fix this issue by using this function.

Nice fix ;).

Pushed with cosmetic change (I've changed the tst_resm TWARN to tst_brkm
TBROK so that the execution of the test is halted if something went
wrong), thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
