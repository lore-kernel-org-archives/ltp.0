From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Jan 2021 14:47:57 +0100
Subject: [LTP] [PATCH v3 3/3] syscalls: Take use of TST_EXP_PASS_SILENT
In-Reply-To: <6008E512.50704@cn.fujitsu.com>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
 <20210112020227.11775-3-yangx.jy@cn.fujitsu.com>
 <YAgHUvIge6svN0gu@yuki.lan> <6008E512.50704@cn.fujitsu.com>
Message-ID: <YArXjchkIvhgjsg3@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> BTW, I just want to avoid many TPASS for a subtest.

Why? The capget01 clearly does two different tests per iteration.

There is absolutely no correlation between the number of TPASS test
produces and the number of iteration test does.

-- 
Cyril Hrubis
chrubis@suse.cz
