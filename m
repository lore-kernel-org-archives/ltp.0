Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YL84t-0006G3-KL
	for ltp-list@lists.sourceforge.net; Tue, 10 Feb 2015 10:29:59 +0000
Date: Tue, 10 Feb 2015 11:29:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150210102938.GA19800@rei.suse.de>
References: <20150203095709.GB15330@rei.scz.novell.com>
	<1423040387-2029-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1423040387-2029-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1423206548.27888.29.camel@dhcp-13-206.nay.redhat.com>
	<54D46997.6050704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54D46997.6050704@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/mmap16: regression test for data
 corruption when blocksize < pagesize for mmaped data
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
> > I found there are two new LTP changes have been applied, which would be
> > probably impact to your case:
> > commit aabb8340f63ed31afe995fd97795e542dc68b93c
> >     Include usctest.h in test.h
> > commit 605fa3362fd7cef0baa2131be32cf44661783d3e
> >     Get rid of TEST_CLEANUP
> > 
> > Seems we should remove two lines of the testcase as below otherwise it 
> > can't be compile.
> 
> OK, thanks!
> I'll send V3 next Monday, in case somebody has other comments ;)

I've fixed that along with two smaller fixes and pushed the patches.

Thanks.

* The getpagesize() cannot fail so I've deleted the check for negative
  return value

* I've changed the cleanup to do the chdir("..") only if the chdir to
  MNTPOINT was successful. Otherwise it may have fail if the cleanup
  was called from the setup before the chdir() was done.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
