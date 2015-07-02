Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAf52-0007sF-Os
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 14:03:08 +0000
Date: Thu, 2 Jul 2015 16:01:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702140143.GA20648@rei.suse.de>
References: <1435728227-9753-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435728227-9753-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH V2] filecaps: Remove unnecessary c.c file.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The c.c file is the same as check_simple_capset.c except config.h
> is included in check_simple_capset.c. Moreover, it is not correct
> to use HAVE_SYS_CAPABILITY_H without including config.h.

Applied, thanks.

BTW it looks like check_simple_capset is not called from anywhere
either. At least 'git grep check_simple_capset' does not return
anything but .gitignore file. So if that does not break the tests we
should remove it as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
