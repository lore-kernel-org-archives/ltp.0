Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YYZ9v-0007XR-Ce
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 12:02:43 +0000
Date: Thu, 19 Mar 2015 13:01:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150319120149.GC3724@rei>
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>
	<1426742198-17967-4-git-send-email-bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426742198-17967-4-git-send-email-bamvor.zhangjian@huawei.com>
Subject: Re: [LTP] [RFC PATCH 3/3] ARM64: ILP32: define LTP_USE_64_ABI for
	ILP32
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
To: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: dingtianhong@huawei.com, ltp-list@lists.sourceforge.net, bintian.wang@huawei.com, apinski@cavium.com, yangyingliang@huawei.com

Hi!
> It will affect the testcase fallocatexx, fanotifyxx

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
