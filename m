From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 15:47:00 +0200
Subject: [LTP] [PATCH 1/2] epoll_pwait: Add invalid sigmask test for
 epoll_pwait04
In-Reply-To: <20210810110024.106436-2-xieziyao@huawei.com>
References: <20210810110024.106436-1-xieziyao@huawei.com>
 <20210810110024.106436-2-xieziyao@huawei.com>
Message-ID: <YRPU1K78DU9sul4y@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, -1, tst_get_bad_addr(NULL)),
> +		     EFAULT, "with an invalid sigmask pointer");

The tst_get_bad_addr() allocates memory so I've moved it to the test
setup() so that the test does not get out of memory with large enough -i
option.


Patchset pushed, good work, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
