From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jun 2020 16:08:52 +0200
Subject: [LTP] [PATCH V2 6/6] syscalls: Don't pass struct timeval to
 tst_syscall()
In-Reply-To: <bea4b8f60091c44e43e71539fd8f177dce639b15.1590130423.git.viresh.kumar@linaro.org>
References: <cover.1590130423.git.viresh.kumar@linaro.org>
 <bea4b8f60091c44e43e71539fd8f177dce639b15.1590130423.git.viresh.kumar@linaro.org>
Message-ID: <20200617140852.GA30348@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <asm/posix_types.h>

I've removed this since the header already includes lapi/posix_types.h
and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
