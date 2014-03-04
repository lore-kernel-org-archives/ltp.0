Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WKtQd-0005W0-6n
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 17:46:55 +0000
Date: Tue, 4 Mar 2014 18:46:39 +0100
From: chrubis@suse.cz
Message-ID: <20140304174639.GA9278@rei>
References: <1393391028-9854-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393391028-9854-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fallocate/fallocate02.c: fix compilation error on
 RHEL5.10
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> add #define _GNU_SOURCE in order to have LLONG_MAX defined in RHEL5.10.
> 
> ltp-fallocate.m4: create a configure check for fallocate() syscall and
> define the wrapper only when it's not available.
> 
> fallocate02.c: delete this test item "{&fdw, FNAMEW, DEFAULT_TEST_MODE,
> BLOCKS_WRITTEN-OFFSET, 1, 0}". Fallocate02 is to test various error
> conditions for fallocate() syscall, usually these error conditions
> can be checked in vfs layer. Here this test item, which the expected
> return value is 0, is dependent on whether the underlying file systems
> implement fallocate. So here we choose to remove it, or may specify a
> block device, which contains a ext4 file system.

This is OK. But please split it into two patches, one that fixes
compilation and one that removes the testcase.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
