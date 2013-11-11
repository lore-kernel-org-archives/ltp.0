Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfsAN-0000aA-I6
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 14:08:35 +0000
Date: Mon, 11 Nov 2013 15:08:24 +0100
From: chrubis@suse.cz
Message-ID: <20131111140824.GD12164@rei>
References: <1383556829-1464-1-git-send-email-xu.simon@oracle.com>
	<20131107160750.GA9653@rei.Home> <527C5B3D.60205@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527C5B3D.60205@oracle.com>
Subject: Re: [LTP] [PATCH] networktests.sh: add ${LTPROOT}/bin into $PATH
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
> >> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> >> ---
> >>   testscripts/networktests.sh | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
> >> index b136749..9465356 100755
> >> --- a/testscripts/networktests.sh
> >> +++ b/testscripts/networktests.sh
> >> @@ -110,7 +110,7 @@ fi
> >>   
> >>   cd $TMPDIR
> >>   
> >> -export PATH="${PATH}:${LTPROOT}/testcases/bin"
> >> +export PATH="${PATH}:${LTPROOT}/bin:${LTPROOT}/testcases/bin"
> > You can remove the original export that adds ${LTPROOT}/testcases/bin as
> > this path is allready added by runltp script.
> 
> We need to make sure that it's in PATH when using networktests.sh.

Ah this is a script that is executed manually (not from runtest files)
then the path to ${LTPROOT}/testcases/bin is OK.

> > And I think that better solution would be to install genhost into the
> > testcases/bin (as the rest of the binaries used from the tests such as
> > tst_resm).
> 
> gethost.c is in ltp/tools and everything in the dir is installed to 
> ltp/bin.  I think we should keep this in case some other tests need 
> ltp/bin/gethost.

I was grepping for gethost in the LTP sources and it looks like there is
only one testcase sendfile01 that uses this binary. So moving it to
testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c looks like a
best solution to me. It will get installed along the test binaries,
etc...

The tools directory is directory for tools used to run the tests, i.e.
ltp-pan.

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
