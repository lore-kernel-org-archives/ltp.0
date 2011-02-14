Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PoziV-000473-AW
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 14:47:55 +0000
Date: Mon, 14 Feb 2011 16:07:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110214150715.GA426@saboteur.suse.cz>
References: <4D3D4644.90607@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D3D4644.90607@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]pthread_attr_t object should be initialized
 before using it
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> pthread_attr_t object should be initialized before using it.

That seems not to be necessary, at least not here. Did you get randomly
looking stacksizes without this patch as a result?

The problem with this testcase is expecting that the thread gets exactly
the stack size that is defined in attr, but posix says that stacksize is
minimal value to be used for that. So the assertion here should be
ssize >= stack_size.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
