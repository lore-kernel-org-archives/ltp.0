From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Apr 2021 21:03:18 +0200
Subject: [LTP] [PATCH] Set exfat file system to skip symlink
In-Reply-To: <20210428025039.14351-1-zhanglianjie@uniontech.com>
References: <20210428025039.14351-1-zhanglianjie@uniontech.com>
Message-ID: <YImxdsv0lrwGJ50B@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

good catch!

> If the kernel configuration CONF_EXFAT_FS=m, then the exfat test
you mean CONFIG_EXFAT_FS.

> result is TCONF. If the kernel is not configured with CONF_EXFAT_FS=m,
> then the exfat test result will be TBROK (TBROK makes subsequent tests
> impossible). Because the exfat file system does not support symlink,
> the test should skip calling symlink.

I reword the commit message and merged.
Thanks!

Kind regards,
Petr
