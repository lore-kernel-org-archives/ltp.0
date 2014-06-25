Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WzpMW-0000EA-T1
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 15:43:52 +0000
Date: Wed, 25 Jun 2014 17:43:36 +0200
From: chrubis@suse.cz
Message-ID: <20140625154335.GB5552@rei>
References: <1401685455.2838.8.camel@G08JYZSD130126>
	<20140612131041.GB20221@rei>
	<1403179709.11671.0.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403179709.11671.0.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 3/3] can: change the entry
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
> * Change the entry:
> 	can_filter can_run_tests.sh can_filter
> 	can_rcv_own_msgs can_run_tests.sh can_rcv_own_msgs
> 
> * Add can_filter and can_rcv_own_msgs to network/.gitignore
> 
> * Make the test's name more saner:
> 	tst-filter.c --> can_filter.c
> 	tst-rcv-own-msgs.c --> can_rcv_own_msgs.c
> 	run_ltp-can_tests.sh --> can_run_tests.sh
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  runtest/can                                        |   3 +-
>  testcases/network/.gitignore                       |   2 +
>  testcases/network/can/filter-tests/can_filter.c    | 263 +++++++++++++++++++++
>  .../network/can/filter-tests/can_rcv_own_msgs.c    | 255 ++++++++++++++++++++
>  .../network/can/filter-tests/can_run_tests.sh      | 102 ++++++++
>  .../network/can/filter-tests/run_ltp-can_tests.sh  | 102 --------
>  testcases/network/can/filter-tests/tst-filter.c    | 263 ---------------------
>  .../network/can/filter-tests/tst-rcv-own-msgs.c    | 255 --------------------
>  8 files changed, 624 insertions(+), 621 deletions(-)
>  create mode 100644 testcases/network/can/filter-tests/can_filter.c
>  create mode 100644 testcases/network/can/filter-tests/can_rcv_own_msgs.c
>  create mode 100755 testcases/network/can/filter-tests/can_run_tests.sh
>  delete mode 100644 testcases/network/can/filter-tests/run_ltp-can_tests.sh
>  delete mode 100644 testcases/network/can/filter-tests/tst-filter.c
>  delete mode 100644 testcases/network/can/filter-tests/tst-rcv-own-msgs.c

This looks good but I'm missing a Makefile in testcases/network/can so
that the tests are compiled and installed by default.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
