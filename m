Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMH8K-0006WQ-Mc
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 14:54:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMH8H-0006Sk-DZ
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 14:54:32 +0000
Date: Mon, 3 Aug 2015 16:54:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150803145404.GA7519@rei.suse.de>
References: <1438405111-6640-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438405111-6640-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] define CLONE_NEWNS in case a standard library
 isn't installed.
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
> diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
> index 3a38bc9..60e9e54 100644
> --- a/testcases/kernel/containers/libclone/libclone.h
> +++ b/testcases/kernel/containers/libclone/libclone.h
> @@ -75,8 +75,12 @@
>  #define CLONE_NEWNET		0x40000000
>  #endif
>  
> +#ifndef CLONE_NEWNS
> +#define CLONE_NEWNS		0x00020000
> +#endif

There is a in-flight patch that moves these constants to common place
(include/lapi) and adds this value as well:

[PATCH 1/2 v2] added helper tools for creating and working with namespaces

I will not apply this one, because that will cause unnecessary conflict.

Thanks for the patch anyway.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
