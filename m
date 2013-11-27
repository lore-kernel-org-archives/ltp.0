Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vldcq-0000Id-Lj
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 11:49:48 +0000
Date: Wed, 27 Nov 2013 12:49:18 +0100
From: chrubis@suse.cz
Message-ID: <20131127114918.GA7549@rei.suse.cz>
References: <20131111141503.GE12164@rei>
	<1384841690-716-1-git-send-email-xu.simon@oracle.com>
	<20131126144959.GB13652@rei> <52955FA1.7020909@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52955FA1.7020909@oracle.com>
Subject: Re: [LTP] [PATCH V4] rpc01: fix paths and add Makefile for datafiles
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> testcases/bin/datafiles is used by several tests
> 
> ~/devel/ltp/testcases/network > grep -r datafiles *
> Makefile:DIR                    := datafiles
> nfs/nfslock01/nfslock01:#           datafiles are compared.
> nfs/nfs02/nfs02:TCdat=${TCdat:=$TCbin/datafiles}
> rpc/basic_tests/rpc01/rpc01:TCdat=${TCdat:=$TCbin/datafiles}
> tcp_cmds/ftp/ftp01:    TCdat=${TCdat:-$LTPROOT/datafiles}
> tcp_cmds/Makefile:INSTALL_DEPS          := ../datafiles/bin.sm
> tcp_cmds/Makefile:../datafiles/bin.sm:
> tcp_cmds/rcp/rcp01: TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
> tcp_cmds/Makefile.inc:#    network/tcp_cmds datafiles dependent include 
> Makefile.
> tcp_cmds/Makefile.inc:MAKE_DEPS         := 
> $(GENERATE_FILE_DIR)/datafiles/bin.sm
> tcp_cmds/rdist/rdist01: TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
> tcp_cmds/sendfile/sendfile01: 
> TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}

Ah, I guess there are at least two more places where tests install their
data files. I've looked around and found a few in testcases/bin/ :(

> I think we better change all of them or do nothing.

Right. I want to have one single place to store test datafiles and
ideally to be easy to figure out which files belogs to which testcases.
Once this is defined we can fix all the testcases as well.

What about this:

1. Testcases datafiles are stored in a TESTNAME_data directory
   where TESTNAME is name of the test or a group of test (if
   the files are used by more than one test)

2. The whole directory gets installed somewhere in the
   /opt/ltp/testcases/, be it testcases/bin/datafiles or
   testcases/datafiles.

What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
