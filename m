Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YGPbw-0002z5-3f
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 10:12:36 +0000
Date: Wed, 28 Jan 2015 11:12:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150128101221.GA22007@rei.suse.de>
References: <1422323457-184525-1-git-send-email-shengyong1@huawei.com>
	<1422323457-184525-5-git-send-email-shengyong1@huawei.com>
	<20150127144652.GC16759@rei.suse.de> <54C83795.20809@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54C83795.20809@huawei.com>
Subject: Re: [LTP] [RESEND PATCH v3 4/4] syscall/{rename11,
 renameat01}: do not test EMLINK if subdir limit not availiable
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
To: shengyong <shengyong1@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Or is there really reason why we need to differentiate between these two
> > conditions?
> This is also what I'm a little confused. Use different return values, I just
> think we should distinguish different situations. If it returns -1 (or some
> other appropriate values), then we can just skip the test, and this is why
> I passed TPASS to tst_resm() in v2. If it returns 0, which means the fs has
> the limit, but we cannot reach it, something may go wrong (or be changed).

The TCONF flag means "test is not appropriate for current configuration"
which is the case in both cases.

I simply do not see a difference between the case where we know that the
filesystem has no limit and skip the test and the case where we try and
find out that the filesystem has no limit. So I just argue that the
return value for both cases should be 0 because it does not much sense
to distinguish these two in the actuall test.

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
