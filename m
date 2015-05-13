Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YsRpK-0000Nq-2c
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 08:15:38 +0000
Date: Wed, 13 May 2015 10:14:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150513081458.GA3409@rei.suse.de>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
	<5551F71E.7090400@huawei.com> <20150512134858.GA11906@rei.suse.de>
	<55530639.2070806@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55530639.2070806@huawei.com>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhuyanpeng@huawei.com, zhanyongming@huawei.com

Hi!
> >> then compile error:
> >> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/home/cuibixuan/home/git/ltp/ltp/testcases/kernel/include -I../../../../include -I../../../../include   -L../../../../lib  open12.c   -lltp -o open12
> >> open12.c: In function ?setup?:
> >> open12.c:103: error: ?MS_STRICTATIME? undeclared (first use in this function)
> >> open12.c:103: error: (Each undeclared identifier is reported only once
> >> open12.c:103: error: for each function it appears in.)
> >> make[4]: *** [open12] Error 1
> 
> Compile error 'MS_STRICTATIME undeclared' because my glibc version(2.11) is
> too old. I upgrade it then compile succeed.

That is not a solution. The solution is to create a fallback declaration
in LTP as I said.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
