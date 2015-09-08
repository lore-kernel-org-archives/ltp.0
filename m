Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZHOJ-0007ED-1S
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:48:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZHOH-0003K1-GY
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 11:48:47 +0000
Date: Tue, 8 Sep 2015 13:48:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150908114800.GB3357@rei.suse.cz>
References: <1441386175-23123-1-git-send-email-yuriy.kolerov@synopsys.com>
	<20150907152930.GC26079@rei.suse.cz>
	<3ABF60118B9B784CA5BF7C841D2F00ECA8A38F@de02wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ABF60118B9B784CA5BF7C841D2F00ECA8A38F@de02wembxa.internal.synopsys.com>
Subject: Re: [LTP] [PATCH] Enable including config.mk and features.mk for
 *clean targets
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
To: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Cc: "Anton.Kolesov@synopsys.com" <Anton.Kolesov@synopsys.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Francois.Bedard@synopsys.com" <Francois.Bedard@synopsys.com>

Hi!
> I try to build LTP with POSIX testsuite and run "make clean". As a result "testcases/open_posix_testsuite" is no cleaned properly. It happens because that directory is filtered by "make" here:
> https://github.com/linux-test-project/ltp/blob/master/testcases/Makefile#L33
> 
> And it's filtered because WITH_OPEN_POSIX_TESTSUITE symbol is not defined when you run "make clean". And it's not defined because "config.mk" and "features.mk" are not included for "clean" target:
> https://github.com/linux-test-project/ltp/blob/master/include/mk/env_pre.mk#L98
> 
> So I've decided to include these configuration files for "clean" target too. I've supposed that "clean" target may be invoked even if those files don't exist so I've used error suppression mechanism.

Ah, right, now I understand what this fixes. I will have a look at the
patch.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
