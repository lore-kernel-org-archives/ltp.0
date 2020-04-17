From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Apr 2020 17:11:30 +0200
Subject: [LTP] [PATCH v2 01/10] lapi/loop.h: Add fallback for loop ioctl
 and flag
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200417151130.GB2491@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <linux/types.h>
> +#ifdef HAVE_LINUX_LOOP_H
> +# include <linux/loop.h>
> +#endif

I've removed this ifdef and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
