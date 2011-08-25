Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwWur-0004vB-7s
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 10:12:05 +0000
Date: Thu, 25 Aug 2011 12:17:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825101715.GC11006@saboteur.suse.cz>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
	<1313434593-7942-6-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313434593-7942-6-git-send-email-lgliang@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH 6/7 ver2 w/attachment] Modified pounder install
 and run scripts
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
To: Lucy Liang <lgliang@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Made changes to two files here, the Install script that builds
> pounder, and the pounder script that runs it. Updated the Install
> script to have it now list the available test schedulers for user
> selectrion prior to starting the build process. Install also now
> includes the functionality for allowing users to skip subtests
> that failed to build rather than just exiting out of the entire
> build process due to a single subtest failure.
> 
> The updated pounder script now includes the -m, -c, -l, -e, -i,
> and -h options (README has more info). The -c, -e, -i options
> handle creation and modification of test schedulers. The -m
> option sets an upper bound on output of repeatedly run subtests.
> The -l option lists subtests packaged with the test scheduler
> and the -h option gives description of pounder usage. Also moved
> all the provided test schedulers into newly created schedulers/
> directory.
> 
> Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
> ---
>  tools/pounder21/Install                         |   63 ++++++--
>  tools/pounder21/default-tests.tar.gz            |  Bin 1441 -> 0 bytes
>  tools/pounder21/fast-tests.tar.gz               |  Bin 1292 -> 0 bytes
>  tools/pounder21/pounder                         |  174 ++++++++++++++++++-----
>  tools/pounder21/schedulers/default-tests.tar.gz |  Bin 0 -> 1663 bytes
>  tools/pounder21/schedulers/fast-tests.tar.gz    |  Bin 0 -> 1494 bytes
>  tools/pounder21/schedulers/test-tests.tar.gz    |  Bin 0 -> 1057 bytes
>  tools/pounder21/test-tests.tar.gz               |  Bin 1006 -> 0 bytes
>  tools/pounder21/testall-tests.tar.gz            |  Bin 314 -> 0 bytes
>  9 files changed, 186 insertions(+), 51 deletions(-)
>  delete mode 100644 tools/pounder21/default-tests.tar.gz
>  delete mode 100644 tools/pounder21/fast-tests.tar.gz
>  create mode 100644 tools/pounder21/schedulers/default-tests.tar.gz
>  create mode 100644 tools/pounder21/schedulers/fast-tests.tar.gz
>  create mode 100644 tools/pounder21/schedulers/test-tests.tar.gz
>  delete mode 100644 tools/pounder21/test-tests.tar.gz
>  delete mode 100644 tools/pounder21/testall-tests.tar.gz

I'm not happy to have tarballs stored in the git for several reasons. Is
this really needed? Shouldn't having directories with files serve the
same purpose?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
