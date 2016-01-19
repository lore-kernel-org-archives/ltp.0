From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2016 18:21:41 +0100
Subject: [LTP] [PATCH] device-drivers/uaccess: use linux/uaccess.h
In-Reply-To: <1453218464-13605-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1453218464-13605-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160119172141.GA17351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #include <linux/module.h>
>  #include <linux/device.h>
> -#include <asm-generic/uaccess.h>
> +#include <linux/uaccess.h>

Looks good, acked.

Btw, grepping "uaccess.h" in linux/drivers/ shows either linux/uaccess.h
or asm/uaccess.h but no asm-generic/uaccess.h.

-- 
Cyril Hrubis
chrubis@suse.cz
