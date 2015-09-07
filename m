Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZ0hf-0002fx-4R
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 17:59:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZ0hd-0006SV-Rn
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 17:59:39 +0000
Date: Mon, 7 Sep 2015 19:58:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150907175852.GB7580@rei.suse.cz>
References: <1441586639-57352-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441586639-57352-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH] include/linux_syscall_numbers.h:Delete
 linux_syscall_numbers.h
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi!
> Delete linux_syscall_numbers.h in LTP otherwise it will not be
> compiled when do 'make':
> make: Nothing to be done for `all'.

Looks like the reason why the file was added to git in the first place
is that the script is relatively slow (takes seconds on new enough
machine). Does that still concern anybody?

I guess that what you are trying to solve is that the file is not up to
date and it's not updated automatically because the timestamp for the
*.in files is the same as the linux_syscall_numbers.h since the files
were created at the same time when the git was checked up.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
