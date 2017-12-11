From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Dec 2017 16:48:06 +0100
Subject: [LTP] [PATCH 2/2] syscalls/brk: limit the largest requesting
 memory to UINT_MAX
In-Reply-To: <1508902611-28530-2-git-send-email-lizhijian@cn.fujitsu.com>
References: <1508902611-28530-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1508902611-28530-2-git-send-email-lizhijian@cn.fujitsu.com>
Message-ID: <20171211154806.GC12716@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sometimes(some platforms), sbrk(0) will return a huge address(e.g
> Beg_brk_val=94392102215680), it will lead to the request a huge
> memory by brk(size>1T) which beyonds most host memory size

I think that the code in the setup that determines the Max_brk_byte_size
does not make any sense to me, it seems to just multiply random value
(the initial break addres) by 4 and uses that as a base for increment. I
guess that it would be much better if we just choosen some multiple of
page size for the test.

Also the test should be running several iterations but we run only one
by default.

All in all I think that it would be much better if we rewrote the test
from scratch using the new test library instead of applying band aids
to problems that are broken by design.

In short, do you want to take on rewriting the test or should I do that?

-- 
Cyril Hrubis
chrubis@suse.cz
