Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfsGo-0005zw-6G
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 14:15:14 +0000
Date: Mon, 11 Nov 2013 15:15:03 +0100
From: chrubis@suse.cz
Message-ID: <20131111141503.GE12164@rei>
References: <1383704723-577-1-git-send-email-xu.simon@oracle.com>
	<1383715718-507-1-git-send-email-xu.simon@oracle.com>
	<20131107162501.GD9653@rei.Home> <527C45FD.3090008@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527C45FD.3090008@oracle.com>
Subject: Re: [LTP] [PATCH V2] rpc01: fix $TCbin and $TCtmp and data file
	names
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
> >> The values of TCbin and TCtmp should be swapped, and `rpc1' is in TCbin,
> >> not TCtmp.  Also correct the file names 'file.1' and 'file.2' which do not
> >> exist.
> >>
> >> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> >> ---
> >>   testcases/network/rpc/basic_tests/rpc01/rpc01 | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
> >> index ef97a95..8594835 100755
> >> --- a/testcases/network/rpc/basic_tests/rpc01/rpc01
> >> +++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
> >> @@ -36,13 +36,13 @@
> >>   $trace_logic
> >>   this_file=${0##*/}
> >>   TC=${TC:=rpc01}
> >> -TCbin=${TCbin:=`pwd`}
> >> +TCbin=${TCbin:=$LTPROOT/testcases/bin}
> >>   TCdat=${TCdat:=$TCbin/datafiles}
> >> -TCtmp=${TCtmp:=$LTPROOT/testcases/bin}
> >> +TCtmp=${TCtmp:=`pwd`}
> >>   NUMLOOPS=${NUMLOOPS:=3}
> >>   RHOST=${RHOST:=`hostname`}
> >>   CLEANUP=${CLEANUP:="ON"}
> >> -DATAFILES=${DATAFILES:="file.1 file.2"}
> >> +DATAFILES=${DATAFILES:="bin.med bin.sm"}
> >>   
> >>   #=============================================================================
> >>   # FUNCTION NAME:        do_test
> >> @@ -68,7 +68,7 @@ do_test()
> >>       do
> >>         for FILE in $DATAFILES
> >>         do
> >> -	$TCtmp/rpc1 -s $RHOST -f $TCdat/$FILE
> >> +	$TCbin/rpc1 -s $RHOST -f $TCdat/$FILE
> > The runltp script adds $LTPROOT/testcases/bin to path so you should
> > reduce this only to rpc1 and it should work.
> >
> > The runltp script also sets $TMPDIR as temporary directory.
> 
> Yes this fix is only for rpc01.  And it seems that rpc01 is not designed 
> for runltp script, but for networktests.sh, which uses TCtmp and TCbin.

The test rpc01 is listed in runtest/rpc and runtest/stress.part3 files, i.e. it
is possible to execute these tests by runltp script.

Moreover all the tests in LTP should follow the same arangement of temp
directory, test binaries directory, etc.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
