Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XYcl9-0004a4-PL
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 15:21:07 +0000
Date: Mon, 29 Sep 2014 17:20:41 +0200
From: chrubis@suse.cz
Message-ID: <20140929152041.GB11687@rei>
References: <1411724164-18326-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1411724164-18326-1-git-send-email-zlang@redhat.com>
Subject: Re: [LTP] [PATCH] fs/ext4-inode-version: remove "./" before
 "ext4_get_inode_version.sh" in ext4_test_inode_version.c
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
To: Zorro Lang <zlang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> when I test with ext4-inode-version, I always get "sh ./ext4_get_inode_version.sh: No such file".
> Then I removed "./" of "ext4_get_inode_version.sh" in ext4_test_inode_version.c, everything
> goes well.

That is a valid fix because:

1. It is not guaranteed that test working directory is
$LTPDIR/testcases/bin

2. It is guaranteed that $LTPDIR/testcases/bin is in $PATH

Please resend with a changelog that simply says remove ./ from
./ext4_get_inode_version.sh in ext4_test_inode_version.c.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
