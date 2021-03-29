From: zhaogongyi <zhaogongyi@huawei.com>
Date: Mon, 29 Mar 2021 02:22:49 +0000
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389DCCF@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Yes, I find the problem in my testing of qemu with kernel version 4.4 and the config is vexpress_defconfig.
Specifically as follow:

tst_test.c:1294: TINFO: Timeout per run is 0h 05m 00s
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with nobody user
TST_RET: 0 SHM_STAT_ANY: 15
shmctl04.c:134: TFAIL: SHM_INFO haven't returned a valid index: EINVAL (22)
shmctl04.c:150: TFAIL: Counted used = 0, used_ids = 1
shmctl04.c:85: TPASS: used_ids = 1
shmctl04.c:92: TPASS: shm_rss = 0
shmctl04.c:99: TPASS: shm_swp = 0
shmctl04.c:106: TPASS: shm_tot = 1
shmctl04.c:119: TINFO: Test SHM_STAT_ANY with root user
TST_RET: 0 SHM_STAT_ANY: 15
shmctl04.c:134: TFAIL: SHM_INFO haven't returned a valid index: EINVAL (22)
shmctl04.c:150: TFAIL: Counted used = 0, used_ids = 1
shmctl04.c:85: TPASS: used_ids = 1
shmctl04.c:92: TPASS: shm_rss = 0
shmctl04.c:99: TPASS: shm_swp = 0
shmctl04.c:106: TPASS: shm_tot = 1

Summary:
passed   8
failed   4
broken   0
skipped  0
warnings 0


I will analysis the root cause of fail later.

Thanks!

Best Regards,
Gongyi


???: Li Wang [mailto:liwang@redhat.com]
????: 2021?3?29? 10:10
???: zhaogongyi <zhaogongyi@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno



On Mon, Mar 29, 2021 at 9:56 AM zhaogongyi <zhaogongyi@huawei.com<mailto:zhaogongyi@huawei.com>> wrote:
Hi Li,

Actually, I have no effective tools to find out all of this type problems.

Indeed, the wrong usage of TTERRNO you find mostly occurred in bad code logic.
That's hard to correct them in an automatic way.

--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/cea3a9a1/attachment-0001.htm>
