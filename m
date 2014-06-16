Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WwXY4-0004Sz-0v
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 14:06:12 +0000
Date: Mon, 16 Jun 2014 16:05:56 +0200
From: chrubis@suse.cz
Message-ID: <20140616140556.GA18761@rei.suse.cz>
References: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140612173253.GA5669@rei> <539A8784.7010709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <539A8784.7010709@cn.fujitsu.com>
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
> > This function actually tries to figure out maximal number of elements a
> > directory can hold (it does not matter if these are files or
> > directories). So it should be renamed to tst_fs_fill_dir().
> Indeed there is difference between creating files and directories. When creating a regular file under a
> directory, the directory's inode count won't be increased, but if creating a sub-directory in a directory,
> the parent directory's inode count will be increased(add 1). This is because the ".." in the created
> sub-directory will point to the parent directory's inode. For regular files, there is no need to increase
> parent's inode count.
> This url has an explanation: http://www.vidarholen.net/contents/blog/?p=18
> 
> Steps to verify this:
> # mkfs.ext3 -N 80000 /dev/loop0
> # mount -t ext3 /dev/loop0 mntpoint/; cd mntpoint
> # mkdir lege; cd lege
> 
> # for ((i=1; i<= 40000; i++)); do touch $i; done; # this will succeed and you will create 40000 regular files.
> 
> # for ((i=1; i<= 40000; i++)); do mkdir $i; done;
> this will fail. in ext3, you are only allowed to create 31998 sub-directories(there is already "." and "..")
> This limit is imposed by " #define EXT3_LINK_MAX 32000" defined in ext3 kernel source code.
> For ext2, the limit is also 32000. for ext4, this is 65000 or infinite, which depends whether dir_index
> feature is enabled.

You are right. I've been confused because the fs I've created was too
small, so the default number of inodes was less than the limit and it
failed with ENOSPC in this case.

And because of that the limit for maximal number of directories and
files in a directory seemed to be the same.

Both creating a bigger loop device and explicitly setting the number of
inodes for mkfs fixes the problem.

> > I have, slightly modified version of this patch I will commit once this
> > function is figured out but before I do so I wanted to ask if you plan
> > to use this function for any testcase? If not I would remove it because
> 
> Yeah, this function will be used.
> For rename(2) or renameat(2)'s EMLINK test, the manpage sasys that:
> EMLINK The file named by old is a directory, and the link count of  the
>               parent directory of new would exceed {LINK_MAX}.
> We need to use tst_fs_fill_subdirs() to construct the condition.

Ok, I will push (slightly modified version).

I did a few small changes:

* it creates the directory automatically if it does not exist

* uses tst_resm() instead of printf()

* changed the file/directory numbering to start from 0
  which simplifies the code a bit

* added two simple tests under lib/tests/

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
