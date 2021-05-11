From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 11 May 2021 16:37:04 +0800
Subject: [LTP] [PATCH 1/2] kernel/syscalls: Modify incorrect use of
 TERRNO and replace functions with safe_macros
In-Reply-To: <YJolByrF7vYDiY5/@pevik>
References: <20210402034612.127912-1-xieziyao@huawei.com>
 <20210402034612.127912-2-xieziyao@huawei.com> <YJolByrF7vYDiY5/@pevik>
Message-ID: <bf3d85c1-fd9b-e7fd-c522-21b4fb7d5b44@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr,

>> - modify some incorrect use of TERRNO/TTERRNO in kernel/syscalls;
I just re-checked the latest code and submit the v2 version.

Please see: 
https://patchwork.ozlabs.org/project/ltp/patch/20210511082644.110124-1-xieziyao@huawei.com/

>> - replace functions with safe_macros to check the return value in kernel/syscalls.
As for this type of modification, I'll try to use script to replace all 
of them.

> These two would be really better to put 2 commits.
> 
> Kind regards,
> Petr
> .
> 

Thanks for your review.

Kind Regards,
Ziyao
