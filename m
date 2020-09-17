From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Sep 2020 15:51:54 +0200
Subject: [LTP] [PATCH] device-drivers/zram: zram_lib: Fix modinfo's usage
In-Reply-To: <20200917081917.31510-1-ycliang@andestech.com>
References: <20200917081917.31510-1-ycliang@andestech.com>
Message-ID: <20200917135154.GA5785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> zram_lib uses the exit code of modinfo to determine the presence of zram module,
> but the exit code does not have direct relation to it.

What distribution is this? Where did the modinfo binary came from?

It works fine with modinfo from the kmod packages, see:

https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/tools/modinfo.c#n463

-- 
Cyril Hrubis
chrubis@suse.cz
