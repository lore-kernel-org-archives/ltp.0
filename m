From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 13:40:34 +0200
Subject: [LTP] [PATCH 2/4] syscalls/socket02: reconstruct and convert to
 new API
In-Reply-To: <1466759093-15755-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1466759093-15755-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160726114033.GA11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -/* For Linux these must be the same.  */
>  #ifndef SOCK_CLOEXEC
>  #define SOCK_CLOEXEC O_CLOEXEC
>  #endif
>
> +#ifndef SOCK_NONBLOCK
> +#define SOCK_NONBLOCK O_NONBLOCK
> +#endif

I've moved these definitions to lapi/fcntl.h (so that we have only one
place that defines these) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
