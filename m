From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 27 Jul 2021 20:56:25 +0800
Subject: [LTP] [PATCH 3/3] epoll_pwait: Add test variants for
 epoll_pwait2 in epoll_pwait01
In-Reply-To: <20210727124507.28356-4-xieziyao@huawei.com>
References: <20210727124507.28356-1-xieziyao@huawei.com>
 <20210727124507.28356-4-xieziyao@huawei.com>
Message-ID: <071b54f4-9d43-f1ed-0f7b-1e2ea3c4d381@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Add test variants to switch between epoll_pwait and epoll_pwait2.
testcases/kernel/syscalls/epoll_pwait/epoll_pwait.h can also be deleted 
in this commit, which is a minor mistake.

> 
> Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
> ---
>   .../syscalls/epoll_pwait/epoll_pwait01.c      | 234 ++++++------------
>   1 file changed, 80 insertions(+), 154 deletions(-)
Kind Regards,
Ziyao
