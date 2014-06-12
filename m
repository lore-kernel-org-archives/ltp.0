Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wv8s5-00085q-Uz
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 17:33:06 +0000
Date: Thu, 12 Jun 2014 19:32:53 +0200
From: chrubis@suse.cz
Message-ID: <20140612173253.GA5669@rei>
References: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] lib: add tst_fs_link_count.c
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
> +/*
> + * lib/tst_fs_link_count.c
> + * Try to get maximum number of subdirectories under directory @dir in a
> + * mounted file system.
> + * In its implementation, it uses mkdir(2) to create numbers of subdirectories
> + * in @dir, try to reach the limit and will try at most 65535 times. If EMLINK
> + * is hit, we can think the maximum number has been reached, return this number.
> + * Meanwhile under directory @dir: there will be numbers of subdirectories,
> + * Like below:
> + * testdir1, testdir2, testdir3, ..., testdir${returned number}.
> + * If some errors(ENOSPC, EDQUOT) occur or no errors at all, we can think that
> + * the maximum number of subdirectories is infinite or not reachable because
> + * of filesystem's free space, for this case, return 0.
> + * If some other errors occur, we call tst_brkm(TBROK, ...).
> + */
> +int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);

This function actually tries to figure out maximal number of elements a
directory can hold (it does not matter if these are files or
directories). So it should be renamed to tst_fs_fill_dir().

Moreover I've been unable to get EMLINK for any filesystem in this case,
it looks like ENOSPC is what you get when maximal number of elemenents
in directory is reached (the free space on filesystem is fine but you
are out of inodes/clusters etc).

I have, slightly modified version of this patch I will commit once this
function is figured out but before I do so I wanted to ask if you plan
to use this function for any testcase? If not I would remove it because
as it is it's not implemented correctly and fixing it would require more
research and effort.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
