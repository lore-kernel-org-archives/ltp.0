From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 08:31:10 +0200
Subject: [LTP] [PATCH 2/2] kernel/syscalls: Unify the annotation style
 and remove Redundant code
In-Reply-To: <20210402034612.127912-3-xieziyao@huawei.com>
References: <20210402034612.127912-1-xieziyao@huawei.com>
 <20210402034612.127912-3-xieziyao@huawei.com>
Message-ID: <YJokrrfndIMMdvaG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> Change License for Makefile and remove some unnecessary annotation
> in kernel/syscalls.

Thanks, merged!
I slightly modified C code changes - put docparse into clock_nanosleep03.c and
clock_gettime03.c and modified the commit message.

Next time it'd be better to separate these changes - put Makefile changes into
separate commit and ideally use script to replace all of them.

Kind regards,
Petr
