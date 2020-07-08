From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jul 2020 16:00:07 +0200
Subject: [LTP] [PATCH v1 3/4] syscalls/ioctl_loop08: Add LOOP_CONFIGURE
 error test with invalid block size
In-Reply-To: <1591871716-21250-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1591871716-21250-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200708140007.GC7276@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * This is a basic ioctl test about loopdevice.
> + * It is designed to test LOOP_CONFIGURE ioctl with invalid block size config.
> + * It is similar with ioctl_loop06.c.
> + */

Actually wouldn't it be easier to just add this to the ioctl_loop06.c?

I guess that we can have a run() function that would execute the
verify_ioctl_loop() with n and also pass flag down which ioctl to use.

-- 
Cyril Hrubis
chrubis@suse.cz
