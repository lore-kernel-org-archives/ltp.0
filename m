Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VC5ab-0004fA-LO
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 10:24:33 +0000
Date: Wed, 21 Aug 2013 12:24:37 +0200
From: chrubis@suse.cz
Message-ID: <20130821102436.GA3894@rei>
References: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as
 writers
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Starting with 3.10 dio_sparse sporadically fails, because
> read() in read_sparse returns garbage and dio_sparse testcase
> fails with:
>   dio_sparse    0  TINFO  :  Dirtying free blocks
>   dio_sparse    0  TINFO  :  Starting I/O tests
>   non zero buffer at buf[0] => 0xffffffaa,ffffffaa,ffffffaa,ffffffaa
>   non-zero read at offset 0
>   dio_sparse    0  TINFO  :  Killing childrens(s)
>   dio_sparse    1  TFAIL  :  1 children(s) exited abnormally
> 
> Issue is that we have parent opening file as O_DIRECT and
> children trying to read from it without O_DIRECT, which is
> discouraged in man pages.
> 
> open(2) says:
> "Applications should avoid mixing O_DIRECT and normal I/O to the same
> file, and especially to overlapping byte regions in the same file."
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---

The README in the testcases directory says that the tests explicitly
tests for consistency between buffered I/O and O_DIRECT.

I will consult some kernel guys if this was ever supported and we will
either remove the tests or try to find a bug in the kernel.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
