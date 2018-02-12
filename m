From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Feb 2018 17:22:58 +0100
Subject: [LTP] [PATCH 1/4] lib/get_high_address.c: Add
 tst_get_high_address.h for new API
In-Reply-To: <1518163011-23322-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1518163011-23322-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180212162258.GA26897@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Make sure get_high_address() can be used by new API.

I would he happier if we created better API for the new library. If
nothing else the function name is poorly choosen.

I would suggest naming it as tst_get_bad_addr() which better explains
what the return value.

Also looking at the code we seem to use several different ways of
triggering EFAULT:

* (void*)-1;

* get_high_address() which is sbrk(0) + 4 * PAGE_SIZE

* mmap() with PROT_NONE

I gueess that we may as well unify on one of these, all of them should
work but I suppose that mmap() with PROT_NONE would be safest bet here.

-- 
Cyril Hrubis
chrubis@suse.cz
