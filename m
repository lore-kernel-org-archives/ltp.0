Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X9akq-000763-Qh
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 14:09:20 +0000
Date: Tue, 22 Jul 2014 16:08:38 +0200
From: chrubis@suse.cz
Message-ID: <20140722140838.GA11469@rei>
References: <1401685455.2838.8.camel@G08JYZSD130126>
	<20140612131041.GB20221@rei>
	<1403179593.7741.2.camel@G08JYZSD130126>
	<20140625153950.GA5552@rei>
	<1403866408.2119.28.camel@G08JYZSD130126>
	<20140715143901.GA8247@rei>
	<1405932572.5156.7.camel@G08JYZSD130126>
	<1405934632.5156.13.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1405934632.5156.13.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v4 3/3] Make can testes' name more saner
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> * Add can to scenario_groups/default.
> 
> * Add can_filter and can_rcv_own_msgs to network/.gitignore.
> 
> * Make the test's name more saner:
> 	tst-filter.c --> can_filter.c
> 	tst-rcv-own-msgs.c --> can_rcv_own_msgs.c
> 	run_ltp-can_tests.sh --> can_run_tests.sh

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
