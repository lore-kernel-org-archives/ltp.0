From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2020 15:57:33 +0100
Subject: [LTP] [PATCH 2/2] syscalls/uname02: Convert to new API and
 cleanup
In-Reply-To: <20201106065014.1118435-2-yangx.jy@cn.fujitsu.com>
References: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
 <20201106065014.1118435-2-yangx.jy@cn.fujitsu.com>
Message-ID: <20201111145733.GC16874@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(uname((struct utsname *)-1));

Can we get a bad address by calling tst_get_bad_addr() in the test setup
plase?

Otherwise the rest is good.

-- 
Cyril Hrubis
chrubis@suse.cz
