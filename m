From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Nov 2020 17:47:42 +0100
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
Message-ID: <20201106164742.GA6449@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have a doubt after reading Xu's patch[1] and Martin's patch[2]:
> 
> 1) Xu removed sync01 because sync() always return 0.

Actually sync() is defined as void function, so the tests were bogusly
checking the TST_RET value which haven't been set at all.

-- 
Cyril Hrubis
chrubis@suse.cz
