From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 13:58:05 +0200
Subject: [LTP] [PATCH] syscalls/clone09.c: Fix compilation without
 CLONE_NEWNET
In-Reply-To: <1500462089-3992-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1500462089-3992-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170719115804.GF1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #include "tst_test.h"
>  #include "clone_platform.h"
>  #include "linux_syscall_numbers.h"
> +#include "lapi/namespaces_constants.h" 
                                         ^
			I've removed this trailing whitespace and
			pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
