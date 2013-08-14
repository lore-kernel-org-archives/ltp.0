Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V9XgA-0003ei-Vs
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 09:47:47 +0000
Date: Wed, 14 Aug 2013 11:47:49 +0200
From: chrubis@suse.cz
Message-ID: <20130814094749.GB9158@rei>
References: <1366181425.S.90345.autosave.drafts.old.1376464126.7788@webmail.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1366181425.S.90345.autosave.drafts.old.1376464126.7788@webmail.rediffmail.com>
Subject: Re: [LTP] More runtime memory consuming LTP test cases
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
To: devaraja b v <sunildev_63@rediffmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I am using LTP for testing my embedded device with 2 GB of total memory.I need to exclude few of the test cases in the default run.Could you please let me know which are all the test cases are more memory eater?I could not find this information in LTP wiki and Google search as well.And also what would be the minimum free memory required to run LTP on the deviceThanks much in advance.

Sorry I'm not avare of any list of memory intensive testcases but having
2GB of RAM is more than enough for all testcases. There may be problems
with:

* /tmp on tmpfs and I/O stress testcases that create large files

* oom testcases that checks if the kernel can handle low memory

* absence of swap

Did you find specific testcase(s) that brings down your device?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
