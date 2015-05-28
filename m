Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YxvGj-0001gM-Tc
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 10:42:33 +0000
Date: Thu, 28 May 2015 12:41:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150528104140.GB3192@rei.suse.de>
References: <20150518131209.GH4104@rei>
	<1432264251-27223-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1432264251-27223-2-git-send-email-zenglg.jy@cn.fujitsu.com>
	<20150527145330.GC13878@rei.suse.de>
	<1432809128.11403.53.camel@G08FNSTD140232>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432809128.11403.53.camel@G08FNSTD140232>
Subject: Re: [LTP] [PATCH v3 2/2] commands/df: Added new testcase to test
 df(1) command.
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
Cc: ltp-list@lists.sourceforge.net, jy_zhangjin@cn.fujitsu.com

Hi!
> > Why can't we calculate the expected free space based on the size of
> > the
> > device?
> 
> Hmm, I do not think it is suitable to calculate the size. 'df' report
> file system disk space usage, which means it just only report the count
> of all the data block. super block, group descriptor and others will not
> include.
> 
> ps:
> ext2 file system:
> +--------------+---------+---------+-----+---------+
> | boot section | group 0 | group 1 | ... | group n |
> +--------------+---------+---------+-----+---------+
> group n:
> +-------+------------+------------+--------+-------+-------+
> | super |    group   | data block | inode  | inode | data  |
> | block | descriptor |   bitmap   | bitmap | table | block |
> +-------+------------+------------+--------+-------+-------+
> 
> 
> >  Does the space taken by the ext2 internal data structures
> > vary unpredictedly?
> > 
> 
> If we specify the block size, inode size and super block, we could get
> the size of data block. BTW, mkfs use sparse_super as default option,
> that means not every group has superblock backup copies. That make it
> hard to calculate the size of data block.

Quite complicated indeed.

Another idea may be to measure the difference in free space before and
after we create a file.

1. create an empty file
1. get free space
2. fill the file with well defined amount of data
3. get free space, check that the difference matches
   the expectation

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
