Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VqLOD-0003FM-Ur
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 11:22:09 +0000
Date: Tue, 10 Dec 2013 12:21:32 +0100
From: chrubis@suse.cz
Message-ID: <20131210112132.GB22396@rei.Home>
References: <20131203124403.GA28667@rei>
	<1386301876-598-1-git-send-email-xu.simon@oracle.com>
	<20131209133520.GA22158@rei.suse.cz> <52A5D4CE.6020207@oracle.com>
	<20131209154445.GA20377@rei.suse.cz> <52A67222.6080203@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A67222.6080203@oracle.com>
Subject: Re: [LTP] [PATCH] Move sctp to utils and bump it to 1.0.15
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
> >>> Pushed, thanks.
> >>>
> >>> I still don't like that it installs binaries that are not clearly to be
> >>> part of the sctp, i.e. test_1_to_1_addrs and so, but this patch is
> >>> obvious improvement over the previous situation.
> >> test_1_to_1_addrs and the other binaries in func_tests are part of
> >> lksctp-tools, see
> >> https://github.com/borkmann/lksctp-tools/blob/master/src/func_tests/
> >> <https://github.com/borkmann/lksctp-tools/blob/master/src/func_tests/test_1_to_1_addrs.c>
> > I know where they came from. But I would like to avoid collisions in the
> > install phase by having resasonably unique name for each file we
> > install. Or by grouping them in directories.
> 
> I see what you mean now.  I think we can prefix them with 'sctp_'.

That would be great.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
