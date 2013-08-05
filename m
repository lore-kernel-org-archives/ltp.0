Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V6KCs-0002WU-Ee
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 12:48:14 +0000
Date: Mon, 5 Aug 2013 14:48:00 +0200
From: chrubis@suse.cz
Message-ID: <20130805124800.GD8739@rei>
References: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
	<1374230659-21101-2-git-send-email-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374230659-21101-2-git-send-email-anders.roxell@linaro.org>
Subject: Re: [LTP] [PATCH] realtime-testsuite: update the install rule
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
To: Anders Roxell <anders.roxell@linaro.org>
Cc: ltp-list@lists.sourceforge.net, patches@linaro.org

Hi!
> func/*/Makefile: added INSTALL_TARGETS
> func/*/run.sh -> func/*/run_auto.sh to autorun those tests when running
>     the test_realtime.sh script.
> run.sh scripts/run_c_files.sh: if installed no need to rebuild tests
> testscritps/test_realtime.sh: remove java from the "all" target and
>     do not rebuild lib if running from installed path
> 
> New files, needed to run the realtime-testsuite from a installed path
> profiles/Makefile and scripts/Makefile

Generally it looks good.

Could you please split the changes into several smaller patches (one
patch per fix) and write a bit more verbose descriptions?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
