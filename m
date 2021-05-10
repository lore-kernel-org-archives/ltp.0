From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 18:52:41 +0200
Subject: [LTP] [PATCH] bugfix for block_dev_kernel/ltp_block_dev.c
In-Reply-To: <20210510095609.20128-1-dongshijiang@inspur.com>
References: <20210510095609.20128-1-dongshijiang@inspur.com>
Message-ID: <YJlk2UtqenFH+bYk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Add genhd.h and blkdev.h to ltp_block_dev.c.

> Failed at compile time on kernel 5.12 due to change of register_blkdev function definition from linux/fs.h to linux/genhd.h and failure of test case tc05,The reason is that the BLKDEV_MAJOR_MAX definition was changed from fs.h to blkdev.h

Good catch, merged with slightly changed commit message.
Thanks!

Maybe we should not ignore build error for kernel module to catch these API
changes earlier.

Kind regards,
Petr
