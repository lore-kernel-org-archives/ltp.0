From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Oct 2018 16:17:25 +0200
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix missing ramdisk
	module error
In-Reply-To: <20181008154620.25237-1-rafael.tinoco@linaro.org>
References: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
 <20181008154620.25237-1-rafael.tinoco@linaro.org>
Message-ID: <20181009141725.GD16630@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define DRVRAMDISK "brd"

I find it a bit silly to define a macro for a string that is used
exactly once. Why can't we just write "brd", in the needed_drivers?

-- 
Cyril Hrubis
chrubis@suse.cz
