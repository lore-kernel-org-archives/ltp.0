From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Mon, 29 Mar 2021 02:31:32 +0000
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCCF@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCCF@dggeml531-mbx.china.huawei.com>
Message-ID: <60613C0B.4000604@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi

The SHM_STAT_ANY cmd was introduced since kernel 4.17. I guess we should 
add check for it.
> Hi Li,
>
> Yes, I find the problem in my testing of qemu with kernel version 4.4
> and the config is vexpress_defconfig.
>
> Specifically as follow:
>
> tst_test.c:1294: TINFO: Timeout per run is 0h 05m 00s
>
> shmctl04.c:119: TINFO: Test SHM_STAT_ANY with nobody user
>
> TST_RET: 0 SHM_STAT_ANY: 15
>
> shmctl04.c:134: TFAIL: SHM_INFO haven't returned a valid index: EINVAL (22)
>
> shmctl04.c:150: TFAIL: Counted used = 0, used_ids = 1
>
> shmctl04.c:85: TPASS: used_ids = 1
>
> shmctl04.c:92: TPASS: shm_rss = 0
>
> shmctl04.c:99: TPASS: shm_swp = 0
>
> shmctl04.c:106: TPASS: shm_tot = 1
>
> shmctl04.c:119: TINFO: Test SHM_STAT_ANY with root user
>
> TST_RET: 0 SHM_STAT_ANY: 15
>
> shmctl04.c:134: TFAIL: SHM_INFO haven't returned a valid index: EINVAL (22)
>
> shmctl04.c:150: TFAIL: Counted used = 0, used_ids = 1
>
> shmctl04.c:85: TPASS: used_ids = 1
>
> shmctl04.c:92: TPASS: shm_rss = 0
>
> shmctl04.c:99: TPASS: shm_swp = 0
>
> shmctl04.c:106: TPASS: shm_tot = 1
>
> Summary:
>
> passed   8
>
> failed   4
>
> broken   0
>
> skipped  0
>
> warnings 0
>
