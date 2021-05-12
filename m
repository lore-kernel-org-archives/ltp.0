From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 12 May 2021 16:51:12 +0800
Subject: [LTP] [PATCH 2/2] kernel/syscalls: Unify the annotation style
 and remove Redundant code
In-Reply-To: <YJokrrfndIMMdvaG@pevik>
References: <20210402034612.127912-1-xieziyao@huawei.com>
 <20210402034612.127912-3-xieziyao@huawei.com> <YJokrrfndIMMdvaG@pevik>
Message-ID: <d8929fa4-e39c-3b87-cd4e-c9aeea0f9ecb@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr,

> Next time it'd be better to separate these changes - put Makefile changes into
> separate commit and ideally use script to replace all of them.
For all the testsuite that has used SPDX, I've also used script and 
shell commands to modify its Makefile to use SPDX.

Please take a look at this patch: 
https://patchwork.ozlabs.org/project/ltp/patch/20210512084904.35159-1-xieziyao@huawei.com/

Kind Regards,
Ziyao
