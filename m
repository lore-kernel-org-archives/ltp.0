Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V70uu-0000pb-Gc
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 10:24:32 +0000
Date: Wed, 7 Aug 2013 12:24:27 +0200
From: chrubis@suse.cz
Message-ID: <20130807102427.GA4389@rei>
References: <51FFBCC1.3030101@oracle.com>
	<1375780313-17327-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130806111545.GC24437@rei> <52021245.1050003@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52021245.1050003@oracle.com>
Subject: Re: [LTP] [PATCH 2/2 V3] lib/tst_module.c: modification for updated
 tst_run_cmd specification
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
> 2) or to change argv in tst_run_cmd function declaration to
> const char *const argv[]

This is what I had in mind. You have to fix the function API first and
then the type of the array that is passed to it.

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
