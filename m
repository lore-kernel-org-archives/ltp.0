Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEafU-0008U2-Mc
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 10:09:00 +0000
Date: Mon, 13 Jul 2015 12:07:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713100728.GA2900@rei.suse.de>
References: <1436407199-12492-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436407199-12492-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syscalls/getrandom: remove reference to
 '<linux/random.h>'
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
> Given that we use ltp_syscall() to call getrandom(2) and already
> have "GRND_RANDOM, GRND_NONBLOCK" defined in lapi/getrandom.h, indeed
> we don't need to include '<linux/random.h>'. Also including
> '<linux/random.h>'' will result in some compilation errors in older
> linux distribution, for example, in RHEL5.11GA, there will be such
> errors:
>   In file included from getrandom01.c:29:
>   /usr/include/linux/random.h:38: error: expected specifier-qualifier-list before ???__u32???
>   /usr/include/linux/random.h:42: error: expected specifier-qualifier-list before ???__u32???
> This patch will also fix these compilation errors.

This is not correct.

The lapi/getrandom.h defines these as fallback definitions only if they
are not defined allready. And we really want to use the defines from the
system if they are available to ensure that they are correct.

The system header on older distros likely misses to include
linux/types.h to get the kernel types defined.

What about moving the #include <linux/random.h> to start of
lapi/getrandom.h and including <linux/types.h> there as well if needed
(would require configure check).

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
