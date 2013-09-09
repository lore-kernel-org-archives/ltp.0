Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJ2fq-0004Pu-Rh
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 14:42:42 +0000
Date: Mon, 9 Sep 2013 16:42:54 +0200
From: chrubis@suse.cz
Message-ID: <20130909144251.GC9492@rei>
References: <1378723227-30907-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378723227-30907-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: block: fixes
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Fixed test-cases behavior: major number greater than 255 is valid.
> Added test-cases results (pass/fail).
> run.sh removed and substituted for the user-space program which automatically
> checks each test-case result.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/kernel/device-drivers/Makefile           |    2 +-
>  testcases/kernel/device-drivers/block/Makefile     |   30 ++
>  testcases/kernel/device-drivers/block/README       |   27 ++
>  .../block/block_dev_kernel/.gitignore              |    6 +
>  .../device-drivers/block/block_dev_kernel/Makefile |   40 +++
>  .../block/block_dev_kernel/ltp_block_dev.c         |  336 ++++++++++++++++++++
>  .../block/block_dev_kernel/test_genhd.c            |   53 +++
>  .../device-drivers/block/block_dev_user/.gitignore |    1 +
>  .../device-drivers/block/block_dev_user/Makefile   |   20 ++
>  .../block/block_dev_user/block_dev.c               |  102 ++++++
>  .../device-drivers/block/kernel_space/Makefile     |   24 --
>  .../device-drivers/block/kernel_space/README       |   27 --
>  .../device-drivers/block/kernel_space/run.sh       |   47 ---
>  .../device-drivers/block/kernel_space/test_block.c |  310 ------------------
>  .../device-drivers/block/kernel_space/test_genhd.c |   53 ---
>  15 files changed, 616 insertions(+), 462 deletions(-)
>  create mode 100644 testcases/kernel/device-drivers/block/Makefile
>  create mode 100644 testcases/kernel/device-drivers/block/README
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/.gitignore
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_dev.c
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_kernel/test_genhd.c
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/.gitignore
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/Makefile
>  create mode 100644 testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
>  delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/Makefile
>  delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/README
>  delete mode 100755 testcases/kernel/device-drivers/block/kernel_space/run.sh
>  delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_block.c
>  delete mode 100644 testcases/kernel/device-drivers/block/kernel_space/test_genhd.c

Can you please split the patch into two, one that just moves the files
and second that does actual changes?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
