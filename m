Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YYZ95-0006zK-V8
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 12:01:51 +0000
Date: Thu, 19 Mar 2015 13:00:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150319120058.GB3724@rei>
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>
	<1426742198-17967-3-git-send-email-bamvor.zhangjian@huawei.com>
	<20150319114902.GA3724@rei>
	<18FC2E80-AF7B-408C-8863-B4FC532B5CD4@caviumnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18FC2E80-AF7B-408C-8863-B4FC532B5CD4@caviumnetworks.com>
Subject: Re: [LTP] [RFC PATCH 2/3] ARM64: ILP32: cast for negtive off_t
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
To: "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "bintian.wang@huawei.com" <bintian.wang@huawei.com>, "yangyingliang@huawei.com" <yangyingliang@huawei.com>, "apinski@cavium.com" <apinski@cavium.com>, "dingtianhong@huawei.com" <dingtianhong@huawei.com>

Hi!
> 32bit unsigned value

Ah, right, size_t is unsigned, that explains it.

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
