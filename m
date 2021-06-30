From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jun 2021 15:24:25 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls: Use more accurate TST_EXP_FAIL2
 macro
In-Reply-To: <60DB0121.9000404@fujitsu.com>
References: <YNHCQ8qWSBdHIAra@yuki>
 <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <60DB0121.9000404@fujitsu.com>
Message-ID: <YNxwiTvI6AcqoLq0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When I do this patch, I found a tst_res usage problem in sendfile06.c.
> 
> see https://github.com/linux-test-project/ltp/runs/2933366481#step:10:3797

Someone has put comma between % and the PRId64 which is obviously wrong.

Fixed in: 0880bf5aa757 (syscalls/sendfile06: Fix format string)

-- 
Cyril Hrubis
chrubis@suse.cz
