Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWMYs-0006PD-RY
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 09:39:06 +0000
Date: Tue, 23 Sep 2014 11:38:49 +0200
From: chrubis@suse.cz
Message-ID: <20140923093848.GA27355@rei.suse.cz>
References: <20140922154742.71edd101@mats-desktop>
	<20140922142631.GA12628@rei.suse.cz>
	<5421375C.3040706@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5421375C.3040706@cn.fujitsu.com>
Subject: Re: [LTP] Failed out of tree compile
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
>     How about removing utils/ffsb-6.0-rc2 from LTP? Currently it seems that only 'ext4-new-features'
> test suite use this tool, and 'utils/ffsb-6.0-rc2' maybe old, if user wants to run 'ext4-new-features',
> he should install ffsb himself for his linux distribution or from upstream code. Meanwhile I noticed that
> there were several reports about ffsb installing issues in the past, include this time, so removing this
> may reduce complexity :)

I think I've fixed for now (just pushed the fix). Let's see if that
works or not and if it breaks again I would vote for removing it.

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
