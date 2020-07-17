From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Jul 2020 09:38:42 +0200
Subject: [LTP] [PATCH] lapi/io_uring.h: Add declaration of __kernel_rwf_t
In-Reply-To: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200717073842.GA31254@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Since kernel commit ddef7ed2b5cb ("annotate RWF_... flags"), fs.h introduced
>  __kernel_rwf_t data type in 4.14-rc1.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks for the fix.
Going to merge it, just wait for travis verification.

Kind regards,
Petr
