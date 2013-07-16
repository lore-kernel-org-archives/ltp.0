Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uz5DG-00017B-0f
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 13:22:42 +0000
Date: Tue, 16 Jul 2013 15:24:25 +0200
From: chrubis@suse.cz
Message-ID: <20130716132425.GA21306@rei>
References: <1373966367-18078-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130716114347.GB20826@rei> <51E540CC.3070406@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51E540CC.3070406@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V2 1/2] lib: let tst_kvercmp2() contains major
 kernel version
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> Assume that we want version ">=2.6.25", but only ">2.6.18-131", contain
> them together will make no sense.  I suppose only use tst_kvercmp2()
> "<0" and ">0", no use "=0", just remain return value "0" to indicate
> that the extra kernel vendor is not match with current kernel.
> What do you think?

Given that the kernel versions increase monotonically one can always
change that to:

> 2.6.24 && > 2.6.18-131

or (what I did in the example)

>= 2.6.25 && >= 2.6.18-132

Or am I missing something?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
